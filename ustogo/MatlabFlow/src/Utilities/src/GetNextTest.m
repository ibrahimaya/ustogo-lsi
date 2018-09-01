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
function [force_regenerate_phantom_probe, ...
          force_reinsonify, ...
          image, ...
          generate_rtl, ...
          generate_rf, ...
          beamform_with_exact_delays, ...
          with_static_apodization, ...
          target_phantom, ...
          name_string, ...
          zone_count, ...
          compounding_count, ...
          dest_dir, ...
          bf_rtl_dir, ...
          sc_rtl_dir, ...
          next_index] = GetNextTest(filename, ...
                                    default_force_regenerate_phantom_probe, ...
                                    default_force_reinsonify, ...
                                    default_image, ...
                                    default_generate_rtl, ...
                                    default_generate_rf, ...
                                    default_beamform_with_exact_delays, ...
                                    default_with_static_apodization, ...
                                    default_target_phantom, ...
                                    default_name_string, ...
                                    default_zone_count, ...
                                    default_compounding_count, ...
                                    default_dest_dir, ...
                                    index)

    found_index = 0;
    test_counter = 0;
    next_index = index;
    
    % TODO almost no error checking
    
    if (exist(filename, 'file'))
        disp(['Running test ' num2str(index) ' from file ' filename]);
        
        fID = fopen(filename, 'r');
        C = textscan(fID, '%s %s');
        for row_index = 1 : size(C{1,1})
            param = string(cell2mat(C{1,1}(row_index)));
            value = string(cell2mat(C{1,2}(row_index)));
            if (strcmp(param, 'enable_test') == 1)
                test_counter = test_counter + 1;
                % If we had already found the test we wanted, tell the caller
                % that we can run another test next.
                if (found_index == 1)
                    next_index = index + 1;
                end
                % Have we found the test the caller wanted?
                if (test_counter == index)
                    found_index = 1;
                    disp(['Running test ' num2str(index) ' with settings:']);
                    % Necessary to set default values for these two as they
                    % will be required before the rest of the default
                    % assignments.
                    zone_count = default_zone_count;
                    compounding_count = default_compounding_count;
                end
            end
            if (test_counter == index)
                if (strcmp(param, 'force_regenerate_phantom_probe') == 1)
                    force_regenerate_phantom_probe = str2double(value);
                    disp(['force_regenerate_phantom_probe = ' num2str(force_regenerate_phantom_probe)]);
                end
                if (strcmp(param, 'force_reinsonify') == 1)
                    force_reinsonify = str2double(value);
                    disp(['force_reinsonify = ' num2str(force_reinsonify)]);
                end
                if (strcmp(param, 'azimuth_lines') == 1)
                    image.azimuth_lines = str2double(value);
                    disp(['azimuth_lines = ' num2str(image.azimuth_lines)]);
                end
                if (strcmp(param, 'elevation_lines') == 1)
                    image.elevation_lines = str2double(value);
                    disp(['elevation_lines = ' num2str(image.elevation_lines)]);
                end
                if (strcmp(param, 'radial_lines') == 1)
                    image.radial_lines = str2double(value);
                    disp(['radial_lines = ' num2str(image.radial_lines)]);
                end
                if (strcmp(param, 'shallow_depth') == 1)
                    image.target_shallow_bound = str2double(value);
                    disp(['shallow_depth = ' num2str(image.target_shallow_bound)]);
                end
                if (strcmp(param, 'target_depth') == 1)
                    image.target_depth = str2double(value);
                    disp(['target_depth = ' num2str(image.target_depth)]);
                end
                if (strcmp(param, 'target_azimuth') == 1)
                    image.target_azimuth = str2double(value);
                    disp(['target_azimuth = ' num2str(image.target_azimuth)]);
                end
                if (strcmp(param, 'target_elevation') == 1)
                    image.target_elevation = str2double(value);
                    disp(['target_elevation = ' num2str(image.target_elevation)]);
                end
                if (strcmp(param, 'generate_rtl') == 1)
                    generate_rtl = str2double(value);
                    disp(['generate_rtl = ' num2str(generate_rtl)]);
                end
                if (strcmp(param, 'generate_rf') == 1)
                    generate_rf = str2double(value);
                    disp(['generate_rf = ' num2str(generate_rf)]);
                end
                if (strcmp(param, 'beamform_with_exact_delays') == 1)
                    beamform_with_exact_delays = str2double(value);
                    disp(['beamform_with_exact_delays = ' num2str(beamform_with_exact_delays)]);
                end
                if (strcmp(param, 'with_static_apodization') == 1)
                    with_static_apodization = str2double(value);
                    disp(['with_static_apodization = ' num2str(with_static_apodization)]);
                end
                if (strcmp(param, 'target_phantom') == 1)
                    target_phantom = char(value);
                    disp(['target_phantom = ' target_phantom]);
                end
                if (strcmp(param, 'name_string') == 1)
                    name_string = char(value);
                    disp(['name_string = ' name_string]);
                end
                if (strcmp(param, 'zone_count') == 1)
                    zone_count = str2double(value);
                    disp(['zone_count = ' num2str(zone_count)]);
                end
                if (strcmp(param, 'compounding_count') == 1)
                    compounding_count = str2double(value);
                    disp(['compounding_count = ' num2str(compounding_count)]);
                end
                % Specifically use / slashes for Vivado compatibility (some
                % of these strings will go into the Verilog files).
                if (strcmp(param, 'dest_dir') == 1)
                    if (compounding_count > 1)
                        insonification_count = compounding_count;
                        if (image.elevation_lines == 1)
                            dim_string = '2D';
                        else
                            dim_string = '3D';
                        end
                        dest_dir = strcat(char(value), 'data/', strcat(target_phantom, dim_string), strcat('/compounding_', num2str(insonification_count)), '/');
                    else
                        if (image.elevation_lines == 1)
                            insonification_count = zone_count;
                            dim_string = '2D';
                        else
                            insonification_count = zone_count * zone_count;
                            dim_string = '3D';
                        end
                        dest_dir = strcat(char(value), 'data/', strcat(target_phantom, dim_string), strcat('/zone_', num2str(insonification_count)), '/');
                    end
                    bf_rtl_dir = strcat(char(value), '/BeamformerIP/BeamformerIP.srcs/sources_1/new');
                    sc_rtl_dir = strcat(char(value), 'ScanConverterIP/ScanConverterIP.srcs/sources_1/new');
                    disp(['dest_dir = ' dest_dir]);
                    disp(['bf_rtl_dir = ' bf_rtl_dir]);
                    disp(['sc_rtl_dir = ' sc_rtl_dir]);
                    if (~exist(dest_dir, 'dir') && ~isempty(dest_dir))
                        mkdir(dest_dir);
                    end
                    if (~exist(bf_rtl_dir, 'dir') && ~isempty(bf_rtl_dir))
                        mkdir(bf_rtl_dir);
                    end
                    if (~exist(sc_rtl_dir, 'dir') && ~isempty(sc_rtl_dir))
                        mkdir(sc_rtl_dir);
                    end
                    % At the last parameter dest_dir. This avoids
                    % commented-away tests after the desired one triggering
                    % false positives.
                    test_counter = test_counter + 1;
                end
            end
        end

        fclose(fID);
    end

    % This is in the case the test file was not given, or we haven't found
    % the requested test index at all.
    % The caller must have wanted to run a plain test with the default parameters.
    if (found_index == 0)
        force_regenerate_phantom_probe = default_force_regenerate_phantom_probe;
        force_reinsonify = default_force_reinsonify;
        image = default_image;
        generate_rtl = default_generate_rtl;
        generate_rf = default_generate_rf;
        beamform_with_exact_delays = default_beamform_with_exact_delays;
        with_static_apodization = default_with_static_apodization;
        target_phantom = default_target_phantom;
        name_string = default_name_string;
        zone_count = default_zone_count;
        compounding_count = default_compounding_count;
        dest_dir = default_dest_dir;
        bf_rtl_dir = default_dest_dir;
        sc_rtl_dir = default_dest_dir;
        if (~exist(dest_dir, 'dir') && ~isempty(dest_dir))
            mkdir(dest_dir);
        end
        next_index = -1;
        warning('No new test found in %s, running with default settings.', filename);
    end
    % This is in the case we have found the requested test, but it is the
    % last in the file. Run it, but tell the caller that there is no other
    % test next.
    if (found_index == 1 && next_index == index)
        next_index = -1;
    end
    
end


