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
using System.Net;
using System.Net.Sockets;
using System.Threading;
using System.Text;

namespace VirtualScopeNS.Components {
	/// <summary>
	/// Summary description for CTCPclient.
	/// </summary>
	/// 

	public delegate void DataReceivedEventHandler(object source, byte[] values);
	public delegate void StateChangedEventHandler(object source, bool connected);

	public class CTCPclient {
		
		public event StateChangedEventHandler StateChangedEvent;
		public event DataReceivedEventHandler DataReceivedEvent;

		private Socket socket = null;
		private string host;
		private int port;
		private System.Threading.Thread thread = null;
		private bool isopened = false;
		private object locker = new object();

		public CTCPclient() {
			this.host = "127.0.0.1";
			this.port = 1000;
		}

		public void Connect(string host, int port){
			this.host = host;
			this.port = port;
			thread = new System.Threading.Thread(new System.Threading.ThreadStart(this.ThreadHandler));
			thread.Name = "TCPReceive";
			thread.Start();
		}

		public void ThreadHandler(){
			// Data buffer for incoming data. Supports a maximum of 2400 bytes per packet.
			System.Byte[] bytes = new System.Byte[2400];

			// Connect to a remote device.
			try {
                // Establish the remote endpoint for the socket.
                // This example uses port 11000 on the local computer.
                IPHostEntry ipHostInfo = Dns.Resolve(host);
				IPAddress ipAddress = ipHostInfo.AddressList[0];
				IPEndPoint remoteEP = new IPEndPoint(ipAddress, port);

				// Create a TCP/IP  socket.
				socket = new Socket(AddressFamily.InterNetwork,	SocketType.Stream, ProtocolType.Tcp );

				// Connect the socket to the remote endpoint. Catch any errors.
				try {
					socket.Connect(remoteEP);
					lock(locker){
						isopened = true;
					}
					if(StateChangedEvent != null)
						StateChangedEvent(this, true);

					
					// Receive the response from the remote device.
					int bytesRec = 1;
					while(bytesRec > 0){
						bytesRec = socket.Receive(bytes);
						if(bytesRec > 0){
							byte[] values = new byte[bytesRec];
							int j = 0;
							for(int i = 0; i < bytesRec; i++){
								values[i] = bytes[j++];
							}
							DataReceivedEvent(this, values);
						}
					}
					// Release the socket.
					lock(locker){
						socket.Shutdown(SocketShutdown.Both);
						socket.Close();
						isopened = false;
						socket = null;
					}
					if(StateChangedEvent != null)
						StateChangedEvent(this, false);
                
				} catch (ArgumentNullException ane) {
					Console.WriteLine("ArgumentNullException : {0}",ane.ToString());
				} catch (SocketException se) {
					lock(locker){
						socket.Close();
						isopened = false;
						socket = null;
					}
					Console.WriteLine("SocketException : {0}",se.ToString());
				} catch (ThreadAbortException abort) {
					lock(locker){
						socket.Shutdown(SocketShutdown.Both);
						socket.Close();
						isopened = false;
						socket = null;
					}
					Console.WriteLine("Thread aborting : {0}", abort.ToString());
				} catch (Exception e) {
					Console.WriteLine("Unexpected exception : {0}", e.ToString());
				}

				if(StateChangedEvent != null)
					StateChangedEvent(this, false);
			
			} catch (Exception e) {
				Console.WriteLine( e.ToString());
			}
		
		}

		public int Send(string data){
			int bytesSent = 0;
			try {
				try {
					byte[] msg = Encoding.ASCII.GetBytes(data);

					// Send the data through the socket.
					lock(locker){
						if(isopened)
							bytesSent = socket.Send(msg);
					}
				} catch (ArgumentNullException ane) {
					Console.WriteLine("ArgumentNullException : {0}",ane.ToString());
				} catch (SocketException se) {
					Console.WriteLine("SocketException : {0}",se.ToString());
				} catch (Exception e) {
					Console.WriteLine("Unexpected exception : {0}", e.ToString());
				}
			} catch (Exception e) {
				Console.WriteLine( e.ToString());
			}
			return bytesSent;
		}

        public int Send(byte[] data)
        {
            int bytesSent = 0;
            try
            {
                try
                {
                    // Send the data through the socket.
                    lock (locker)
                    {
                        if (isopened)
                            bytesSent = socket.Send(data);
                    }
                }
                catch (ArgumentNullException ane)
                {
                    Console.WriteLine("ArgumentNullException : {0}", ane.ToString());
                }
                catch (SocketException se)
                {
                    Console.WriteLine("SocketException : {0}", se.ToString());
                }
                catch (Exception e)
                {
                    Console.WriteLine("Unexpected exception : {0}", e.ToString());
                }
            }
            catch (Exception e)
            {
                Console.WriteLine(e.ToString());
            }
            return bytesSent;
        }


        public bool IsOpened {
			get {
				bool b;
				lock(locker){
					b = isopened;
				}
				return b;
			}
		}

		public void Disconnect(){
			if(thread == null || socket == null)
				return;
			socket.Shutdown(SocketShutdown.Both);
            // thread.Join(); TODO this call used to work, but now just freezes the GUI on disconnection.
            thread.Abort(); // so just abort it instead.
			thread = null;
			if(StateChangedEvent != null)
				StateChangedEvent(this, false);
		}

	}
}
