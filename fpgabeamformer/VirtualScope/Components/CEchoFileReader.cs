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
using System.IO;

namespace VirtualScopeNS.Components
{
    /// <summary>
    /// Summary description for CEchoFileReader.
    /// </summary>
    public class CEchoFileReader
    {
        private UInt32 xElements, yElements, BRAMCount;
        private Int32 samplesPerBRAM;
        private Int32[,] echoData;
        private bool ReadSecondChannel;

        public CEchoFileReader(UInt32 xElements, UInt32 yElements, Int32 samplesPerBRAM)
        {
            this.xElements = xElements;
            this.yElements = yElements;
            this.BRAMCount = (yElements > 1 ? (xElements * yElements / 2) : (xElements * yElements));
            this.ReadSecondChannel = (yElements > 1);
            // Pass a negative number for when the length is unknown and must be figured from the echo file at runtime.
            this.samplesPerBRAM = samplesPerBRAM;
        }

        public bool Read(string path, string namePrefix, UInt16 nappeIndex, bool readAllAvailable, UInt32 insonificationIndex, Int32 zoneCount, Int32 compoundCount)
        {
            bool rez = false;

            System.IO.StreamReader rdOdd = null, rdEven = null;

            string fileNameOdd, fileNameEven;
            string infix;
            if (compoundCount > 1)
                infix = "_compounding_";
            else
                infix = "_zone_";

            // For UBLZ mode: we will read just one file at a time, pointed to by insonificationIndex
            // For STRM mode: read and concatenate multiple files, from 1 to insonificationIndex
            UInt32 lowIterBound, highIterBound;
            if (readAllAvailable)
            {
                lowIterBound = 1;
                highIterBound = insonificationIndex;
            }
            else
            {
                // The outside naming convention starts from 0, but the files on disk are numbered from 1
                lowIterBound = insonificationIndex + 1;
                highIterBound = insonificationIndex + 1;
            }

            UInt32 echoLengthToDate = 0;

            for (UInt32 fileIter = lowIterBound; fileIter <= highIterBound; fileIter++)
            {
                fileNameOdd = path + namePrefix + "_rfa_" + nappeIndex.ToString().PadLeft(3, '0') + infix + fileIter + ".txt";
                fileNameEven = path + namePrefix + "_rfb_" + nappeIndex.ToString().PadLeft(3, '0') + infix + fileIter + ".txt";

                if (System.IO.File.Exists(fileNameOdd))
                {
                    int TableLines = samplesPerBRAM;
                    if (samplesPerBRAM < 0)
                        TableLines = File.ReadAllLines(fileNameOdd).Length / (int)BRAMCount;

                    // At first iteration, just initialize
                    if (echoLengthToDate == 0)
                    {
                        echoData = new Int32[TableLines, BRAMCount];
                    }
                    else
                    {
                        // Support array, that will concatenate the new data below the existing echoData
                        var temp = Array.CreateInstance(typeof(Int32), echoLengthToDate + TableLines, BRAMCount);
                        Array.ConstrainedCopy(echoData, 0, temp, 0, echoData.Length);
                        echoData = (Int32[,])temp;
                    }

                    rdOdd = new System.IO.StreamReader(fileNameOdd);
                    if (ReadSecondChannel)
                        rdEven = new System.IO.StreamReader(fileNameEven);

                    string lineOdd, lineEven = null;
                    UInt32 echoCounter = echoLengthToDate, elementCounter = 0;
                    while ((lineOdd = rdOdd.ReadLine()) != null && (!ReadSecondChannel || (lineEven = rdEven.ReadLine()) != null))
                    {
                        Int32 value = 0;
                        if (lineOdd.Length > 16 || (ReadSecondChannel && lineEven.Length > 16))
                        {
                            Console.WriteLine(fileNameOdd + ", " + fileNameEven);
                            Console.WriteLine("Conversion issue: file has lines longer than 16 bits");
                        }
                        for (UInt16 ch = 0; ch < lineOdd.Length; ch++)
                        {
                            if (lineOdd[lineOdd.Length - 1 - ch] == '1')
                                value += (Int32)Math.Pow(2, ch);
                            else if (lineOdd[lineOdd.Length - 1 - ch] != '0')
                            {
                                Console.WriteLine(fileNameOdd);
                                Console.WriteLine("Conversion issue at line: " + lineOdd);
                            }
                        }
                        if (ReadSecondChannel)
                        {
                            for (UInt16 ch = 0; ch < lineEven.Length; ch++)
                            {
                                if (lineEven[lineEven.Length - 1 - ch] == '1')
                                    value += (Int32)Math.Pow(2, ch + lineEven.Length);
                                else if (lineEven[lineEven.Length - 1 - ch] != '0')
                                {
                                    Console.WriteLine(fileNameEven);
                                    Console.WriteLine("Conversion issue at line: " + lineEven);
                                }
                            }
                        }
                        echoData[echoCounter, elementCounter] = value;

                        if (elementCounter < BRAMCount - 1)
                            elementCounter++;
                        else
                        {
                            elementCounter = 0;
                            if (echoCounter < TableLines + echoLengthToDate - 1)
                                echoCounter++;
                            else
                                echoCounter = 0;
                        }
                    }

                    rdOdd.Close();
                    if (ReadSecondChannel)
                        rdEven.Close();
                    rez = true;

                    echoLengthToDate += (UInt32)TableLines;
                }
                else
                {
                    rez = false;
                }
            }

            return rez;
        }

        public Int32[,] Echoes()
        {
            return echoData;
        }

        public Int32 EchoLength()
        {
            if (echoData != null)
                return echoData.GetLength(0);
            else
                return 0;
        }
    }
}
