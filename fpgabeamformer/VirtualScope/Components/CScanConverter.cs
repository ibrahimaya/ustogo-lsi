// ***************************************************************************
// ***************************************************************************
//  Copyright (C) 2014-2018  EPFL
//  "VirtualScope" GUI.
//
//   Permission is hereby granted, free of charge, to any person
//   obtaining a copy of this software and associated documentation
//   files (the "Software"), to deal in the Software without
//   restriction, including without limitation the rights to use,
//   copy, modify, merge, publish, distribute, sublicense, and/or sell
//   copies of the Software, and to permit persons to whom the
//   Software is furnished to do so, subject to the following
//   conditions:
//
//   The above copyright notice and this permission notice shall be
//   included in all copies or substantial portions of the Software.
//
//   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//   OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//   NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//   HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//   OTHER DEALINGS IN THE SOFTWARE.
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************

using System;
using System.Diagnostics;
using System.Drawing;
using System.Runtime.InteropServices;

namespace VirtualScopeNS.Components
{
    public class CScanConverter
    {
//        [DllImport("DemodulateRFImageSimple.dll")]
//       public static extern void DemodulateRFImageSimple(double f_us, double fs, const emxArray_real_T *rf_im, const emxArray_real_T* b_lp, const emxArray_real_T* a_lp, emxArray_real_T *bf_im);

        private CProbe probe;

        public CScanConverter(VirtualScopeNS.Components.CProbe probe)
        {
            this.probe = probe;
        }

        public UInt32 WidthAfterScanConversion(UInt32 image_depth, Double xz_sector)
        {
            UInt32 half_image_width = Convert.ToUInt32(Math.Ceiling(image_depth * Math.Sin(xz_sector / 2)));
            UInt32 image_width = 2 * half_image_width + 1; // X axis

            return image_width;
        }

        public UInt32 HeightAfterScanConversion(UInt32 image_depth, Double yz_sector)
        {
            UInt32 half_image_height = Convert.ToUInt32(Math.Ceiling(image_depth * Math.Sin(yz_sector / 2)));
            UInt32 image_height = 2 * half_image_height + 1; // Y axis

            return image_height;
        }

        public CPostScanConvertImage ScanConvert(CPreScanConvertImage preSCImage, UInt32 image_depth, Double xz_sector, Double yz_sector, Double r, bool enable_log_compression, UInt32 LC, Double referenceMaxVoxel)
        {
            UInt32 GSmax = 255; // Max greyscale value
            // LC: Dynamic range to be visualized[dB]
            Double gain = 0; // Brightness gain[dB]
            // referenceMaxVoxel: if 0.0 use the brightest voxel of the image, else this value

            Double image_upper_limit_N = 1; // Shallow trimming unsupported for now
            Double image_lower_limit_N = Math.Round(r * 2 / probe.c * probe.fs);
            // The pre-scan convert image has a different axis system (TODO change this nonsense):
            // X = radius, Y = azimuth, Z = elevation
            UInt32 original_depth = preSCImage.GetSizeX();
            UInt32 original_width = preSCImage.GetSizeY();
            UInt32 original_height = preSCImage.GetSizeZ();

            // We need the width and height to be an odd number, to be symmetric around the central line of sight.
            UInt32 half_image_width = Convert.ToUInt32(Math.Ceiling(image_depth * Math.Sin(xz_sector / 2)));
            UInt32 image_width = 2 * half_image_width + 1; // new X axis
            UInt32 half_image_height = Convert.ToUInt32(Math.Ceiling(image_depth * Math.Sin(yz_sector / 2)));
            UInt32 image_height = 2 * half_image_height + 1; // new Y axis

            CPostScanConvertImage image = new CPostScanConvertImage(image_width, image_height, image_depth);

            // Since the image's axial resolution may not be based on the full
            // available axial information, scale appropriately
            double samples_per_depth = (image_lower_limit_N - image_upper_limit_N) / original_depth;
            image_upper_limit_N = Math.Round(image_upper_limit_N / samples_per_depth) + 1;
            image_lower_limit_N = Math.Round(image_lower_limit_N / samples_per_depth);

            // Unless log compression is necessary, the scan conversion will operate on the input image.
            CPreScanConvertImage inputImage = preSCImage;

            // Adjust image brightness
            if (enable_log_compression)
            {
                // Here, however, we must introduce a new temporary image.
                inputImage = new CPreScanConvertImage(preSCImage.GetSizeX(), preSCImage.GetSizeY(), preSCImage.GetSizeZ());

                Double im_max;  // Max image amplitude for auto - gain
                if (referenceMaxVoxel == 0.0)
                    im_max = preSCImage.GetMaxValue();
                else
                    im_max = referenceMaxVoxel;
                Double im_adj = im_max * Math.Pow(10, (-gain / 20));

                for (UInt32 k = 0; k < original_depth; k++)
                {
                    for (UInt32 j = 0; j < original_width; j++)
                    {
                        for (UInt32 i = 0; i < original_height; i++)
                        {
                            // log compress the demodulated image with top value at im_adj
                            inputImage.SetPixel(k, j, i, Math.Min(Math.Max(0, GSmax * (1.0 + (20.0 / LC * Math.Log10(Math.Max(1e-12, preSCImage.GetPixel(k, j, i) / im_adj))))), GSmax));
                        }
                    }
                }
            }

            // Low - pass imaging filter cutoff frequency
            // Double fs = probe.fs / samples_per_depth;
            // TODO this comes straight from Matlab
            // Double[] b_lp = {  };
            // Double[] a_lp = {  };
            //for (UInt32 j = 0; j < original_width; j++) // Azimuth lines
            //{
            //    for (UInt32 i = 0; i < original_height; i++) // Elevation lines
            //    {
            //        Double[] image_line = new Double[original_depth];
            //        for (UInt32 k = 0; k < original_depth; k++)
            //            image_line[k] = preSCImage.GetPixel(k, j, i);
            //        Double[] filtered_image_line = new Double[original_depth];
            //        // DemodulateRFImageSimple(probe.f0, fs, image_line, b_lp, a_lp, ref filtered_image_line);
            //        for (UInt32 k = 0; k < original_depth; k++)
            //            preSCImage.SetPixel(k, j, i, filtered_image_line[k]);
            //    }
            //}

            // Color of the region outside the imaging cone. 127 (middle gray) is
            // a good color as the image will be ranging from black to white.
            UInt32 background_level = 127;

            UInt32 old_x = inputImage.GetSizeX();
            UInt32 old_y = inputImage.GetSizeY();
            UInt32 old_z = inputImage.GetSizeZ();

            var watch = System.Diagnostics.Stopwatch.StartNew();
            Debug.WriteLine(string.Format("Scan converting {0} lines", image_depth));

            Double xScaling = ((original_depth + image_upper_limit_N) / image_depth);
            Double yScaling = ((original_width + 1) / xz_sector);
            // If 2D imaging, yz_sector == 0, and zScaling is unused
            Double zScaling = (yz_sector > 0 ? ((original_height + 1) / yz_sector) : 1);

            for (Int32 new_z_index = 0; new_z_index < image_depth; new_z_index++)
            {
                for (Int32 new_y_index = 0; new_y_index < image_height; new_y_index++)
                {
                    for (Int32 new_x_index = 0; new_x_index < image_width; new_x_index++)
                    {
                        Double xIndex = new_x_index - half_image_width;
                        Double yIndex = new_y_index - half_image_height;
                        Double zIndex = new_z_index;

                        Double old_x_location = Math.Sqrt(xIndex * xIndex + yIndex * yIndex + new_z_index * new_z_index) * xScaling;
                        Double old_y_location = ((xz_sector / 2) + Math.Atan(xIndex / Math.Sqrt(yIndex * yIndex + new_z_index * new_z_index))) * yScaling;
                        Double old_z_location = ((yz_sector / 2) + Math.Atan(yIndex / new_z_index)) * zScaling;

                        if (old_x_location >= old_x || old_y_location >= old_y || old_z_location >= old_z || old_x_location < 1 || old_y_location < 1 || old_z_location < 0)
                            image.SetPixel(Convert.ToUInt32(new_x_index), Convert.ToUInt32(new_y_index), Convert.ToUInt32(new_z_index), background_level);
                        else
                        {
                            UInt32 old_x_index = Convert.ToUInt32(Math.Floor(old_x_location));
                            UInt32 old_y_index = Convert.ToUInt32(Math.Floor(old_y_location));
                            UInt32 old_z_index = Convert.ToUInt32(Math.Floor(old_z_location));

                            // Get the eight nearest points to(x, y, z) with wrap-around
                            // Normally old_z_index >= 1, but since in the 2D case old_z_index == 0,
                            // adjust the code to tolerate this event (becomes bilinear interpolation)
                            Double c000 = inputImage.GetPixel(old_x_index - 1, old_y_index - 1, (uint)Math.Max(0, (int)old_z_index - 1));
                            Double c100 = inputImage.GetPixel(old_x_index, old_y_index - 1, (uint)Math.Max(0, (int)old_z_index - 1));
                            Double c010 = inputImage.GetPixel(old_x_index - 1, old_y_index, (uint)Math.Max(0, (int)old_z_index - 1));
                            Double c110 = inputImage.GetPixel(old_x_index, old_y_index, (uint)Math.Max(0, (int)old_z_index - 1));

                            Double c001 = inputImage.GetPixel(old_x_index - 1, old_y_index - 1, old_z_index);
                            Double c101 = inputImage.GetPixel(old_x_index, old_y_index - 1, old_z_index);
                            Double c011 = inputImage.GetPixel(old_x_index - 1, old_y_index, old_z_index);
                            Double c111 = inputImage.GetPixel(old_x_index, old_y_index, old_z_index);

                            // Interpolate over them
                            Double InterpVal = trilinearInterpolation(c000, c100, c010, c110, c001, c101, c011, c111, old_x_location - old_x_index, old_y_location - old_y_index, old_z_location - old_z_index);
                            image.SetPixel(Convert.ToUInt32(new_x_index), Convert.ToUInt32(new_y_index), Convert.ToUInt32(new_z_index), InterpVal);
                        }
                    }
                }
            }

            watch.Stop();
            Debug.WriteLine(string.Format("Scan conversion took {0} ms", watch.ElapsedMilliseconds));

            return image;
        }

        public Bitmap ScanConvertBitmap(CPreScanConvertImage preSCImage, UInt32 image_depth, Double xz_sector, Double yz_sector, Double r, bool enable_log_compression, Int32 x_cut, Int32 y_cut, Int32 z_cut, UInt32 LC, Double referenceMaxVoxel)
        {
            if ((x_cut < 0 && y_cut < 0 && z_cut < 0) || (x_cut >= 0 && y_cut >= 0) || (x_cut >= 0 && z_cut >= 0) || (y_cut >= 0 && z_cut >= 0))
            {
                throw new System.ArgumentException("Please define one and only one axis on which to provide a cut");
            }

            UInt32 GSmax = 255; // Max greyscale value
            // LC: Dynamic range to be visualized[dB]
            Double gain = 0; // Brightness gain[dB]
            // referenceMaxVoxel: if 0.0 use the brightest voxel of the image, else this value

            Double image_upper_limit_N = 1; // Shallow trimming unsupported for now
            Double image_lower_limit_N = Math.Round(r * 2 / probe.c * probe.fs);

            // The pre-scan convert image has a different axis system (TODO change this nonsense):
            // X = radius, Y = azimuth, Z = elevation
            UInt32 original_depth = preSCImage.GetSizeX();
            UInt32 original_width = preSCImage.GetSizeY();
            UInt32 original_height = preSCImage.GetSizeZ();

            // We need the width and height to be an odd number, to be symmetric around the central line of sight.
            UInt32 half_image_width = Convert.ToUInt32(Math.Ceiling(image_depth * Math.Sin(xz_sector / 2)));
            UInt32 image_width = 2 * half_image_width + 1; // X axis
            UInt32 half_image_height = Convert.ToUInt32(Math.Ceiling(image_depth * Math.Sin(yz_sector / 2)));
            UInt32 image_height = 2 * half_image_height + 1; // Y axis

            // Since the image's axial resolution may not be based on the full
            // available axial information, scale appropriately
            double samples_per_depth = (image_lower_limit_N - image_upper_limit_N) / original_depth;
            image_upper_limit_N = Math.Round(image_upper_limit_N / samples_per_depth) + 1;
            image_lower_limit_N = Math.Round(image_lower_limit_N / samples_per_depth);

            // Unless log compression is necessary, the scan conversion will operate on the input image.
            CPreScanConvertImage inputImage = preSCImage;

            // Adjust image brightness
            if (enable_log_compression)
            {
                // Here, however, we must introduce a new temporary image.
                inputImage = new CPreScanConvertImage(preSCImage.GetSizeX(), preSCImage.GetSizeY(), preSCImage.GetSizeZ());

                Double im_max;  // Max image amplitude for auto - gain
                if (referenceMaxVoxel == 0.0)
                    im_max = preSCImage.GetMaxValue();
                else
                    im_max = referenceMaxVoxel;
                double im_adj = im_max * Math.Pow(10, (-gain / 20));
                // Safety clause just in case the returned image is all black
                if (im_adj == 0)
                    im_adj = 1;

                for (UInt32 k = 0; k < original_depth; k++)
                {
                    for (UInt32 j = 0; j < original_width; j++)
                    {
                        for (UInt32 i = 0; i < original_height; i++)
                        {
                            // log compress the demodulated image with top value at im_adj
                            inputImage.SetPixel(k, j, i, Math.Min(Math.Max(0, GSmax * (1.0 + (20.0 / LC * Math.Log10(Math.Max(1e-12, preSCImage.GetPixel(k, j, i) / im_adj))))), GSmax));
                        }
                    }
                }
            }

            // Color of the region outside the imaging cone. 127 (middle gray) is
            // a good color as the image will be ranging from black to white.
            UInt32 background_level = 127;

            UInt32 old_x = inputImage.GetSizeX();
            UInt32 old_y = inputImage.GetSizeY();
            UInt32 old_z = inputImage.GetSizeZ();

            Double xScaling = ((original_depth + image_upper_limit_N) / image_depth);
            Double yScaling = ((original_width + 1) / xz_sector);
            // If 2D imaging, yz_sector == 0, and zScaling is unused
            Double zScaling = (yz_sector > 0 ? ((original_height + 1) / yz_sector) : 1);

            Int32 size1 = 0, size2 = 0;
            Int32 min_x, max_x, min_y, max_y, min_z, max_z;

            if (x_cut >= 0)
            {
                if (yz_sector > 0)
                    size1 = Convert.ToInt32(image_height);
                // If 2D imaging, forcefully widen the image canvas into a square (it will just stay black)
                else
                    size1 = Convert.ToInt32(image_width);
                size2 = Convert.ToInt32(image_depth);
                min_x = x_cut;
                max_x = x_cut + 1;
                min_y = 0;
                max_y = Convert.ToInt32(image_height);
                min_z = 0;
                max_z = Convert.ToInt32(image_depth);
            }
            else if (y_cut >= 0)
            {
                size1 = Convert.ToInt32(image_width);
                size2 = Convert.ToInt32(image_depth);
                min_x = 0;
                max_x = Convert.ToInt32(image_width);
                min_y = y_cut;
                max_y = y_cut + 1;
                min_z = 0;
                max_z = Convert.ToInt32(image_depth);
            }
            else // z_cut >= 0
            {
                size1 = Convert.ToInt32(image_width);
                if (yz_sector > 0)
                    size2 = Convert.ToInt32(image_height);
                // If 2D imaging, forcefully widen the image canvas into a square (it will just stay black)
                else
                    size2 = Convert.ToInt32(image_width);
                min_x = 0;
                max_x = Convert.ToInt32(image_width);
                min_y = 0;
                max_y = Convert.ToInt32(image_height);
                min_z = z_cut;
                max_z = z_cut + 1;
            }
            Double [,] scImage = new Double[size1, size2];
            System.Drawing.Bitmap bmp = new Bitmap(size1, size2, System.Drawing.Imaging.PixelFormat.Format24bppRgb);

            for (Int32 new_z_index = min_z; new_z_index < max_z; new_z_index++)
            {
                for (Int32 new_y_index = min_y; new_y_index < max_y; new_y_index++)
                {
                    for (Int32 new_x_index = min_x; new_x_index < max_x; new_x_index++)
                    {
                        Double xIndex = new_x_index - half_image_width;
                        Double yIndex = new_y_index - half_image_height;
                        Double zIndex = new_z_index;

                        Double old_x_location = Math.Sqrt(xIndex * xIndex + yIndex * yIndex + new_z_index * new_z_index) * xScaling;
                        Double old_y_location = ((xz_sector / 2) + Math.Atan(xIndex / Math.Sqrt(yIndex * yIndex + new_z_index * new_z_index))) * yScaling;
                        Double old_z_location = ((yz_sector / 2) + Math.Atan(yIndex / new_z_index)) * zScaling;

                        if (old_x_location >= old_x || old_y_location >= old_y || old_z_location >= old_z || old_x_location < 1 || old_y_location < 1 || old_z_location < 0)
                        {
                            if (x_cut >= 0)
                            {
                                scImage[new_y_index, new_z_index] = background_level;
                            }
                            else if (y_cut >= 0)
                            {
                                scImage[new_x_index, new_z_index] = background_level;
                            }
                            else // z_cut >= 0
                            {
                                scImage[new_x_index, new_y_index] = background_level;
                            }
                        }
                        else
                        {
                            UInt32 old_x_index = Convert.ToUInt32(Math.Floor(old_x_location));
                            UInt32 old_y_index = Convert.ToUInt32(Math.Floor(old_y_location));
                            UInt32 old_z_index = Convert.ToUInt32(Math.Floor(old_z_location));

                            // Get the eight nearest points to(x, y, z) with wrap-around
                            // Normally old_z_index >= 1, but since in the 2D case old_z_index == 0,
                            // adjust the code to tolerate this event (becomes bilinear interpolation)
                            Double c000 = inputImage.GetPixel(old_x_index - 1, old_y_index - 1, (uint)Math.Max(0, (int)old_z_index - 1));
                            Double c100 = inputImage.GetPixel(old_x_index, old_y_index - 1, (uint)Math.Max(0, (int)old_z_index - 1));
                            Double c010 = inputImage.GetPixel(old_x_index - 1, old_y_index, (uint)Math.Max(0, (int)old_z_index - 1));
                            Double c110 = inputImage.GetPixel(old_x_index, old_y_index, (uint)Math.Max(0, (int)old_z_index - 1));

                            Double c001 = inputImage.GetPixel(old_x_index - 1, old_y_index - 1, old_z_index);
                            Double c101 = inputImage.GetPixel(old_x_index, old_y_index - 1, old_z_index);
                            Double c011 = inputImage.GetPixel(old_x_index - 1, old_y_index, old_z_index);
                            Double c111 = inputImage.GetPixel(old_x_index, old_y_index, old_z_index);

                            // Interpolate over them
                            Double InterpVal = trilinearInterpolation(c000, c100, c010, c110, c001, c101, c011, c111, old_x_location - old_x_index, old_y_location - old_y_index, old_z_location - old_z_index);
                            if (x_cut >= 0)
                            {
                                scImage[new_y_index, new_z_index] = InterpVal;
                            }
                            else if (y_cut >= 0)
                            {
                                scImage[new_x_index, new_z_index] = InterpVal;
                            }
                            else // z_cut >= 0
                            {
                                scImage[new_x_index, new_y_index] = InterpVal;
                            }
                        }
                    }
                }
            }

            return imageSliceToBitmap(scImage);
        }

        public Bitmap imageSliceToBitmap(Double [,] imageSlice)
        {
            System.Drawing.Bitmap bmp = new Bitmap(imageSlice.GetLength(0), imageSlice.GetLength(1), System.Drawing.Imaging.PixelFormat.Format24bppRgb);

            // TODO this brightness adjustment works, but there is no guarantee that it will precisely match the
            // reference image, which finds the min/max values over the whole SC volume.
            Double minValue = Double.MaxValue;
            Double maxValue = Double.MinValue;
            for (Int32 ind1 = 0; ind1 < imageSlice.GetLength(0); ind1++)
            {
                for (Int32 ind2 = 0; ind2 < imageSlice.GetLength(1); ind2++)
                {
                    Double pixel = imageSlice[ind1, ind2];
                    if (pixel < minValue)
                        minValue = pixel;
                    if (pixel > maxValue)
                        maxValue = pixel;
                }
            }
            for (Int32 ind1 = 0; ind1 < imageSlice.GetLength(0); ind1++)
            {
                for (Int32 ind2 = 0; ind2 < imageSlice.GetLength(1); ind2++)
                {
                    Double pixel = imageSlice[ind1, ind2];
                    Double brightness;
                    if (minValue != maxValue) // Rare case where a whole cross-section may be "black"
                        brightness = 255 * (pixel - minValue) / (maxValue - minValue);
                    else
                        brightness = 0;
                    Byte b = Convert.ToByte(Math.Round(brightness));
                    System.Drawing.Color c = System.Drawing.Color.FromArgb(b, b, b);
                    bmp.SetPixel(ind1, ind2, c);
                }
            }

            return bmp;
        }

        // Interpolates start & end values to find the value of a point at start+distance.
        // (The distance of the points that start & end values correspond is always 1.
        // Thus that division is omitted from the calculation.)
        private Double linearInterpolation(Double start, Double finish, Double distance)
        {
            return start + (finish - start) * distance;
        }

        // Interpolate the values of four points, using the bilinear interpolation, to find the value of
        // the point that is at(tx, tv) from the top-left point(which has value c00)
        private Double bilinearInterpolation(Double c00, Double c10, Double c01, Double c11, Double tx, Double ty)
        {
            return linearInterpolation(linearInterpolation(c00, c10, tx), linearInterpolation(c01, c11, tx), ty);
        }

        // Interpolate the values of four points, using the bilinear interpolation, to find the value of
        // the point that is at(tx, tv, tz) from the top-left point(which has value c000). The points are
        // described as cXYZ with each of X,Y,Z value of 1 means that we have moved down that axis.
        // e.g., c001 is the top-left-far and c111 is the top-right-far one.
        private Double trilinearInterpolation(Double c000, Double c100, Double c010, Double c110, Double c001, Double c101, Double c011, Double c111, Double tx, Double ty, Double tz)
        {
            return linearInterpolation(linearInterpolation(linearInterpolation(c000, c100, tx), linearInterpolation(c010, c110, tx), ty), linearInterpolation(linearInterpolation(c001, c101, tx), linearInterpolation(c011, c111, tx), ty), tz);
        }
    }
}
