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
using System.Collections;
using System.ComponentModel;
using System.Windows.Forms;

namespace VirtualScopeNS {
	/// <summary>
	/// Summary description for TCPSetup.
	/// </summary>
	public class TCPSetup : System.Windows.Forms.Form {
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.TextBox HostTextBox;
		private System.Windows.Forms.TextBox PortTextBox;
		private System.Windows.Forms.Button button1;
		private System.Windows.Forms.Button button2;
		private System.Windows.Forms.Label label7;
		private System.Windows.Forms.TextBox ClockTextBox;
        private System.Windows.Forms.Button button3;
		private System.Windows.Forms.Button SaveButton;
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.Container components = null;

		public string host;
		public int port = 7;
        public UInt32 clk_freq_mhz = 100;

        public TCPSetup() {
			//
			// Required for Windows Form Designer support
			//
			InitializeComponent();

            // TODO at boot we should use the default hardcoded values, not those on disk
        }

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        protected override void Dispose( bool disposing ) {
			if( disposing ) {
				if(components != null) {
					components.Dispose();
				}
			}
			base.Dispose( disposing );
		}

		#region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent() {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(TCPSetup));
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.HostTextBox = new System.Windows.Forms.TextBox();
            this.PortTextBox = new System.Windows.Forms.TextBox();
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.label7 = new System.Windows.Forms.Label();
            this.ClockTextBox = new System.Windows.Forms.TextBox();
            this.button3 = new System.Windows.Forms.Button();
            this.SaveButton = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.Location = new System.Drawing.Point(8, 8);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(176, 23);
            this.label1.TabIndex = 0;
            this.label1.Text = "Host name (IP):";
            // 
            // label2
            // 
            this.label2.Location = new System.Drawing.Point(8, 32);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(176, 23);
            this.label2.TabIndex = 1;
            this.label2.Text = "Port:";
            // 
            // HostTextBox
            // 
            this.HostTextBox.Location = new System.Drawing.Point(212, 8);
            this.HostTextBox.Name = "HostTextBox";
            this.HostTextBox.Size = new System.Drawing.Size(188, 22);
            this.HostTextBox.TabIndex = 1;
            // 
            // PortTextBox
            // 
            this.PortTextBox.Location = new System.Drawing.Point(212, 32);
            this.PortTextBox.Name = "PortTextBox";
            this.PortTextBox.Size = new System.Drawing.Size(188, 22);
            this.PortTextBox.TabIndex = 2;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(83, 99);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(75, 23);
            this.button1.TabIndex = 17;
            this.button1.Text = "Ok";
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(163, 99);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(75, 23);
            this.button2.TabIndex = 18;
            this.button2.Text = "Cancel";
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // label7
            // 
            this.label7.Location = new System.Drawing.Point(8, 56);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(176, 23);
            this.label7.TabIndex = 11;
            this.label7.Text = "FPGA Clock f (MHz):";
            // 
            // ClockTextBox
            // 
            this.ClockTextBox.Location = new System.Drawing.Point(212, 56);
            this.ClockTextBox.Name = "ClockTextBox";
            this.ClockTextBox.Size = new System.Drawing.Size(188, 22);
            this.ClockTextBox.TabIndex = 12;
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(323, 99);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(75, 23);
            this.button3.TabIndex = 20;
            this.button3.Text = "Load";
            this.button3.Click += new System.EventHandler(this.button3_Click);
            // 
            // SaveButton
            // 
            this.SaveButton.Location = new System.Drawing.Point(243, 99);
            this.SaveButton.Name = "SaveButton";
            this.SaveButton.Size = new System.Drawing.Size(75, 23);
            this.SaveButton.TabIndex = 19;
            this.SaveButton.Text = "Save";
            this.SaveButton.Click += new System.EventHandler(this.SaveButton_Click);
            // 
            // TCPSetup
            // 
            this.AutoScaleBaseSize = new System.Drawing.Size(6, 15);
            this.ClientSize = new System.Drawing.Size(408, 132);
            this.Controls.Add(this.SaveButton);
            this.Controls.Add(this.button3);
            this.Controls.Add(this.ClockTextBox);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.PortTextBox);
            this.Controls.Add(this.HostTextBox);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "TCPSetup";
            this.Text = "TCP Setup";
            this.Load += new System.EventHandler(this.TCPSetup_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

		}
		#endregion

		private void button1_Click(object sender, System.EventArgs e) {
			try
            {
				host = HostTextBox.Text;
				port = System.Convert.ToInt32(PortTextBox.Text);
                clk_freq_mhz = System.Convert.ToUInt32(ClockTextBox.Text);

                this.Close();
			}
            catch (System.FormatException)
            {
				MessageBox.Show(this, "Port must be an integer!!", "TCP Setup", System.Windows.Forms.MessageBoxButtons.OK, System.Windows.Forms.MessageBoxIcon.Error);
			}
		}

		private void TCPSetup_Load(object sender, System.EventArgs e) {
			HostTextBox.Text = host;
			PortTextBox.Text = port.ToString();
            ClockTextBox.Text = clk_freq_mhz.ToString();
		}

		private void button2_Click(object sender, System.EventArgs e)
        {
			this.Close();
		}

		private void button3_Click(object sender, System.EventArgs e)
        {
			VirtualScopeNS.Components.CConfig cfg = new VirtualScopeNS.Components.CConfig();
			if (cfg.Read())
            {
				HostTextBox.Text = cfg.Host;
				PortTextBox.Text = cfg.Port.ToString();
                ClockTextBox.Text = cfg.ClkFrequencyMHz.ToString();
			} 
		}

		private void SaveButton_Click(object sender, System.EventArgs e) {
			
			VirtualScopeNS.Components.CConfig cfg = new VirtualScopeNS.Components.CConfig();
			
			try
            {
				cfg.Host = HostTextBox.Text;
				cfg.Port = System.Convert.ToInt32(PortTextBox.Text);
                cfg.ClkFrequencyMHz = System.Convert.ToUInt32(ClockTextBox.Text);
                cfg.Write();

			}
            catch (System.FormatException)
            {
				MessageBox.Show(this, "Port must be an integer!", "TCP Setup", System.Windows.Forms.MessageBoxButtons.OK, System.Windows.Forms.MessageBoxIcon.Error);
			}
		}
	}
}
