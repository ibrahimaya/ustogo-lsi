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
Choice A (Automatic flow execution)
===================================

1) Make sure to launch the "addpath" command, pointing to the directory with the Field II installation.

2) "cd" to the folder containing TopLevel.m.

3) Just launch "TopLevel.m" (where you can customize some parameters) to run the complete flow.

By default, unless TopLevel.m is edited, this runs the same operations of Choice B below, in an automated flow
with default parameter choices.

Choice B (Manual beamforming)
=============================

1) Make sure to launch the "addpath" command, pointing to the directory with the Field II installation.

2) From PhantomGeneration:
   Launch GeneratePhantomAndProbe() with a phantom name (e.g. "six_points", "circle",
   "line", "spherewithwire", etc.; see the top of TopLevel.m for a name list reference) as a parameter.
   Note that some parameters can be changed within GeneratePhantomAndProbe.m.
   Pass "linear" at 1 or 0 for linear and phased flows, respectively, and "image.elevation_lines" at 1 for 2D US
   imaging and >1 for 3D US imaging. (The combination linear+3D is unsupported). With the settings atop TopLevel.m,
   it is also possible to adopt zone imaging for improved resolution, or (mutually exclusive) compounding (see Step 6).
   This puts in PhantomGeneration/data files containing probe settings and phantom geometry.
   
3) From BeamformingInitialization:
   Launch InitializeBeamforming2DLinear/2DPhased/3D() with the probe description from the previous steps.
   This initializes some crucial tables (e.g. delay and apodization tables) as needed for beamforming. A choice
   of TX focus modes (0 = plane wave, 1 = converging focus, 2 = diverging focus) is available.
   The tables are saved in BeamformingInitialization/data.

4) From Insonification:
   Launch InsonifyPhantom() with the outputs from the previous steps. This launches Field II
   to insonify the phantom and reconstruct the corresponding echoes.
   The file Insonification/data/echoes.mat contains in a single file the echoes and a copy of the probe settings.
   Pay special attention to the contents of "SimulateRawData2D/3D.m" in this folder, which includes e.g. the
   probe type configuration.

5) From Beamforming:
   Launch Beamform2D/3D() with the outputs from the previous steps. This function performs beamforming;
   the baseband (demodulated) image is saved on disk in Beamforming/data. Downsampling can optionally be applied
   to improve processing speed at the cost of image quality; setting it to 1 disables downsampling.
   
6) From Compounding:
   Image compounding (optional) can now be performed. If enabled at the beginning of the flow, multiple reconstructions
   of the same phantom are beamformed, differing in the TX emission. The Compounding2D/3D() script processes these
   reconstructions with one of a variety of compounding algorithms and returns a single, cleaner image.
   
7) From ScanConversion:
   Launch ScanConvert2DLinear/2DPhased/3DPhased() with the outputs from the previous steps.
   This function performs log compression and scan conversion, then displays the final image and also
   saves it on disk under ScanConversion/data.

Choice C (Field II beamforming)
===============================

This flow is equivalent to Choice B, but uses Field to perform beamforming in addition to insonification,
to provide an image quality reference.

Replace steps 4-5 above with the following:

From InsonificationAndBeamforming:
   Launch InsonifyAndBeamformPhantom() with the outputs from the previous steps..
   This launches Field II to insonify the phantom and beamform the corresponding echoes. The
   baseband image is saved on disk in InsonificationAndBeamforming/data.
   
Choice D (Scripted execution)
=============================

This approach is equivalent to Choice A, but allows the user to specify multiple imaging parameter sets for back-to-back
execution.

Follow the same directions of Choice A, but before launching TopLevel, edit the line "test_file = ... ;" to point to
a text file of your choosing (see example in ustogo\MatlabFlow\src\tests.txt). The text file can be edited to list any number of
tests to be performed automatically in a scripted sequence.
   
Notes
=====

* In several scripts, additional debugging plots/information can be enabled. Search for the "%% Debug" comments and
  enable the respective code.
* The global flow launched from TopLevel.m supports either saving and reusing intermediate data (e.g. insonification
  outcomes), or forcing their regeneration. Check the "force" settings to decide how many steps of the flow to be rerun.
