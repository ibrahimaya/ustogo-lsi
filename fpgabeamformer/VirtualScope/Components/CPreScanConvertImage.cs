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
using System.Drawing;

namespace VirtualScopeNS.Components
{
    /// <summary>
    /// Summary description for CPreScanConvertImage.
    /// </summary>
    public class CPreScanConvertImage
    {
        private double[,,] image;

        private UInt32 size_x = 0, size_y = 0, size_z = 0;
        private UInt32 current_x = 0, current_y = 0, current_z = 0;

        public CPreScanConvertImage(UInt32 size_x, UInt32 size_y, UInt32 size_z)
        {
            image = new double[size_x, size_y, size_z];
            this.size_x = size_x;
            this.size_y = size_y;
            this.size_z = size_z;
            current_x = 0;
            current_y = 0;
            current_z = 0;
        }

        public CPreScanConvertImage(double[,,] sourceImage)
        {
            size_x = Convert.ToUInt32(sourceImage.GetLength(0));
            size_y = Convert.ToUInt32(sourceImage.GetLength(1));
            size_z = Convert.ToUInt32(sourceImage.GetLength(2));

            image = new double[size_x, size_y, size_z];
            
            current_x = 0;
            current_y = 0;
            current_z = 0;

            for (UInt32 x = 0; x < size_x; x++)
            {
                for (UInt32 y = 0; y < size_y; y++)
                {
                    for (UInt32 z = 0; z < size_z; z++)
                    {
                        image[x, y, z] = sourceImage[x, y, z];
                    }
                }
            }

        }

        public int AddPixel(double pixel)
        {
            image[current_x, current_y, current_z] = pixel;
            // From the FPGA, we will get voxels elevation-first, then along the azimuth, then along the radius
            // These coordinates are by default assumed to be expressed as Z, Y, X respectively in the code
            // So, start filling along the Z, then Y, then X
            if (current_z + 1 < size_z)
            {
                current_z++;
                return 0;
            }
            else if (current_y + 1 < size_y)
            {
                current_z = 0;
                current_y++;
                return 0;
            }
            else
            {
                current_z = 0;
                current_y = 0;
                if (current_x + 1 < size_x)
                {
                    current_x++;
                    return 0;
                }
                else
                {
                    // Still increase the pointer by 1 to distinguish
                    // between "filling in last voxel" and "last voxel filled"
                    current_x++;
                    return 1;
                }
            }
        }

        public bool IsComplete()
        {
            if (current_x + 1 == size_x && current_y + 1 == size_y && current_z == size_z)
                return true;
            else
                return false;
        }

        public void Clear()
        {
            current_x = 0;
            current_y = 0;
            current_z = 0;
        }

        public System.Drawing.Bitmap GetBitmap(Int32 x_cut, Int32 y_cut, Int32 z_cut)
        {
            if ((x_cut < 0 && y_cut < 0 && z_cut < 0) || (x_cut >= 0 && y_cut >= 0) || (x_cut >= 0 && z_cut >= 0) || (y_cut >= 0 && z_cut >= 0))
            {
                throw new System.ArgumentException("Please define one and only one axis on which to provide a cut");
            }

            System.Drawing.Bitmap bmp;

            Int32 size1 = 0, size2 = 0;
            if (x_cut >= 0)
            {
                size1 = Convert.ToInt32(size_y);
                size2 = Convert.ToInt32(size_z);
            }
            else if (y_cut >= 0)
            {
                size1 = Convert.ToInt32(size_x);
                size2 = Convert.ToInt32(size_z);
            }
            else // z_cut >= 0
            {
                size1 = Convert.ToInt32(size_x);
                size2 = Convert.ToInt32(size_y);
            }

            Double minValue = GetMinValue();
            Double maxValue = GetMaxValue();

            bmp = new Bitmap(size1, size2, System.Drawing.Imaging.PixelFormat.Format24bppRgb);
            for (Int32 ind1 = 0; ind1 < size1; ind1++)
            {
                for (Int32 ind2 = 0; ind2 < size2; ind2++)
                {
                    Double value;
                    if (x_cut >= 0)
                    {
                        value = image[x_cut, ind1, ind2];
                    }
                    else if (y_cut >= 0)
                    {
                        value = image[ind1, y_cut, ind2];
                    }
                    else // z_cut >= 0
                    {
                        value = image[ind1, ind2, z_cut];
                    }
                    Double brightness = 255 * (value - minValue) / (maxValue - minValue);
                    Byte b = Convert.ToByte(Math.Round(brightness));
                    System.Drawing.Color c = System.Drawing.Color.FromArgb(b, b, b);
                    bmp.SetPixel(ind1, ind2, c);
                }
            }

            return bmp;
        }

        public double GetPixel(UInt32 x_index, UInt32 y_index, UInt32 z_index)
        {
            if (x_index >= size_x || y_index >= size_y || z_index >= size_z)
            {
                throw new System.ArgumentException("The specified coordinates exceed the image size");
            }
            return image[x_index, y_index, z_index];
        }

        public void SetPixel(UInt32 x_index, UInt32 y_index, UInt32 z_index, double value)
        {
            if (x_index >= size_x || y_index >= size_y || z_index >= size_z)
            {
                throw new System.ArgumentException("The specified coordinates exceed the image size");
            }
            image[x_index, y_index, z_index] = value;
        }

        public void FillRandom()
        {
            Random rnd = new Random();
            for (UInt32 x = 0; x < size_x; x++)
            {
                for (UInt32 y = 0; y < size_y; y++)
                {
                    for (UInt32 z = 0; z < size_z; z++)
                    {
                        image[x, y, z] = rnd.Next(255);
                    }
                }
            }
        }

        public Double GetMinValue()
        {
            Double min = Double.MaxValue;
            for (UInt32 x = 0; x < size_x; x++)
            {
                for (UInt32 y = 0; y < size_y; y++)
                {
                    for (UInt32 z = 0; z < size_z; z++)
                    {
                        Double val = image[x, y, z];
                        if (val < min)
                            min = val;
                    }
                }
            }
            return min;
        }

        public double GetMaxValue()
        {
            double max = -1;
            for (UInt32 x = 0; x < size_x; x++)
            {
                for (UInt32 y = 0; y < size_y; y++)
                {
                    for (UInt32 z = 0; z < size_z; z++)
                    {
                        double val = image[x, y, z];
                        if (val > max)
                            max = val;
                    }
                }
            }
            return max;
        }

        public UInt32 GetSizeX()
        {
            return size_x;
        }

        public UInt32 GetSizeY()
        {
            return size_y;
        }

        public UInt32 GetSizeZ()
        {
            return size_z;
        }
    }
}
