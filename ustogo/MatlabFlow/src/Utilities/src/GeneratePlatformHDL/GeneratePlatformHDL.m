%%  Copyright (C) 2014-2018  EPFL
%   ustogo: ultrasound processing Matlab pipeline
%  
%   Permission is hereby granted, free of charge, to any person
%   obtaining a copy of this software and associated documentation
%   files (the "Software"), to deal in the Software without
%   restriction, including without limitation the rights to use,
%   copy, modify, merge, publish, distribute, sublicense, and/or sell
%   copies of the Software, and to permit persons to whom the
%   Software is furnished to do so, subject to the following
%   conditions:
%  
%   The above copyright notice and this permission notice shall be
%   included in all copies or substantial portions of the Software.
%  
%   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
%   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
%   OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
%   NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
%   HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
%   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
%   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
%   OTHER DEALINGS IN THE SOFTWARE.
%
%% NOTE: this script will generate HDL files that are valid for the beamformer
%% configuration simulated in this Matlab run.
%% When running Matlab over a set of configurations (via a tests.txt file or
%% manually), it is:
%
% IMPOSSIBLE to vary major settings such as 2D/3D, radial/azimuth/elevation
% line counts, etc.. Only the configuration from the latest run will make
% it onto the FPGA.
%
% POSSIBLE to support different zone/compounding counts into a single
% bitstream. Read the notes below for important information.
%
% - For some files (e.g. zone_imaging_origin/compounding_imaging_origin)
% the script takes care of computing multiple permutations of possible
% parameter values and merges them all in a single "universal" file.
%
% - For some files (e.g. rf* sample inputs, settings.txt) the script
% generates files that are unique for this Matlab configuration run. This
% should be OK as these outputs will be stored in individual, independent
% directories, and NOT compiled into the bitstream but just used for
% simulation/GUI inputs; by running the flow iteratively with different probe
% configurations, a database of these files can be progressively filled in.
%
% - Some files (e.g. sin/cos constants) do get compiled into the bitstream
% but will be identical over different runs (so long as basic geometric
% parameters are kept constant) and therefore can be safely generated only
% once, or overwritten each time.
%
% - The file parameters.v contains multiple settings, some of which will
% get compiled into the bitstream and some which will only be used for
% simulation. The former will stay constant through runs (so long as basic
% geometric parameters are kept constant), while the latter will change
% every time. Therefore running multiple passes will still generate a
% "universal" bitstream, but if simulation is desired, it should be run for
% the last configuration in the Matlab session, and/or the parameters.v
% file should be manually edited.
%
% - Finally, a few of the files that get compiled into the bitstream
% (offset*) will change for different configurations of the beamformer.
% The only way to generate these files in a "universal" version (that will
% yield a bitstream that works for all supported configurations) is to pass
% as an input to this function a pre-processed version of the offset_min
% and offset_max inputs, that contains respectively the minimum and the
% maximum values of those arrays across all simulations.

function [adc_precision, offset_min] = GeneratePlatformHDL(probe, image, target_phantom, ext_target_phantom, zone_count, compounding_count, downsampling_factor, sim_path, bf_rtl_path, sc_rtl_path, apod_full, offset_min, offset_max, generate_rtl, generate_rf)

    if (zone_count ~= 1 && compounding_count ~= 1)
        error('Simultaneous zone imaging and compounding not supported.');
    end
    
    % Precision of the system ADCs, in bits
    % Real systems are between 12 and 16.
    % Max supported: 16 bits (we transfer two samples in 32 bits)
    adc_precision = 16;
    % Precision of the apodization representation, in bits of the fractional part
    % Max supported: 16 bits (the value is positive 0 <= a <= 1, and we store in a 18-bit BRAM in two's complement)
    apodization_precision = 16;
    % Precision of the low-pass filter coefficients, in bits of the fractional part
    lp_precision = 28;

    % Maximum (2^log_samples_depth) input samples per image supported.
    if (generate_rf == 1)
        [max_radius, ~, ~, ~, ~] = LoadRFDataMatrixMetadataFromDisk(target_phantom);
    else
        max_radius = 0;
    end
    max_offset = max(offset_max(:));
    log_samples_depth = nextpow2(max(max_radius, max_offset));
    
    % Number of samples used for each element to reconstruct a nappe.
    if (probe.is2D == 0)
        bram_samples_per_nappe = 1024;
    else
        bram_samples_per_nappe = 512;
    end
    
    % Attenuation coefficient [dB/cm]
    atten_dB_cm = 1;
    
    gen_timer = tic;

    % First, consider the delay from emission to the signal peak.
    excitation_impulse = conv(probe.impulse_response, conv(probe.impulse_response, probe.excitation));
    excitation_envelope = abs(hilbert(excitation_impulse));
    excitation_peak_time = find(excitation_envelope == max(excitation_envelope));

    [image_upper_limit_m, image_lower_limit_m, image_upper_limit_N, image_lower_limit_N, xz_sector, yz_sector] = GetPhantomCoordinates(probe, image);
    focal_points_per_depth = (image_lower_limit_N - image_upper_limit_N) / image.radial_lines;
    
    if (probe.is2D == 0)
        N_elements_x = probe.N_elements;
        N_elements_y = 1;
        pitch_x = probe.pitch;
        pitch_y = probe.pitch;
        transducer_width = probe.transducer_width;
        transducer_height = probe.height;
        height = probe.height;
        width = probe.width;
        total_insonifications = compounding_count * zone_count;
        yz_sector = 0;
        elevation_lines = 1;
        % For uniformity with the 3D case, give the apod_full matrix a new shape
        new_apod = zeros(N_elements_y, N_elements_x, size(apod_full, 2));
        new_apod(1, :, :) = apod_full;
        apod_full = new_apod;
        % Now N_elements_y x N_elements_x x time
    else
        N_elements_x = probe.N_elements_x;
        N_elements_y = probe.N_elements_y;
        pitch_x = probe.pitch_x;
        pitch_y = probe.pitch_y;
        transducer_width = probe.transducer_width;
        transducer_height = probe.transducer_height;
        height = probe.height;
        width = probe.width;
        total_insonifications = compounding_count * zone_count * zone_count;
        elevation_lines = image.elevation_lines;
    end
    
    if ~exist(bf_rtl_path, 'dir')
        error('The following directory for HDL output does not exist: %s', bf_rtl_path);
    end
    if ~exist(sc_rtl_path, 'dir')
        error('The following directory for HDL output does not exist: %s', sc_rtl_path);
    end
    if ~exist(sim_path, 'dir')
        error('The following directory for output does not exist: %s', sim_path);
    end
    if ~exist(strcat(sim_path, 'sim_nappes'), 'dir')
        mkdir(strcat(sim_path, 'sim_nappes'));
    end

    if (generate_rtl == 1)
        %% Delete leftover files from a previous run
        disp('Deleting old files...');
        launch_folder = pwd;

        % If the previous run had more elements etc., old files may be left
        % behind and not overwritten. Check for a specific file mask for
        % safety. The other files will be just overwritten.
        cd(bf_rtl_path);
        old_files = dir('mem_init_*.txt');
        for file_index = 1 : size(old_files, 1)
            delete(old_files(file_index).name);
        end
        
        %% Generate VHDL package files
        disp('Generating configuration files...');
        
        k = 1;
        xO = [];
        yO = [];
        zO = [];
        tx_offsets = [];
        % Create an origin table for 1(2D)/1x1(3D), 2(2D)/2x2(3D), 4(2D)/4x4(3D), 8(2D)/8x8(3D) zones
        % TODO Limited by:
        % - Matlab toolchain (2D supports any zone count, but in 3D the zone count must be "square"); also #zones <= #lines 
        % - this script (supported zone counts: 1, 2, 4, 8 per axis)
        % - code in nappe_buffer
        % - code in delay_top (supported zone counts: 1, 2, 4, 8 per axis)
        % - code in delay_steer (requires the line count to be exactly divisible by the number of zones)
        % - BFIP AXI master (requires power-of-2 run count and assumes zone area is multiple of 8)
        % - GUI/MB configuration communication (which supports up to 99x99 zones)
        % - BFIP option registers (which support up to 31x31 zones)
        % - and maybe others???
        for i = 0 : 3
            this_zone_count = 2 ^ i;
            % TODO assumes zone_count the same in X and Y
            virtual_source_radius = (probe.transducer_width / 2) / tan(xz_sector / this_zone_count / 2) * probe.fs / probe.c;
            tx_offsets(i + 1) = virtual_source_radius; % number of time samples between the imaginary excitation at O and the wave reaching the central probe elements
            zone_width = xz_sector / this_zone_count;
            if (probe.is2D == 0)
                this_total_zones = this_zone_count;
                zone_height = 0;
            else
                this_total_zones = this_zone_count * this_zone_count;
                zone_height = yz_sector / this_zone_count;
            end
            for zone_index = 1 : this_total_zones
                zone_central_angle_azimuth =  - xz_sector / 2 + mod(zone_index - 1, this_zone_count) * zone_width + (zone_width / 2);
                zone_central_angle_elevation = - yz_sector / 2 + (floor((zone_index - 1) / this_zone_count)) * zone_height + (zone_height / 2);
                xO(k, 1) = - virtual_source_radius * sin(zone_central_angle_azimuth);
                yO(k, 1) = - virtual_source_radius * sin(zone_central_angle_elevation) * cos(zone_central_angle_azimuth);
                zO(k, 1) = - virtual_source_radius * cos(zone_central_angle_elevation) * cos(zone_central_angle_azimuth);
                k = k + 1;
                % Note that in 2D, these indices will be different from 3D:
                % 2D: i = 0, k = 1 (1 zone)
                %     i = 1, k = 2, k = 3 (2 zones)
                %     i = 2, k = 4, k = 5, k = 6, k = 7 (4 zones)
                %     ...
                % 3D: i = 0, k = 1 (1x1 zone)
                %     i = 1, k = 2, k = 3, k = 4, k = 5 (2x2 zones)
                %     i = 2, k = 6 to k = 21 (4x4 zones)
                %     ...
            end
        end
        origin_point = cat(2, xO, yO, zO);
        % 14.4 format
        mat2vhdl2D(origin_point, 'zone_imaging_origin');

        % Create an origin table for 1- to 17- compounding
        % TODO could make this more configurable?
        clear xO yO zO;
        k = 1;
        for this_compound_count = 1 : 17
            % This function returns numbers in [m]
            [virtual_source_radius, vs_x, vs_y, vs_z, ~, ~] = GetCompoundingOrigin(probe, image, this_compound_count);
            % Time samples between the imaginary excitation at O and the wave reaching the central probe elements
            % (tx_offsets(1 : 4) contain the offsets for zone imaging, append to those)
            tx_offsets(5) = virtual_source_radius * probe.fs / probe.c;
            xO(k, 1) = vs_x * probe.fs / probe.c;
            yO(k, 1) = vs_y * probe.fs / probe.c;
            zO(k, 1) = vs_z * probe.fs / probe.c;
            k = k + 1;
        end
        origin_point = cat(2, xO, yO, zO);
        mat2vhdl2D(origin_point, 'compound_imaging_origin');

        % Computes and stores the radius, sin(phi, theta), cos(phi, theta)
        % values for all voxels in the volume; the hardware will use these
        % values to compute the TX delays
        radius_delta = (image_lower_limit_m - image_upper_limit_m) / image.radial_lines;
        radius = ((image_upper_limit_m + radius_delta * (1 : image.radial_lines)) * probe.fs / probe.c)';
        angles = - xz_sector / 2 + ((1 : image.azimuth_lines)' - 0.5) * xz_sector / image.azimuth_lines; % TODO assumes X/Y symmetry
        sin_values = sin(angles);
        cos_values = cos(angles);
        mat2vhdl(radius, 'radius', 19, 6, 'signed'); % TODO this is the same as nt_constants with different FP representation, /2, and not rounded. Maybe can reuse one of the two?
        mat2vhdl(sin_values, 'sin', 19, 17, 'signed');
        mat2vhdl(cos_values, 'cos', 19, 17, 'signed');
        mat2vhdl(tx_offsets', 'tx_offsets', 18, 4, 'std_logic_vector');

        vhdl_types_package(N_elements_x, N_elements_y, elevation_lines, image.azimuth_lines, image.radial_lines, excitation_peak_time);

        if (zone_count ~= 1 || compounding_count == 1)
            compound_not_zone_imaging = 0;
        else
            compound_not_zone_imaging = 1;
        end

        if (probe.is2D == 0)
            parameters(elevation_lines, image.azimuth_lines, image.radial_lines, N_elements_x, N_elements_y, 5, adc_precision, apodization_precision, lp_precision, log_samples_depth, bram_samples_per_nappe, zone_count, 1, compounding_count, compound_not_zone_imaging, sim_path, ext_target_phantom, offset_min, offset_max, offset_max(image.radial_lines) - offset_min(1));
        else
            parameters(elevation_lines, image.azimuth_lines, image.radial_lines, N_elements_x, N_elements_y, 5, adc_precision, apodization_precision, lp_precision, log_samples_depth, bram_samples_per_nappe, zone_count, zone_count, compounding_count, compound_not_zone_imaging, sim_path, ext_target_phantom, offset_min, offset_max, offset_max(image.radial_lines) - offset_min(1));
        end
        
        x = (0 : N_elements_x - 1)' * pitch_x + width / 2;
        x_tmp = ((x - transducer_width / 2) * probe.fs / probe.c) .^ 2;
        mat2vhdl(x_tmp, 'x', 36, 8, 'unsigned');

        y = (0 : N_elements_y - 1)' * pitch_y + height / 2;
        y_tmp = ((y - transducer_height / 2) * probe.fs / probe.c) .^ 2;
        % TODO ugly hack, need to work around it. For 2D imaging (probe
        % with a single row of elements) this would cause an array with a
        % single element which wreaks havoc in VHDL. Work around it with a
        % 2-element array. The added coordinate is never used.
        if (N_elements_y == 1)
            y_tmp = [0; 0];
        end
        mat2vhdl(y_tmp, 'y', 36, 8, 'unsigned')

        nt = (round((1 : image.radial_lines)' * focal_points_per_depth) + image_upper_limit_N - 1) * downsampling_factor;
        mat2vhdl(nt, 'nt', 18, 4, 'unsigned');

        added_delay_azimuth = zeros(N_elements_x, image.azimuth_lines);
        d_theta = xz_sector / image.azimuth_lines;
        for line = 1 : image.azimuth_lines
            theta = - xz_sector / 2 + d_theta / 2 + (line - 1) * d_theta;
            x = (0 : N_elements_x - 1) * pitch_x + width / 2;
            added_delay_azimuth(:, line) = (x - transducer_width / 2) * sin(theta) * probe.fs / probe.c;
        end
        mat2vhdl2D(-added_delay_azimuth(end : -1 : 1, end : -1 : 1), 'c1');

        added_delay_elev = zeros(N_elements_x, elevation_lines, image.azimuth_lines);
        if (probe.is2D == 1)
            d_phi = yz_sector / elevation_lines;
            d_theta = xz_sector / image.azimuth_lines;
            for elev = 1 : elevation_lines
                phi = -yz_sector / 2 + d_phi / 2 + (elev - 1) * d_phi;
                for line = 1 : image.azimuth_lines
                    theta = - xz_sector / 2 + (line - 1) * d_theta;
                    y = (0 : N_elements_y - 1) * pitch_y + height / 2;
                    added_delay_elev(:, elev, line) = (y - transducer_height / 2) * sin(phi) * cos(theta) * probe.fs / probe.c;
                end
            end
        end
        for i = 1 : N_elements_x
            c2_reshaped = reshape(added_delay_elev(i, :, :), elevation_lines * image.azimuth_lines, 1);
            mem_init(-c2_reshaped, get_filename('mem_init', i), 13, 14, 4);
        end
        c2_names(N_elements_x);
        
        cd(sc_rtl_path);
        
        sc_parameters(elevation_lines, image.azimuth_lines, image.radial_lines, sim_path, ext_target_phantom);

        cd(launch_folder);
    end
    
    if (generate_rtl == 1 || generate_rf == 1)
        %% Calculating offsets for per-nappe beamforming approach with delay steering
        % These calculations are not valid for exact delays.
        disp('Calculating offsets...');
        launch_folder = pwd;

        cd(bf_rtl_path);

        offset = offset_min;
        % Now trim the unnecessary blanket updates: if multiple nappes can be
        % computed from a single BRAM of samples, don't assume a new
        % reload/offset for those nappes
        last_valid_depth = 1; % Last depth for which we certainly want to load a new BRAM of samples
        for depth = 2 : image.radial_lines
            if (offset_max(depth) - offset(last_valid_depth) <= bram_samples_per_nappe)
                % disp(['For nappe ', num2str(depth), ' which is supposed to start at ', num2str(offset(depth)), ', reusing the data of the previous nappe starting at ', num2str(offset(last_valid_depth))]);
                offset(depth) = offset(last_valid_depth);
            else
                last_valid_depth = depth;
            end
        end

        % figure, plot(offset_min), hold on, plot(offset_max), hold on, plot(offset_max - offset_min), title('Detected minimum and maximum nappe delays at varying depths'), legend('Min', 'Max', 'Blanket thickness');
        % figure, plot(offset), title('Loading offsets');
        if (generate_rtl == 1)
            mat2vhdl(offset, 'offset', 18, 4, 'unsigned'); % TODO -1?
            offsettable(offset_min, 'offset_bottom', image.radial_lines, 1024);
            offsettable(offset_max, 'offset_top', image.radial_lines, 0);
        end
        cd(launch_folder); 
    end

    if (generate_rtl == 1)
        %% Generate apodization matrix
        disp('Generating apodization...');
        launch_folder = pwd;
        cd(bf_rtl_path);
        % Use the supplied data.
        if (max(apod_full(:)) > 1)
            error('The apodization matrix is not normalized to 1, please normalize and rerun.')
        end
        % In the assumption of static apodization, each plane of the matrix
        % will look the same; take plane 1
        mem_init_value = squeeze(apod_full(:, :, 1));
        % We need the values in a single column.
        mem_init_value = reshape(mem_init_value, [], 1);
        % To generate easy-to-debug data:
        % mem_init_value = ones(n_el, 1);
        mem_init(mem_init_value, 'mem_init_apodization.txt', 10, 18 - apodization_precision, apodization_precision);

        %% Lowpass filter coefficients. Must be in sync with DemodulateRFImage.m.
        focal_points_per_depth = (image_lower_limit_N - image_upper_limit_N) / image.radial_lines;
        f_us = probe.f0;                        % Center RF frequency [Hz]
        fs = probe.fs / focal_points_per_depth; % RX sampling frequency [Hz]
        lp_fc = min(fs / 2, f_us / 2);          % Low-pass imaging filter cutoff frequency
        lp_filter_order = 4;
        wn_lp = 0.999 * (2 / fs * lp_fc);       % Solves a small issue where the cutoff frequency
        b_lp = fir1(lp_filter_order, wn_lp, 'low');
        % for i = 1 : lp_filter_order + 1
            % bin(i) = strcat('36''b', dec2bin_frac(b_lp(i), 36 - lp_precision, lp_precision));
            % disp(['For coefficient ', num2str(b_lp(i), '%+3.7f'), ' saved representation ', bin]);
        % end
        demodcoeffs(b_lp', 'demod_coeffs', 36, lp_precision);

        %% Generate memory contents for simulation
        disp('Generating memory intialization files for simulation...');
        
        % Construct a TGC array of 2^log_samples_depth elements.
        % TODO Ensure somehow that the TGC gain stays consistent with BF
        % TODO dynamic range limits. With e.g. 8192 samples, the current
        % 9.9 format requires a /2 to avoid clipping, and still towards
        % the deep end we may need a 10th bit which wreaks havoc in mem_init.
        % Solved with a kludge - saturation.
        integer_bits = 9;
        tgc = 10 .^ (atten_dB_cm / 20 * probe.c * (1 : pow2(log_samples_depth)) / probe.fs * 1e2) / 2;
        tgc(tgc >= pow2(integer_bits)) = pow2(integer_bits) - 1;
        mem_init(tgc', 'mem_init_tgc.txt', log_samples_depth, integer_bits, 18 - integer_bits);
        
        % Format of this data for simulation purposes:
        % Bits 0 : 5: increasing (wrapping) counter
        % Bits 6 : 15: element index (supports up to 1024 elements)
        % Bits 16 : 17: unused (the HDL will discard them anyway)
        sim_rf_data = zeros(N_elements_y, N_elements_x, bram_samples_per_nappe);
        for i = 1 : N_elements_x
            for j = 1 : N_elements_y
                sim_rf_data(j, i, :) = mod(i * j * 64, 1024 * 32) + mod(0 : bram_samples_per_nappe - 1, 64);
            end
        end
        
        % 2D: Each output file will hold the data for one element:
        % 1, 2, 3, 4, ..., 1024 elements of each
        % 3D: Each output file will hold the data for two consecutive elements (same X adjacent Y):
        % 1 2, 3 4, ..., the former in the first 512 rows, the latter in the last 512
        for i = 1 : N_elements_x
            for j = 1 : 2 : N_elements_y
                mem_init_value1 = squeeze(sim_rf_data(j, i, 1 : bram_samples_per_nappe));
                if (probe.is2D == 0)
                    % One element per BRAM
                    mem_init_value = mem_init_value1;
                    file_index = i - 1;
                else
                    % Two elements per BRAM
                    mem_init_value2 = squeeze(sim_rf_data(j + 1, i, 1 : bram_samples_per_nappe));
                    mem_init_value = vertcat(mem_init_value1, mem_init_value2);
                    file_index = (i - 1) * N_elements_y / 2 + (j - 1) / 2;
                end
                % Pad to 18 bits with extra decimal digits; the HDL will use the MSBs only
                mem_init(mem_init_value, get_filename('mem_init_echoes', file_index), 10, adc_precision, 18 - adc_precision);
            end
        end

        cd(launch_folder);
    end

    if (generate_rf == 1)
        %% Generate memory contents for simulation (raw, without apodization and TGC)
        disp('Generating whole input dataset...');
        launch_folder = pwd;
        cd(sim_path);
        
        % Delete any old files if present. They could interfere with testbench execution. We are in a directory which is
        % specific for our phantom and zone count, so we shouldn't be overwriting anything else
        old_files = dir(strcat(ext_target_phantom, '*_rf*.txt'));
        for file_index = 1 : size(old_files, 1)
            delete(old_files(file_index).name);
        end
        
        % A settings file with the imaging parameters, for the GUI and
        % Microblaze software to use
        settingsfile(image.elevation_lines, image.azimuth_lines, image.radial_lines, N_elements_x, N_elements_y, probe, xz_sector, yz_sector, image_lower_limit_m, offset_min, offset_max, offset_max(image.radial_lines) - offset_min(1), bram_samples_per_nappe);
        
        % Two output files containing all the data for the reconstruction of one or more
        % nappes, in the format:
        % A
        % C
        % ...
        % and
        % B
        % D
        % ...
        % where A and B are samples at the same time index but at vertically
        % adjacent elements, C and D are also at the same time index for the next
        % pair of elements, etc.. Once the whole time index is populated,
        % continue with the next time index.
        if (probe.is2D == 0)
            step = N_elements_x * N_elements_y; % How many elements will have a sample at a given sample index
        else
            step = N_elements_x * N_elements_y / 2; % How many elements will have a sample at a given sample index
        end

        if (compounding_count > 1)
            insonification_string = '_compounding_';
        else
            insonification_string = '_zone_';
        end
        
        % Calculate the amplification factor to apply to the raw RF data
        [max_radius, rows, columns, ~, max_values] = LoadRFDataMatrixMetadataFromDisk(target_phantom);
        currently_loaded_insonification_index = 0;
        % Normalize the RF values so that the maximum-amplitude echoes
        % almost saturate the ADCs
        maxval = max(max_values);
        maxrange = 2 ^ (adc_precision - 1);
        amplif_factor = maxrange / maxval;

        for insonification_index = 1 : total_insonifications
            disp(['    At insonification ', num2str(insonification_index), ' of ', num2str(total_insonifications)]);

            if (insonification_index ~= currently_loaded_insonification_index)
                % Only in 3D case: correcting the flipping happening in the
                % namming of the "*_rf*_***_zone_X.txt" files - in the "data"
                % folder - of different zones, which accordingly leads volume 
                % reconstruction based on incorrect order of zones. This has
                % been corrected by fetching the proper rf data based on the
                % "corrected_insonification_index" parameter:
                if (probe.is2D == 1)
                    unchangedindex_perzonegroup = ceil(insonification_index / zone_count) * (zone_count + 1) - zone_count;
                    corrected_insonification_index = unchangedindex_perzonegroup + (insonification_index - unchangedindex_perzonegroup) * zone_count;
                else
                    corrected_insonification_index = insonification_index;
                end
                % Loads on-demand new RF data, to keep memory use in check.
                % rf - Radio-frequency matrix containing the raw data of the
                % backscattered echoes (M*N*O, where M*N is the number of probe elements,
                % and O is the number of time samples)
                rf = LoadRFDataMatrixFromDisk(target_phantom, corrected_insonification_index, max_radius, rows, columns);
                currently_loaded_insonification_index = insonification_index;
                rf = rf * amplif_factor;
            end
            
            % Separate the echoes of odd and even rows of the transducer.
            % In 2D imaging, there is a single row.
            odd_values = zeros(1, step * max_radius);
            even_values = zeros(1, step * max_radius);
            
            % Re-sort the echoes: in order of radius (delay), then along
            % the columns, then along the rows:
            % rad1, col1, row1,3,5,... then rad1, col2, row1,3,5,... then rad2, col1, row1,3,5...
            for rad_index = 1 : max_radius
                start = (rad_index - 1) * step + 1;
                finish = rad_index * step;
                if (probe.is2D == 0)
                    odd_values(start : finish) = reshape(rf(1, :, rad_index), 1, step);
                else
                    odd_values(start : finish) = reshape(rf(1 : 2 : N_elements_y, :, rad_index), 1, step);
                    even_values(start : finish) = reshape(rf(2 : 2 : N_elements_y, :, rad_index), 1, step);
                end
            end
            
            % Save RF files for use by the non-streaming simulations (data
            % in chunks of BRAM_SAMPLES_PER_NAPPE).
            %starting_offset_list = [];
            
            % Some phantoms may be shallow and not have enough echo depth to
            % reconstruct down to the desired depth. Pad with 0s at the deep end.
            stop = offset_max(image.radial_lines) * step;
            if (size(odd_values, 2) < stop)
                odd_values = horzcat(odd_values, zeros(1, stop - size(odd_values, 2)));
                even_values = horzcat(even_values, zeros(1, stop - size(even_values, 2)));
            end
            
            for n = 1 : image.radial_lines
                if (mod(n, 20) == 1)
                    disp(['        At radius slice ', num2str(n), ' of ', num2str(image.radial_lines)]);
                end
                if (n == 1 || offset(n) > offset(n - 1))
                    start = offset(n) * step;
                    % starting_offset_list = [starting_offset_list; offset(n)];
                    mem_init(odd_values(start + 1 : min(start + step * bram_samples_per_nappe, size(odd_values, 2)))', [ext_target_phantom, '_rfa_', pad(num2str(n), 3, 'left', '0'), insonification_string, num2str(insonification_index), '.txt'], log2(step * bram_samples_per_nappe), adc_precision, 0);
                    if (probe.is2D == 1)
                        mem_init(even_values(start + 1 : min(start + step * bram_samples_per_nappe, size(even_values, 2)))', [ext_target_phantom, '_rfb_', pad(num2str(n), 3, 'left', '0'), insonification_string, num2str(insonification_index), '.txt'], log2(step * bram_samples_per_nappe), adc_precision, 0);
                    end
                end
            end
            
            % Save RF files for use by the streaming simulations (all data
            % in a single file).
            start = offset_min(1) * step;
            stop = offset_max(image.radial_lines) * step;
            
            test_negative_offset = 0;
            % Add X samples of 0s before the beginning of the signal
            % trace. Will then need to add X to `RF_DEPTH and subtract
            % X from `ZERO_OFFSET manually.
            if (test_negative_offset)
                X = 500;
                stop = stop + X * step;
                odd_values = horzcat(zeros(1, X * step), odd_values);
                even_values = horzcat(zeros(1, X * step), even_values);
            end
            
            % Dump the files to disk.
            mem_init(odd_values(start + 1 : min(stop, size(odd_values, 2)))', [ext_target_phantom, '_rfa_000', insonification_string, num2str(insonification_index), '.txt'], log2(step * bram_samples_per_nappe), adc_precision, 0);
            if (probe.is2D == 1)
                mem_init(even_values(start + 1 : min(stop, size(even_values, 2)))', [ext_target_phantom, '_rfb_000', insonification_string, num2str(insonification_index), '.txt'], log2(step * bram_samples_per_nappe), adc_precision, 0);
            end
        end
        cd(launch_folder);
    end
    
    if (generate_rtl == 1)
        % Generate offset information for Microblaze-controlled mode
        disp('Generating offset information...');
        launch_folder = pwd;
        cd(bf_rtl_path);
        starting_offset_list = [];
        for n = 1 : image.radial_lines
            if (n == 1 || offset(n) > offset(n - 1))
                starting_offset_list = [starting_offset_list; offset(n)];
            end
        end
        offsetinfo(starting_offset_list);
        cd(launch_folder);
    end
    
    toc(gen_timer)
end
