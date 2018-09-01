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

namespace VirtualScopeNS.Components
{
    /// <summary>
    /// Summary description for CSettings.
    /// </summary>
    public class CSettings
    {

        private string path;

        private Double f0 = 4;
        private Double fs = 32;
        private UInt32 c = 1540;
        private Double theta = 73;
        private Double phi = 73;
        private Double r = 10;
        private UInt32 N_elements_x = 32;
        private UInt32 N_elements_y = 32;
        private UInt32 radialLines = 600;
        private UInt32 azimuthLines = 64;
        private UInt32 elevationLines = 64;
        private UInt32 rfDepth = 3000;
        private Int32 zeroOffset = 0;
        private UInt32 samplesPerBRAM = 512;

        public CSettings(String filePath)
        {
            path = filePath;
        }

        public bool Read()
        {
            bool rez = false;

            System.IO.StreamReader rd = null;
            try
            {
                rd = new System.IO.StreamReader(path);

                string line;
                while ((line = rd.ReadLine()) != null)
                {
                    string[] str = line.Split('=');
                    switch (str[0])
                    {
                        case "F0":
                            f0 = System.Convert.ToDouble(str[1]);
                            break;
                        case "FS":
                            fs = System.Convert.ToDouble(str[1]);
                            break;
                        case "C":
                            c = System.Convert.ToUInt32(str[1], 10);
                            break;
                        case "THETA":
                            theta = System.Convert.ToDouble(str[1]);
                            break;
                        case "PHI":
                            phi = System.Convert.ToDouble(str[1]);
                            break;
                        case "R":
                            r = System.Convert.ToDouble(str[1]);
                            break;
                        case "NX":
                            N_elements_x = System.Convert.ToUInt32(str[1], 10);
                            break;
                        case "NY":
                            N_elements_y = System.Convert.ToUInt32(str[1], 10);
                            break;
                        case "RADLIN":
                            radialLines = System.Convert.ToUInt32(str[1], 10);
                            break;
                        case "AZILIN":
                            azimuthLines = System.Convert.ToUInt32(str[1], 10);
                            break;
                        case "ELELIN":
                            elevationLines = System.Convert.ToUInt32(str[1], 10);
                            break;
                        case "RFD":
                            rfDepth = System.Convert.ToUInt32(str[1], 10);
                            break;
                        case "ZOFF":
                            zeroOffset = System.Convert.ToInt32(str[1], 10);
                            break;
                        case "SAMPLES":
                            samplesPerBRAM = System.Convert.ToUInt32(str[1], 10);
                            break;
                    }
                }

                rez = true;
            }
            catch (System.IO.FileNotFoundException ex)
            {
                rez = false;
                Console.WriteLine(path);
                Console.WriteLine(ex.ToString());
            }
            finally
            {
                if (rd != null)
                    rd.Close();
            }

            return rez;
        }

        public Double CenterFrequencyMHz
        {
            get
            {
                return f0;
            }
        }

        public Double SamplingFrequencyMHz
        {
            get
            {
                return fs;
            }
        }

        public UInt32 SpeedOfSound
        {
            get
            {
                return c;
            }
        }

        public Double ThetaDeg
        {
            get
            {
                return theta;
            }
        }

        public Double PhiDeg
        {
            get
            {
                return phi;
            }
        }

        public Double RCentimeters
        {
            get
            {
                return r;
            }
        }

        public UInt32 ElementCountX
        {
            get
            {
                return N_elements_x;
            }
        }

        public UInt32 ElementCountY
        {
            get
            {
                return N_elements_y;
            }
        }

        public UInt32 RadialLines
        {
            get
            {
                return radialLines;
            }
        }

        public UInt32 AzimuthLines
        {
            get
            {
                return azimuthLines;
            }
        }

        public UInt32 ElevationLines
        {
            get
            {
                return elevationLines;
            }
        }

        public UInt32 RFDepth
        {
            get
            {
                return rfDepth;
            }
        }

        public Int32 ZeroOffset
        {
            get
            {
                return zeroOffset;
            }
        }

        public UInt32 SamplesInBRAM
        {
            get
            {
                return samplesPerBRAM;
            }
        }
    }
}
