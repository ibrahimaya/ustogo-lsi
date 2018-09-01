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
%% TopLevel Script
%clear all;
clc;
basepath = fileparts(mfilename('fullpath'));
addpath(basepath, ...
        strcat(basepath, '/Utilities/src'), ...
        strcat(basepath, '/Utilities/src/GeneratePlatformHDL'), ...
        strcat(basepath, '/PhantomGeneration/src'), ...
        strcat(basepath, '/Insonification/src'), ...
        strcat(basepath, '/InsonificationAndBeamforming/src'), ...
        strcat(basepath, '/BeamformingInitialization/src'), ...
        strcat(basepath, '/Beamforming/src'), ...
        strcat(basepath, '/Compounding/src'), ...
        strcat(basepath, '/ScanConversion/src'));

% Pick a phantom to image
%target_phantom = 'pointcartesian';
%target_phantom = 'pointpolar';
target_phantom = 'six_points';
%target_phantom = 'pointgrid';
%target_phantom = 'circle';
%target_phantom = 'line';
%target_phantom = 'sphere';
%target_phantom = 'spherewithwire';
%target_phantom = 'cysts';
%target_phantom = 'stripes';
% These require uncompressing the files from: http://www.osirix-viewer.com/datasets/
% into MatlabFlow\src\PhantomGeneration\dicom
%target_phantom = 'dicom_magix';
%target_phantom = 'dicom_fourdix';
% This requires copying the file: http://field-ii.dk/examples/ftp_files/kidney/pht_data.mat
% into MatlabFlow\src\PhantomGeneration\data\field_kidney.mat
% (can also be regenerated with the corresponding scripts)
%target_phantom = 'field_kidney';
% This requires copying the file: http://field-ii.dk/examples/ftp_files/fetus/pht_data.mat
% into MatlabFlow\src\PhantomGeneration\data\field_fetus.mat
% (can also be regenerated with the corresponding scripts. Requires adding an extra "round" in feu_pha.m)
%target_phantom = 'field_fetus';

% These settings force the script to rerun Step 1-4
% even when they could be reloaded from disk.
force_regenerate_phantom_probe = 1;
force_reinitialize_beamforming = 1;
force_reinsonify = 1;
force_rebeamform = 1;
force_compounding = 1;

image.azimuth_lines = 73;    % Use -1 to have one line per degree. Parameter is only used in phased arrays (else lines == n_el).
% SET THE FOLLOWING PARAMETER TO 1 FOR 2D IMAGING, > 1 FOR 3D
image.elevation_lines = 73;  % Use -1 to have one line per degree. % TODO but this setting is not honored by all scripts.
% Configurable depth resolution. Lower = faster, higher = higher-resolution.
% MIN (TODO: verify) to meet Nyquist, although only in a contrived case): radial_lines = (image_lower_limit_m - image_upper_limit_m) / (1 / (probe.f0 * 4));
% MAX: radial_lines = image_lower_limit_N - image_upper_limit_N + 1;
image.radial_lines = 600;
image.target_shallow_bound = 0 / 1000;  % Use -1 to choose a phantom-dependent depth
image.target_depth = 10 / 1000;         % Use -1 to choose a phantom-dependent depth
image.target_azimuth = 73;     % Use -1 to choose a phantom-dependent azimuth sector
image.target_elevation = 73;   % Use -1 to choose a phantom-dependent elevation sector

% 1: during beamforming, use precise calculation of delays (with a square root),
% 0: use an approximation (delay steering)
beamform_with_exact_delays = 1;

% (Only used in 3D imaging)
% 1: use the same apodization along the whole volume,
% 0: expanding aperture
with_static_apodization = 1;

% Whether we want to use a linear probe or phased array
linear = 0;

% Whether to do beamforming manually or via Field
do_beamforming_explicitly = 1;

% If zone imaging is desired, over how many zones.
% (Note: in 3D, the number of zones will be the square of this
% value; e.g. setting it to 5 will use 25 zones).
zone_count = 1;

% If compounding is desired, how many angles to compound
% Note: setting this to > 1 and zone count > 1 together will result in an error
% Note: compounding is only supported in combination with plane wave and
% diverging beam TX focus options; also, unsupported for diverging beams
% with linear probes
% It is highly recommended to only use compounding values of
% 1 (2D/3D), 3 (2D/3D), 5 (2D/3D), 9, 13, 17 (3D only) for symmetry
compounding_count = 1;

% Type of compounding operation
% 0: Average compounding
% 1: Average compounding without the maximum brightness voxel
% 2: Maximum brightness voxel selected
% 3: Minimum brightness voxel selected
% 4: MSD compounding (needs refining)
% 5: ZREV compounding (needs refining)
compounding_operator = 0;

% Whether brightness compensation should be used
with_brightness_compensation = 0;

% If downsampling is applied before beamforming, how much
% is to be applied. (Set to 1 to disable downsampling altogether)
downsampling_factor = 1;
% Field beamforming does not support downsampling.
if (do_beamforming_explicitly == 0)
    downsampling_factor = 1;
end

% Type of transmit focus.
% 0 -> Plane wave (unfocused, i.e. focus at infinity)
% 1 -> Focus at phantom's center
% 2 -> Diverging beam (virtual source behind the transducer)
% 3 -> Focus along each line of sight/sector (applies to multiple
%      insonifications only, else behaves like focus 1)
% 4 -> Weak focusing (like focus 3, but uses a wider beam)
if (linear)
    tx_focus = 0;
else
    tx_focus = 2;
end

% Whether to generate FPGA-related files after beamforming. The first
% parameter generates only the files needed to synthesize the FPGA, the
% second generates input data for RTL simulation or to feed from the
% outside into the FPGA
generate_rtl = 0;
generate_rf = 0;

% File containing tests to run in a loop. If unspecified/empty, the
% parameters above are used.
test_file = '';

% Destination folder for the test outputs. Will be overridden by anything
% that is specified in the tests file. If no tests are run, leave empty if
% no outputs should be saved in a particular dedicated folder in addition
% to the usual outputs.
dest_dir = '';

show_output_image_on_screen = 1;

% Code for generation of "universal" RTL that supports multiple zone/compounding counts.
% Run the flow with a customized test_file twice: the first time with "first_run" at 1,
% then with "first_run" at 0.
first_run = 1;
if (first_run == 1)
    clear offset_min_allruns offset_max_allruns;
    current_index = 1;
else
    offset_min_universal = min(offset_min_allruns, [], 2);
    offset_max_universal = max(offset_max_allruns, [], 2);
end

next_index = 1;
while (next_index ~= -1)

% Overwrites the default parameters if it finds a test in the specified
% file. "next_index" keeps going up by one so long as there are more tests
% in the file, and returns -1 when the file is over.
[force_regenerate_phantom_probe, force_reinsonify, image, generate_rtl, generate_rf, beamform_with_exact_delays, with_static_apodization, ...
 target_phantom, name_string, zone_count, compounding_count, dest_dir, bf_rtl_dir, sc_rtl_dir, next_index] = ...
    GetNextTest(test_file, force_regenerate_phantom_probe, force_reinsonify, image, generate_rtl, generate_rf, beamform_with_exact_delays, ...
                with_static_apodization, target_phantom, '', zone_count, compounding_count, dest_dir, next_index);

run_timer = tic;

% Check: 3D imaging with a linear probe is disallowed.
if (linear == 1 && image.elevation_lines > 1)
    error ('Undefined imaging mode: 3D Imaging only supports phased arrays.');
end

if (zone_count ~= 1 && compounding_count > 1)
    error ('Simultaneous zone imaging and compounding not supported.');
end

if (tx_focus ~= 0 && (tx_focus ~= 2 || linear == 1) && compounding_count > 1)
    error ('Compounding not supported in this TX focus mode.');
end

%% Step 1: generate the model of the phantom and probe
cd(basepath);
if (force_regenerate_phantom_probe == 1 || ...
        exist(fullfile('PhantomGeneration', 'data', strcat('pht_', target_phantom, '.mat')), 'file') ~= 2 || ...
        exist(fullfile('PhantomGeneration', 'data', 'probe.mat'), 'file') ~= 2 )
    warning('Regenerating phantom "%s"', target_phantom);
    [phantom, probe] = GeneratePhantomAndProbe(target_phantom, linear, image, tx_focus);
else
    warning('Reusing previously saved phantom "%s"', target_phantom);
    load(fullfile('PhantomGeneration', 'data', strcat('pht_', target_phantom, '.mat')));
    load(fullfile('PhantomGeneration', 'data', 'probe.mat'));
end

%% Step 2: initialize beamforming tables
cd(basepath);
if (force_reinitialize_beamforming == 1 || ...
        exist(fullfile('BeamformingInitialization', 'data', 'apod_full.mat'), 'file') ~= 2 || ...
        exist(fullfile('BeamformingInitialization', 'data', 'el_max.mat'), 'file') ~= 2 || ...
        ~isempty(dir(fullfile('BeamformingInitialization', 'data', 'tx_delay_*.mat'))) || ...
        exist(fullfile('BeamformingInitialization', 'data', 'rx_delay.mat'), 'file') ~= 2 )
    warning('Reinitializing beamforming for phantom "%s"', target_phantom);
    if (image.elevation_lines == 1 && probe.linear == 1)
        [apod_full, el_max, rx_delay] = InitializeBeamforming2DLinear(probe, target_phantom, zone_count, compounding_count, image, with_static_apodization);
    elseif (image.elevation_lines == 1 && probe.linear == 0)
        [apod_full, el_max, rx_delay] = InitializeBeamforming2DPhased(probe, target_phantom, zone_count, compounding_count, image, with_static_apodization);
    else
        [apod_full, el_max, rx_delay] = InitializeBeamforming3D(probe, target_phantom, zone_count, compounding_count, image, with_static_apodization);
    end
else
    warning('Reusing previously saved beamforming initialization for phantom "%s"', target_phantom);
    load(fullfile('BeamformingInitialization', 'data', strcat('apod_full.mat')));
    load(fullfile('BeamformingInitialization', 'data', strcat('el_max.mat')));
    load(fullfile('BeamformingInitialization', 'data', strcat('rx_delay.mat')));
end

if (do_beamforming_explicitly == 0)
    %% Steps 3-4: insonify the phantom to collect echoes and rely on Field for beamforming, too
    cd(basepath);
    if (force_rebeamform == 1 || ...
            (linear == 1 && exist(fullfile('InsonificationAndBeamforming', 'data', strcat('bf_im_linear_', target_phantom, '.mat')), 'file') ~= 2) || ...
            (linear == 0 && exist(fullfile('InsonificationAndBeamforming', 'data', strcat('bf_im_phased_', target_phantom, '.mat')), 'file') ~= 2) )
        warning('Rebeamforming for phantom "%s"', target_phantom);
        bf_im = InsonifyAndBeamformPhantom(phantom, probe, apod_full, el_max, image);
        cd(basepath);
        if (linear == 1)
            movefile(fullfile('InsonificationAndBeamforming', 'data', 'bf_im_linear.mat'), fullfile('InsonificationAndBeamforming', 'data', strcat('bf_im_linear_', target_phantom, '.mat')));
        else
            movefile(fullfile('InsonificationAndBeamforming', 'data', 'bf_im_phased.mat'), fullfile('InsonificationAndBeamforming', 'data', strcat('bf_im_phased_', target_phantom, '.mat')));
        end
    else
        % TODO may want to also distinguish 2D/3D
        warning('Reusing previously saved beamforming data for phantom "%s"', target_phantom);
        if (linear == 1)
            load(fullfile('InsonificationAndBeamforming', 'data', strcat('bf_im_linear_', target_phantom, '.mat')));
        else
            load(fullfile('InsonificationAndBeamforming', 'data', strcat('bf_im_phased_', target_phantom, '.mat')));
        end
    end
else
    %% Step 3: insonify the phantom to collect echoes
    cd(basepath);
    if (force_reinsonify == 1 || ~isempty(dir(fullfile('Insonification', 'data', strcat('echo_*.mat')))))
        warning('Reinsonifying phantom "%s"', target_phantom);
        [t0, brightness_comp] = InsonifyPhantom(phantom, target_phantom, probe, image, zone_count, compounding_count, with_brightness_compensation);
        cd(basepath);
    else
        warning('Reusing previously saved echoes of insonification of phantom "%s"', target_phantom);
        load(fullfile('Insonification', 'data', 'brightness_comp.mat'));
    end
    
    %% Step 4: do beamforming
    cd(basepath);
    if (force_rebeamform == 1 || ...
            (linear == 1 && exist(fullfile('Beamforming', 'data', strcat('bf_im_linear_', target_phantom, '.mat')), 'file') ~= 2) || ...
            (linear == 0 && exist(fullfile('Beamforming', 'data', strcat('bf_im_phased_', target_phantom, '.mat')), 'file') ~= 2) )
        warning('Rebeamforming for phantom "%s"', target_phantom);
        if (generate_rtl == 1 || generate_rf == 1)
            dump_fpga_verification_outputs = 1;
        else
            dump_fpga_verification_outputs = 0;
        end
        if (image.elevation_lines == 1)
            [bf_im, offset_min, offset_max] = Beamform2D(probe, target_phantom, apod_full, el_max, rx_delay, downsampling_factor, zone_count, compounding_count, with_brightness_compensation, brightness_comp, image, beamform_with_exact_delays, dump_fpga_verification_outputs);  % The output is 2D
        else
            % Suppress a warning that is actually OK
            % TODO annoyingly seems to work intermittently, and not from
            % inside the function
            warning('off', 'MATLAB:mir_warning_maybe_uninitialized_temporary');
            [bf_im, offset_min, offset_max] = Beamform3D(probe, target_phantom, apod_full, el_max, rx_delay, downsampling_factor, zone_count, compounding_count, with_brightness_compensation, brightness_comp, image, beamform_with_exact_delays, dump_fpga_verification_outputs);  % The output is 3D
            warning('on', 'MATLAB:mir_warning_maybe_uninitialized_temporary');
        end
        cd(basepath);
        if (linear == 1)
            movefile(fullfile('Beamforming', 'data', 'bf_im_linear.mat'), fullfile('Beamforming', 'data', strcat('bf_im_linear_', target_phantom, '_zone_', num2str(zone_count), '_compounding_', num2str(compounding_count), '.mat')));
        else
            movefile(fullfile('Beamforming', 'data', 'bf_im_phased.mat'), fullfile('Beamforming', 'data', strcat('bf_im_phased_', target_phantom, '_zone_', num2str(zone_count), '_compounding_', num2str(compounding_count), '.mat')));
        end
    else
        warning('Reusing previously saved beamforming data for phantom "%s"', target_phantom);
        if (linear == 1)
            load(fullfile('Beamforming', 'data', strcat('bf_im_linear_', target_phantom, '.mat')));
        else
            load(fullfile('Beamforming', 'data', strcat('bf_im_phased_', target_phantom, '.mat')));
        end
    end
end

%% Step 5: Compounding (optional - will be skipped if compounding_count == 1)
cd(basepath);
if (compounding_count > 1 && (force_compounding == 1 || (exist(fullfile('Compounding', 'data', 'avg_im.mat'), 'file') ~= 2)))
    warning('Re-compounding for phantom "%s"', target_phantom);
    if (image.elevation_lines == 1)
        avg_im = Compounding2D(bf_im, compounding_operator);
    else
        avg_im = Compounding3D(bf_im, compounding_operator);
    end
    bf_im_backup = bf_im; % In case we want to study the pre-compounding frames
    bf_im = avg_im;
elseif (compounding_count > 1)
    warning('Reusing previously saved compounding data for phantom "%s"', target_phantom);
    avg_im = load(fullfile('Compounding', 'data', 'avg_im.mat'));
    bf_im = avg_im;
else
    % No compounding requested, do absolutely nothing
end

%% Step 6: scan conversion
cd(basepath);
warning('Redoing scan conversion for phantom "%s"', target_phantom);
if (linear == 1 && image.elevation_lines == 1)
    sc_im = ScanConvert2DLinear(probe, image, bf_im, downsampling_factor, 1, show_output_image_on_screen);
elseif (linear == 0 && image.elevation_lines == 1)
    sc_im = ScanConvert2DPhased(probe, image, bf_im, downsampling_factor, 1, show_output_image_on_screen);
elseif (linear == 0 && image.elevation_lines > 1)
    sc_im = ScanConvert3DPhased(probe, image, bf_im, downsampling_factor, 1, show_output_image_on_screen);
else
    error ('Undefined scan conversion mode: 3D Imaging only supports phased arrays.');
end

if (~isempty(dest_dir))
    cd(basepath);
    % Overwrites if necessary.
    if (image.elevation_lines == 1)
        ext_target_phantom = strcat(target_phantom, '2D');
    else
        ext_target_phantom = strcat(target_phantom, '3D');
    end
    % TODO this bf-non-sc data will be eventually unneeded, right now only useful for "test mode"
    copyfile(fullfile('Beamforming', 'data', strcat('bf_im_phased_', target_phantom, '_zone_', num2str(zone_count), '_compounding_', num2str(compounding_count), '.mat')), dest_dir)
    movefile(strcat(dest_dir, 'bf_im_phased_', target_phantom, '_zone_', num2str(zone_count), '_compounding_', num2str(compounding_count), '.mat'), strcat(dest_dir, ext_target_phantom, '_bf.mat'));
    copyfile(fullfile('ScanConversion', 'data', 'sc_im_phased.mat'), dest_dir)
    movefile(strcat(dest_dir, 'sc_im_phased.mat'), strcat(dest_dir, ext_target_phantom, '_bf_sc_', name_string, '.mat'));
    % Store the RF data in .txt files ready to upload to the FPGA. The .txt
    % files are overwritten every time a new run is done on the same phantom,
    % but that doesn't matter since the RF data is unchanged across runs, so
    % long as the phantom is still the same.
    if (first_run == 1)
        offset_min_allruns(:, current_index) = offset_min;
        offset_max_allruns(:, current_index) = offset_max;
        [adc_precision, offset_min] = GeneratePlatformHDL(probe, image, target_phantom, ext_target_phantom, zone_count, compounding_count, downsampling_factor, dest_dir, bf_rtl_dir, sc_rtl_dir, apod_full, offset_min, offset_max, generate_rtl, generate_rf);
        copyfile(strip(bf_rtl_dir, 'right', '/'), strcat(bf_rtl_dir, num2str(current_index)));
        current_index = current_index + 1;
    else
        [adc_precision, offset_min] = GeneratePlatformHDL(probe, image, target_phantom, ext_target_phantom, zone_count, compounding_count, downsampling_factor, dest_dir, bf_rtl_dir, sc_rtl_dir, apod_full, offset_min_universal, offset_max_universal, generate_rtl, generate_rf);
    end
    % Also saves to disk the bf_im as nappe files that can be used as a
    % direct input to a SC simulation.
    SaveNappesToDisk(image, bf_im, dest_dir, ext_target_phantom);
end

toc(run_timer)

end