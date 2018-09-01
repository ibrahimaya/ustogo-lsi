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

namespace VirtualScopeNS.Components {
	/// <summary>
	/// Summary description for CConfig.
	/// </summary>
	public class CConfig {

		private string path;

		private string host = "192.168.1.10";
		private int port = 7;
        private UInt32 clk_freq_mhz = 100;

        public CConfig()
        {
			path = System.Windows.Forms.Application.StartupPath;
			if(path.StartsWith("/"))
				path += "/config.txt";
			else
				path += "\\config.txt";
		}

		public bool Read()
        {
			bool rez = false;

			System.IO.StreamReader rd = null;
			try
            {
				rd = new System.IO.StreamReader(path);
				
				string line;
				while((line = rd.ReadLine()) != null){
					string[] str = line.Split('=');
					switch(str[0]){
						case "HOST":
							host = str[1];
							break;
						case "PORT":
							port = System.Convert.ToInt32(str[1], 10);
							break;
                        case "CLK":
							clk_freq_mhz = System.Convert.ToUInt32(str[1], 10);
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

		public void Write()
        {
			
			System.IO.StreamWriter wr = null;
			
			try
            {
				wr = new System.IO.StreamWriter(path);

				wr.WriteLine("HOST=" + host);
				wr.WriteLine("PORT=" + port.ToString());
                wr.WriteLine("CLK="  + clk_freq_mhz.ToString());
            }
            catch (System.IO.IOException ex)
            {
				Console.WriteLine(ex.ToString());
			}
            finally
            {
				if (wr != null)
					wr.Close();
			}
				
		}

		public string Host
        {
			get
            {
				return host;
			}
			set
            {
				host = value;
			}
		}
		
		public int Port
        {
			get
            {
				return port;
			}
			set
            {
				port = value;
			}
		}

        public UInt32 ClkFrequencyMHz
        {
			get
            {
				return clk_freq_mhz;
			}
			set
            {
				clk_freq_mhz = value;
			}
		}
    }
}
