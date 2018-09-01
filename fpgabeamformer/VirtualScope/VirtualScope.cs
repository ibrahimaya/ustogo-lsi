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

// Save output nappes to disk for debugging. This slows execution visibly.
#define SAVE_NAPPES

using System;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Windows.Forms;
using System.Collections.Generic;

namespace VirtualScopeNS {
    /// <summary>
    /// Summary description for Form1.
    /// </summary>
    public class VirtualScope : System.Windows.Forms.Form
    {
        enum FPGA_FSM { FPGA_DISCONNECTED, FPGA_CONNECTED, FPGA_SENDINGRF, FPGA_AWAITINGBF, FPGA_RECEIVINGNAPPES, FPGA_RECEIVINGIMAGE, FPGA_RESCANCONVERTING };
        enum COORD_MODE { COORD_UBLZ, COORD_STREAMING, COORD_LISTEN, COORD_LISTEN_FOREVER, COORD_RE_SCANCONVERT };
        enum CUT_DIRECTION { AZIRAD = 0, ELEAZI = 1, ELERAD = 2 }; // Encoding to match the RTL

        #region User variables
        private VirtualScopeNS.Components.CTCPclient tcpclient;

        private string host = "192.168.1.10";
        private int port = 7;
        private Double f0 = 4;                 // [MHz]
        private Double fs = 32;                // [MHz]
        private UInt32 c = 1540;               // [m/s]
        private Double theta = 73;             // [deg]
        private Double phi = 73;               // [deg]
        private Double r = 10;                 // [cm]
        private UInt32 N_elements_x = 32;
        private UInt32 N_elements_y = 32;
        private UInt32 BRAMCount = 512;
        private UInt32 clk_freq_mhz = 100;     // [MHz]
        private UInt32 samplesPerBRAM = 512;   // [samples]
        private UInt32 radialLines = 600;
        private UInt32 azimuthLines = 64;
        private UInt32 elevationLines = 64;
        private UInt32 RFDepth = 0;            // [samples]
        private Int32 ZeroOffset = 0;          // [samples]

        private FPGA_FSM FPGAState;
        private COORD_MODE CoordMode;

        private UInt32 scanConvertedImageWidth;
        private UInt32 scanConvertedImageHeight = 300;
        private string SCResString;
        private string HWSWSCString;

        private UInt32 returnedByteCounter;
        private UInt16 nappeIndex = 1;
        private UInt16 receivedNappeIndex = 1;
        private UInt16 nappeRequiringNewRFDataIndex = 0;
        private UInt16 runIndex = 0;
        private int zoneCount;
        private int compoundCount;
        private int runCount;
        private UInt16[] nappesRequiringNewRFData;

        byte[] VoxelBytes;
        byte[] Message = new byte[0];
        //byte[] lastpacket = new byte[0];
        //byte[] lastpacket_prev = new byte[0];
        //byte[] lastpacket_leftovers = new byte[0];

#if SAVE_NAPPES
        StreamWriter nappeFile;
#endif
        // Beamformed but not scan converted image from the FPGA or (for test only) from Matlab
        private string preSCImagePath;
        private VirtualScopeNS.Components.CPreScanConvertImage preSCImage;
        private VirtualScopeNS.Components.CPostScanConvertImage postSCImage;

        // Beamformed and scan-converted image to be displayed
        private Bitmap postSCImageXZ, postSCImageXY, postSCImageYZ;

        private string DataFolderPath;
        private string PhantomFolderPath;
        private string RunFolderPath;
        private string NappeFolderPath;
        private string SelectedPhantom = "";
        private string SelectedRunType;
        // Reference image (in four variants), beamformed and scan converted, from Matlab
        private string referenceExactDynamicImagePath;
        private string referenceSteeredDynamicImagePath;
        private string referenceExactStaticImagePath;
        private string referenceSteeredStaticImagePath;
        private Bitmap referenceImageXZ, referenceImageXY, referenceImageYZ;
        private CUT_DIRECTION selectedCutDirection;

        private VirtualScopeNS.Components.CProbe probe;
        private VirtualScopeNS.Components.CScanConverter scanConverter;
        bool TestMode = false;
        private Stopwatch stopWatch;
        private bool boardConnected;

        enum View { XZViewFirst, YZViewFirst, XYViewFirst };

        private View viewCounter = View.XZViewFirst;

        private Label[] panel1YLabels;
        private Label[] panel1XLabels;
        private Label[] panel2YLabels;
        private Label[] panel2XLabels;
        #endregion


        #region System variables
        // private System.ComponentModel.IContainer components;
        private System.Windows.Forms.Button connectButton;
        private System.Windows.Forms.Button button3;
        private PictureBox BeamformedImage;
        private Button CycleButton;
        private Label BeamformedImageLabel;
        private Panel panelReconstructed;
        private Label labelReconstructed;
        private Panel panelReference;
        private Label ReferenceImageLabel;
        private Label labelReference;
        private CheckBox FixedPointCheckBox;
        private CheckBox StaticApodizationCheckBox;
        private CheckBox DelayApproximationCheckBox;
        private Panel panelProgressBar;
        private Label label4;
        private Label FrameRateLabel;
        private Label labelReconstructedCm;
        private Label labelReferenceCm;
        private Label ProgressLabel;
        private Label label3;
        private ComboBox PhantomChooser;
        private ProgressBar progressBar;
        private Label label7;
        private Label label8;
        private ComboBox ZoneChooser;
        private Label label9;
        private ComboBox CompoundChooser;
        private Label label11;
        private ComboBox CompoundOp;
        private Button StartMicroblazeButton;
        private Button StartStreamingButton;
        private Button StartListenButton;
        private Button StartListenForeverButton;
        private NumericUpDown LogCompression;
        private Label label10;
        private Label label12;
        private Button ReScanConvertButton;
        private NumericUpDown Brightness;
        private NumericUpDown CutValue;
        private Label label13;
        private Panel panelScanConversion;
        private Panel panelSettings;
        private CheckBox HWSCCheckBox;
        private Panel panelZoneImaging;
        private Label label14;
        private Label label16;
        private Label label15;
        private Label scanConvertedImageWidthLabel;
        private Label label17;
        private NumericUpDown scanConvertedImageHeightNumericUpDown;
        private Label phantomLabel;
        private Panel panelProgress;
        private FlowLayoutPanel flowLayoutPanelImages;
        private FlowLayoutPanel flowLayoutPanelControls;
        private FlowLayoutPanel flowLayoutPanelOverall;
        private Panel panelStartButtons;
        private PictureBox ReferenceImage;
        #endregion


        public VirtualScope()
        {
            //
            // Required for Windows Form Designer support
            //
            InitializeComponent();

            this.WindowState = FormWindowState.Maximized;
            Screen myScreen = Screen.FromControl(this);
            // TODO these two margins are quite empirical and possibly fragile.
            Int32 widthMargin = 15;
            Int32 heightMargin = 50;
            this.flowLayoutPanelImages.MaximumSize = new Size(myScreen.WorkingArea.Width - widthMargin, (int)(0.7 * (myScreen.WorkingArea.Height - heightMargin)));
            this.flowLayoutPanelControls.MaximumSize = new Size(myScreen.WorkingArea.Width - widthMargin, (int)(0.3 * (myScreen.WorkingArea.Height - heightMargin)));

            CycleButton.Image = Image.FromStream(System.Reflection.Assembly.GetExecutingAssembly().GetManifestResourceStream("VirtualScopeNS.Resources.recycle.png")).GetThumbnailImage(80, 80, null, IntPtr.Zero);
            
            // Checks on disk which phantoms are available and puts them in a dropdown for choosing
            List<string> chooserEntries = new List<string>();

            DataFolderPath = System.Windows.Forms.Application.StartupPath;
            DataFolderPath = Path.Combine(new string[] {DataFolderPath, "..", "..", "..", "data"}); // TODO the ../.. is fragile
            
            if (Directory.Exists(DataFolderPath))
            {
                string[] folderEntries = Directory.GetDirectories(DataFolderPath);
                string fn;
                foreach (string folderName in folderEntries)
                {
                    if (DataFolderPath.StartsWith("/"))
                        fn = folderName.Substring(folderName.LastIndexOf('/') + 1);
                    else
                        fn = folderName.Substring(folderName.LastIndexOf('\\') + 1);
                    chooserEntries.Add(fn);
                }
            }
            this.PhantomChooser.Items.AddRange(chooserEntries.ToArray());

            // Only enable once we're connected to the FPGA
            StartMicroblazeButton.Enabled = false;
            StartStreamingButton.Enabled = false;
            StartListenButton.Enabled = false;
            StartListenForeverButton.Enabled = false;
            ReScanConvertButton.Enabled = false;

            ZoneChooser.Enabled = false;
            ZoneChooser.Items.Add("1");
            ZoneChooser.SelectedIndex = 0;
            CompoundChooser.Enabled = false;
            CompoundChooser.Items.Add("1");
            CompoundChooser.SelectedIndex = 0;
            CompoundOp.Items.Add("Average");
            CompoundOp.Items.Add("Average - Max");
            CompoundOp.Items.Add("Minimum");
            CompoundOp.Items.Add("MSD (experimental)");
            CompoundOp.Items.Add("ZREV (experimental)");
            CompoundOp.SelectedIndex = 0;
            LogCompression.Value = 45;   // In dB
            Brightness.Value = 0;        // In dB, 0 = auto brightness
            tcpclient = new VirtualScopeNS.Components.CTCPclient();
            tcpclient.StateChangedEvent += new VirtualScopeNS.Components.StateChangedEventHandler(tcpclient_StateChangedEvent);
            tcpclient.DataReceivedEvent += new VirtualScopeNS.Components.DataReceivedEventHandler(tcpclient_DataReceivedEvent);

            stopWatch = new Stopwatch();

            changeFPGAState(FPGA_FSM.FPGA_DISCONNECTED);
            changeCoordMode(COORD_MODE.COORD_UBLZ);

            HWSCCheckBox.Checked = true;
            HWSWSCString = "HWSC ";

            VirtualScopeNS.Components.CConfig Config = new VirtualScopeNS.Components.CConfig();
            if (Config.Read())
            {
                host = Config.Host;
                port = Config.Port;
                clk_freq_mhz = Config.ClkFrequencyMHz;
            }

            CutValue.Value = Math.Max(0, Math.Round((decimal)(elevationLines / 2), 0, MidpointRounding.AwayFromZero));
            CutValue.Maximum = elevationLines - 1;
            selectedCutDirection = CUT_DIRECTION.AZIRAD;

            scanConvertedImageHeightNumericUpDown.Value = scanConvertedImageHeight;
            // TODO neither the width nor the height should not go beyond three digits; for now put a hard limit on height to 700

            BeamformedImage.SizeMode = PictureBoxSizeMode.Zoom;
            ReferenceImage.SizeMode = PictureBoxSizeMode.Zoom;

            BeamformedImage.BackColor = Color.Gray;
            ReferenceImage.BackColor = Color.Gray;

            boardConnected = false;
            connectButton.Text = "Connect";

            // Axis labels
            // Calibrate the tick count so that we have ~1 per cm along the Z axis of the image
            // (nice round number if r is integer, else with decimals)
            UInt16 tickCount = Convert.ToUInt16(Math.Floor(r));

            panel1YLabels = new Label[tickCount + 1];
            panel1XLabels = new Label[tickCount + 1];
            panel2YLabels = new Label[tickCount + 1];
            panel2XLabels = new Label[tickCount + 1];
            for (UInt16 i = 0; i <= tickCount; i++)
            {
                panel1YLabels[i] = new Label{ AutoSize = false, TextAlign = ContentAlignment.MiddleRight, Width = 40 };
                panelReconstructed.Controls.Add(panel1YLabels[i]);

                panel1XLabels[i] = new Label { AutoSize = false, TextAlign = ContentAlignment.MiddleCenter, Width = 40 };
                panelReconstructed.Controls.Add(panel1XLabels[i]);

                panel2YLabels[i] = new Label { AutoSize = false, TextAlign = ContentAlignment.MiddleRight, Width = 40 };
                panelReference.Controls.Add(panel2YLabels[i]);

                panel2XLabels[i] = new Label { AutoSize = false, TextAlign = ContentAlignment.MiddleCenter, Width = 40 };
                panelReference.Controls.Add(panel2XLabels[i]);
            }

            refreshUI();
        }

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                //if (components != null)
                //{
                //    components.Dispose();
                //}
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code
        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(VirtualScope));
            this.button3 = new System.Windows.Forms.Button();
            this.connectButton = new System.Windows.Forms.Button();
            this.BeamformedImage = new System.Windows.Forms.PictureBox();
            this.ReferenceImage = new System.Windows.Forms.PictureBox();
            this.CycleButton = new System.Windows.Forms.Button();
            this.BeamformedImageLabel = new System.Windows.Forms.Label();
            this.panelReconstructed = new System.Windows.Forms.Panel();
            this.labelReconstructedCm = new System.Windows.Forms.Label();
            this.labelReconstructed = new System.Windows.Forms.Label();
            this.panelReference = new System.Windows.Forms.Panel();
            this.labelReferenceCm = new System.Windows.Forms.Label();
            this.StaticApodizationCheckBox = new System.Windows.Forms.CheckBox();
            this.DelayApproximationCheckBox = new System.Windows.Forms.CheckBox();
            this.FixedPointCheckBox = new System.Windows.Forms.CheckBox();
            this.ReferenceImageLabel = new System.Windows.Forms.Label();
            this.labelReference = new System.Windows.Forms.Label();
            this.panelProgressBar = new System.Windows.Forms.Panel();
            this.progressBar = new System.Windows.Forms.ProgressBar();
            this.label4 = new System.Windows.Forms.Label();
            this.FrameRateLabel = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.ProgressLabel = new System.Windows.Forms.Label();
            this.PhantomChooser = new System.Windows.Forms.ComboBox();
            this.label7 = new System.Windows.Forms.Label();
            this.label8 = new System.Windows.Forms.Label();
            this.ZoneChooser = new System.Windows.Forms.ComboBox();
            this.label9 = new System.Windows.Forms.Label();
            this.CompoundChooser = new System.Windows.Forms.ComboBox();
            this.label11 = new System.Windows.Forms.Label();
            this.CompoundOp = new System.Windows.Forms.ComboBox();
            this.StartMicroblazeButton = new System.Windows.Forms.Button();
            this.StartStreamingButton = new System.Windows.Forms.Button();
            this.StartListenButton = new System.Windows.Forms.Button();
            this.StartListenForeverButton = new System.Windows.Forms.Button();
            this.LogCompression = new System.Windows.Forms.NumericUpDown();
            this.label10 = new System.Windows.Forms.Label();
            this.label12 = new System.Windows.Forms.Label();
            this.ReScanConvertButton = new System.Windows.Forms.Button();
            this.Brightness = new System.Windows.Forms.NumericUpDown();
            this.CutValue = new System.Windows.Forms.NumericUpDown();
            this.label13 = new System.Windows.Forms.Label();
            this.panelScanConversion = new System.Windows.Forms.Panel();
            this.scanConvertedImageWidthLabel = new System.Windows.Forms.Label();
            this.label17 = new System.Windows.Forms.Label();
            this.scanConvertedImageHeightNumericUpDown = new System.Windows.Forms.NumericUpDown();
            this.label16 = new System.Windows.Forms.Label();
            this.HWSCCheckBox = new System.Windows.Forms.CheckBox();
            this.panelSettings = new System.Windows.Forms.Panel();
            this.phantomLabel = new System.Windows.Forms.Label();
            this.label14 = new System.Windows.Forms.Label();
            this.panelZoneImaging = new System.Windows.Forms.Panel();
            this.label15 = new System.Windows.Forms.Label();
            this.panelProgress = new System.Windows.Forms.Panel();
            this.flowLayoutPanelImages = new System.Windows.Forms.FlowLayoutPanel();
            this.flowLayoutPanelControls = new System.Windows.Forms.FlowLayoutPanel();
            this.panelStartButtons = new System.Windows.Forms.Panel();
            this.flowLayoutPanelOverall = new System.Windows.Forms.FlowLayoutPanel();
            ((System.ComponentModel.ISupportInitialize)(this.BeamformedImage)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.ReferenceImage)).BeginInit();
            this.panelReconstructed.SuspendLayout();
            this.panelReference.SuspendLayout();
            this.panelProgressBar.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.LogCompression)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.Brightness)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.CutValue)).BeginInit();
            this.panelScanConversion.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.scanConvertedImageHeightNumericUpDown)).BeginInit();
            this.panelSettings.SuspendLayout();
            this.panelZoneImaging.SuspendLayout();
            this.panelProgress.SuspendLayout();
            this.flowLayoutPanelImages.SuspendLayout();
            this.flowLayoutPanelControls.SuspendLayout();
            this.panelStartButtons.SuspendLayout();
            this.flowLayoutPanelOverall.SuspendLayout();
            this.SuspendLayout();
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(6, 19);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(227, 48);
            this.button3.TabIndex = 2;
            this.button3.Text = "Setup";
            this.button3.Click += new System.EventHandler(this.setupButtonClick);
            // 
            // connectButton
            // 
            this.connectButton.Location = new System.Drawing.Point(6, 172);
            this.connectButton.Name = "connectButton";
            this.connectButton.Size = new System.Drawing.Size(227, 39);
            this.connectButton.TabIndex = 0;
            this.connectButton.Text = "Connect";
            this.connectButton.Click += new System.EventHandler(this.connectButton_Click);
            // 
            // BeamformedImage
            // 
            this.BeamformedImage.Location = new System.Drawing.Point(62, 31);
            this.BeamformedImage.Name = "BeamformedImage";
            this.BeamformedImage.Size = new System.Drawing.Size(357, 300);
            this.BeamformedImage.TabIndex = 6;
            this.BeamformedImage.TabStop = false;
            // 
            // ReferenceImage
            // 
            this.ReferenceImage.Location = new System.Drawing.Point(47, 31);
            this.ReferenceImage.Name = "ReferenceImage";
            this.ReferenceImage.Size = new System.Drawing.Size(357, 300);
            this.ReferenceImage.TabIndex = 42;
            this.ReferenceImage.TabStop = false;
            // 
            // CycleButton
            // 
            this.CycleButton.Location = new System.Drawing.Point(273, 80);
            this.CycleButton.Name = "CycleButton";
            this.CycleButton.Size = new System.Drawing.Size(80, 80);
            this.CycleButton.TabIndex = 46;
            this.CycleButton.UseVisualStyleBackColor = true;
            this.CycleButton.Click += new System.EventHandler(this.CycleButton_Click);
            // 
            // BeamformedImageLabel
            // 
            this.BeamformedImageLabel.AutoSize = true;
            this.BeamformedImageLabel.Location = new System.Drawing.Point(59, 11);
            this.BeamformedImageLabel.Name = "BeamformedImageLabel";
            this.BeamformedImageLabel.Size = new System.Drawing.Size(66, 17);
            this.BeamformedImageLabel.TabIndex = 49;
            this.BeamformedImageLabel.Text = "XZ Plane";
            // 
            // panelReconstructed
            // 
            this.panelReconstructed.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.panelReconstructed.Controls.Add(this.labelReconstructedCm);
            this.panelReconstructed.Controls.Add(this.BeamformedImageLabel);
            this.panelReconstructed.Controls.Add(this.labelReconstructed);
            this.panelReconstructed.Controls.Add(this.BeamformedImage);
            this.panelReconstructed.Location = new System.Drawing.Point(3, 3);
            this.panelReconstructed.Name = "panelReconstructed";
            this.panelReconstructed.Size = new System.Drawing.Size(843, 509);
            this.panelReconstructed.TabIndex = 50;
            this.panelReconstructed.Paint += new System.Windows.Forms.PaintEventHandler(this.panel1_Paint);
            // 
            // labelReconstructedCm
            // 
            this.labelReconstructedCm.AutoSize = true;
            this.labelReconstructedCm.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.labelReconstructedCm.Location = new System.Drawing.Point(17, 365);
            this.labelReconstructedCm.Name = "labelReconstructedCm";
            this.labelReconstructedCm.Size = new System.Drawing.Size(34, 17);
            this.labelReconstructedCm.TabIndex = 51;
            this.labelReconstructedCm.Text = "[cm]";
            // 
            // labelReconstructed
            // 
            this.labelReconstructed.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelReconstructed.Location = new System.Drawing.Point(324, 4);
            this.labelReconstructed.Name = "labelReconstructed";
            this.labelReconstructed.Size = new System.Drawing.Size(188, 23);
            this.labelReconstructed.TabIndex = 41;
            this.labelReconstructed.Text = "Reconstructed Image";
            // 
            // panelReference
            // 
            this.panelReference.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.panelReference.Controls.Add(this.labelReferenceCm);
            this.panelReference.Controls.Add(this.StaticApodizationCheckBox);
            this.panelReference.Controls.Add(this.DelayApproximationCheckBox);
            this.panelReference.Controls.Add(this.FixedPointCheckBox);
            this.panelReference.Controls.Add(this.ReferenceImageLabel);
            this.panelReference.Controls.Add(this.labelReference);
            this.panelReference.Controls.Add(this.ReferenceImage);
            this.panelReference.Location = new System.Drawing.Point(852, 3);
            this.panelReference.Name = "panelReference";
            this.panelReference.Size = new System.Drawing.Size(822, 509);
            this.panelReference.TabIndex = 51;
            this.panelReference.Paint += new System.Windows.Forms.PaintEventHandler(this.panel2_Paint);
            // 
            // labelReferenceCm
            // 
            this.labelReferenceCm.AutoSize = true;
            this.labelReferenceCm.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.labelReferenceCm.Location = new System.Drawing.Point(3, 365);
            this.labelReferenceCm.Name = "labelReferenceCm";
            this.labelReferenceCm.Size = new System.Drawing.Size(34, 17);
            this.labelReferenceCm.TabIndex = 52;
            this.labelReferenceCm.Text = "[cm]";
            // 
            // StaticApodizationCheckBox
            // 
            this.StaticApodizationCheckBox.AutoSize = true;
            this.StaticApodizationCheckBox.Checked = true;
            this.StaticApodizationCheckBox.CheckState = System.Windows.Forms.CheckState.Checked;
            this.StaticApodizationCheckBox.Enabled = false;
            this.StaticApodizationCheckBox.Location = new System.Drawing.Point(545, 412);
            this.StaticApodizationCheckBox.Name = "StaticApodizationCheckBox";
            this.StaticApodizationCheckBox.Size = new System.Drawing.Size(143, 21);
            this.StaticApodizationCheckBox.TabIndex = 56;
            this.StaticApodizationCheckBox.Text = "Static Apodization";
            this.StaticApodizationCheckBox.UseVisualStyleBackColor = true;
            this.StaticApodizationCheckBox.CheckedChanged += new System.EventHandler(this.ApodizationCheckBox_CheckedChanged);
            // 
            // DelayApproximationCheckBox
            // 
            this.DelayApproximationCheckBox.AutoSize = true;
            this.DelayApproximationCheckBox.Checked = true;
            this.DelayApproximationCheckBox.CheckState = System.Windows.Forms.CheckState.Checked;
            this.DelayApproximationCheckBox.Enabled = false;
            this.DelayApproximationCheckBox.Location = new System.Drawing.Point(319, 412);
            this.DelayApproximationCheckBox.Name = "DelayApproximationCheckBox";
            this.DelayApproximationCheckBox.Size = new System.Drawing.Size(159, 21);
            this.DelayApproximationCheckBox.TabIndex = 55;
            this.DelayApproximationCheckBox.Text = "Delay Approximation";
            this.DelayApproximationCheckBox.UseVisualStyleBackColor = true;
            this.DelayApproximationCheckBox.CheckedChanged += new System.EventHandler(this.DelayApproximationCheckBox_CheckedChanged);
            // 
            // FixedPointCheckBox
            // 
            this.FixedPointCheckBox.AutoSize = true;
            this.FixedPointCheckBox.Enabled = false;
            this.FixedPointCheckBox.Location = new System.Drawing.Point(97, 412);
            this.FixedPointCheckBox.Name = "FixedPointCheckBox";
            this.FixedPointCheckBox.Size = new System.Drawing.Size(162, 21);
            this.FixedPointCheckBox.TabIndex = 54;
            this.FixedPointCheckBox.Text = "Fixed-Point Precision";
            this.FixedPointCheckBox.UseVisualStyleBackColor = true;
            this.FixedPointCheckBox.CheckedChanged += new System.EventHandler(this.FixedPointCheckBox_CheckedChanged);
            // 
            // ReferenceImageLabel
            // 
            this.ReferenceImageLabel.AutoSize = true;
            this.ReferenceImageLabel.Location = new System.Drawing.Point(44, 11);
            this.ReferenceImageLabel.Name = "ReferenceImageLabel";
            this.ReferenceImageLabel.Size = new System.Drawing.Size(66, 17);
            this.ReferenceImageLabel.TabIndex = 53;
            this.ReferenceImageLabel.Text = "XZ Plane";
            // 
            // labelReference
            // 
            this.labelReference.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelReference.Location = new System.Drawing.Point(320, 4);
            this.labelReference.Name = "labelReference";
            this.labelReference.Size = new System.Drawing.Size(166, 23);
            this.labelReference.TabIndex = 52;
            this.labelReference.Text = "Reference Image";
            // 
            // panelProgressBar
            // 
            this.panelProgressBar.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.panelProgressBar.Controls.Add(this.label4);
            this.panelProgressBar.Controls.Add(this.FrameRateLabel);
            this.panelProgressBar.Controls.Add(this.label3);
            this.panelProgressBar.Location = new System.Drawing.Point(7, 3);
            this.panelProgressBar.Name = "panelProgressBar";
            this.panelProgressBar.Size = new System.Drawing.Size(598, 55);
            this.panelProgressBar.TabIndex = 52;
            // 
            // progressBar
            // 
            this.progressBar.Location = new System.Drawing.Point(7, 3);
            this.progressBar.Name = "progressBar";
            this.progressBar.Size = new System.Drawing.Size(598, 55);
            this.progressBar.Style = System.Windows.Forms.ProgressBarStyle.Continuous;
            this.progressBar.TabIndex = 57;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(437, 19);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(35, 20);
            this.label4.TabIndex = 59;
            this.label4.Text = "fps";
            // 
            // FrameRateLabel
            // 
            this.FrameRateLabel.AutoSize = true;
            this.FrameRateLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 10.2F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.FrameRateLabel.Location = new System.Drawing.Point(375, 19);
            this.FrameRateLabel.Name = "FrameRateLabel";
            this.FrameRateLabel.Size = new System.Drawing.Size(40, 20);
            this.FrameRateLabel.TabIndex = 58;
            this.FrameRateLabel.Text = "N/A";
            // 
            // label3
            // 
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(78, 18);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(306, 23);
            this.label3.TabIndex = 57;
            this.label3.Text = "FPGA Frame Rate (Theoretical):";
            // 
            // ProgressLabel
            // 
            this.ProgressLabel.AutoSize = true;
            this.ProgressLabel.Location = new System.Drawing.Point(623, 23);
            this.ProgressLabel.Name = "ProgressLabel";
            this.ProgressLabel.Size = new System.Drawing.Size(0, 17);
            this.ProgressLabel.TabIndex = 54;
            // 
            // PhantomChooser
            // 
            this.PhantomChooser.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.PhantomChooser.FormattingEnabled = true;
            this.PhantomChooser.Location = new System.Drawing.Point(6, 86);
            this.PhantomChooser.Name = "PhantomChooser";
            this.PhantomChooser.Size = new System.Drawing.Size(227, 24);
            this.PhantomChooser.TabIndex = 55;
            this.PhantomChooser.SelectedValueChanged += new System.EventHandler(this.PhantomChooser_SelectedValueChanged);
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(3, 66);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(64, 17);
            this.label7.TabIndex = 56;
            this.label7.Text = "Phantom";
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(3, 39);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(82, 17);
            this.label8.TabIndex = 57;
            this.label8.Text = "Zone Count";
            // 
            // ZoneChooser
            // 
            this.ZoneChooser.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.ZoneChooser.FormattingEnabled = true;
            this.ZoneChooser.Location = new System.Drawing.Point(6, 59);
            this.ZoneChooser.Name = "ZoneChooser";
            this.ZoneChooser.Size = new System.Drawing.Size(188, 24);
            this.ZoneChooser.TabIndex = 58;
            this.ZoneChooser.SelectedValueChanged += new System.EventHandler(this.ZoneChooser_SelectedValueChanged);
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(3, 102);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(136, 17);
            this.label9.TabIndex = 61;
            this.label9.Text = "Compounding Count";
            // 
            // CompoundChooser
            // 
            this.CompoundChooser.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.CompoundChooser.FormattingEnabled = true;
            this.CompoundChooser.Location = new System.Drawing.Point(6, 122);
            this.CompoundChooser.Name = "CompoundChooser";
            this.CompoundChooser.Size = new System.Drawing.Size(188, 24);
            this.CompoundChooser.TabIndex = 62;
            this.CompoundChooser.SelectedValueChanged += new System.EventHandler(this.CompoundChooser_SelectedValueChanged);
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Location = new System.Drawing.Point(3, 165);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(156, 17);
            this.label11.TabIndex = 63;
            this.label11.Text = "Compounding Operator";
            // 
            // CompoundOp
            // 
            this.CompoundOp.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.CompoundOp.FormattingEnabled = true;
            this.CompoundOp.Location = new System.Drawing.Point(6, 185);
            this.CompoundOp.Name = "CompoundOp";
            this.CompoundOp.Size = new System.Drawing.Size(188, 24);
            this.CompoundOp.TabIndex = 64;
            // 
            // StartMicroblazeButton
            // 
            this.StartMicroblazeButton.Location = new System.Drawing.Point(9, 5);
            this.StartMicroblazeButton.Name = "StartMicroblazeButton";
            this.StartMicroblazeButton.Size = new System.Drawing.Size(162, 46);
            this.StartMicroblazeButton.TabIndex = 65;
            this.StartMicroblazeButton.Text = "Start (UB)";
            this.StartMicroblazeButton.Click += new System.EventHandler(this.StartMicroblazeButton_Click);
            // 
            // StartStreamingButton
            // 
            this.StartStreamingButton.Location = new System.Drawing.Point(9, 58);
            this.StartStreamingButton.Name = "StartStreamingButton";
            this.StartStreamingButton.Size = new System.Drawing.Size(162, 46);
            this.StartStreamingButton.TabIndex = 66;
            this.StartStreamingButton.Text = "Start (Streaming)";
            this.StartStreamingButton.Click += new System.EventHandler(this.StartStreamingButton_Click);
            // 
            // StartListenButton
            // 
            this.StartListenButton.Location = new System.Drawing.Point(9, 111);
            this.StartListenButton.Name = "StartListenButton";
            this.StartListenButton.Size = new System.Drawing.Size(162, 46);
            this.StartListenButton.TabIndex = 67;
            this.StartListenButton.Text = "Start (Listen)";
            this.StartListenButton.Click += new System.EventHandler(this.StartListenButton_Click);
            // 
            // StartListenForeverButton
            // 
            this.StartListenForeverButton.Location = new System.Drawing.Point(9, 164);
            this.StartListenForeverButton.Name = "StartListenForeverButton";
            this.StartListenForeverButton.Size = new System.Drawing.Size(162, 46);
            this.StartListenForeverButton.TabIndex = 68;
            this.StartListenForeverButton.Text = "Start (Listen Forever)";
            this.StartListenForeverButton.Click += new System.EventHandler(this.StartListenForeverButton_Click);
            // 
            // LogCompression
            // 
            this.LogCompression.Increment = new decimal(new int[] {
            5,
            0,
            0,
            0});
            this.LogCompression.Location = new System.Drawing.Point(12, 46);
            this.LogCompression.Minimum = new decimal(new int[] {
            5,
            0,
            0,
            0});
            this.LogCompression.Name = "LogCompression";
            this.LogCompression.Size = new System.Drawing.Size(120, 22);
            this.LogCompression.TabIndex = 70;
            this.LogCompression.Value = new decimal(new int[] {
            45,
            0,
            0,
            0});
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Location = new System.Drawing.Point(9, 25);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(92, 17);
            this.label10.TabIndex = 71;
            this.label10.Text = "Contrast (dB)";
            // 
            // label12
            // 
            this.label12.AutoSize = true;
            this.label12.Location = new System.Drawing.Point(9, 72);
            this.label12.Name = "label12";
            this.label12.Size = new System.Drawing.Size(106, 17);
            this.label12.TabIndex = 72;
            this.label12.Text = "Brightness (dB)";
            // 
            // ReScanConvertButton
            // 
            this.ReScanConvertButton.Location = new System.Drawing.Point(12, 168);
            this.ReScanConvertButton.Name = "ReScanConvertButton";
            this.ReScanConvertButton.Size = new System.Drawing.Size(341, 43);
            this.ReScanConvertButton.TabIndex = 73;
            this.ReScanConvertButton.Text = "Re-SC";
            this.ReScanConvertButton.UseVisualStyleBackColor = true;
            this.ReScanConvertButton.Click += new System.EventHandler(this.ReScanConvertButton_Click);
            // 
            // Brightness
            // 
            this.Brightness.Location = new System.Drawing.Point(12, 93);
            this.Brightness.Maximum = new decimal(new int[] {
            192,
            0,
            0,
            0});
            this.Brightness.Name = "Brightness";
            this.Brightness.Size = new System.Drawing.Size(120, 22);
            this.Brightness.TabIndex = 74;
            // 
            // CutValue
            // 
            this.CutValue.Location = new System.Drawing.Point(12, 138);
            this.CutValue.Name = "CutValue";
            this.CutValue.Size = new System.Drawing.Size(120, 22);
            this.CutValue.TabIndex = 76;
            // 
            // label13
            // 
            this.label13.AutoSize = true;
            this.label13.Location = new System.Drawing.Point(9, 117);
            this.label13.Name = "label13";
            this.label13.Size = new System.Drawing.Size(69, 17);
            this.label13.TabIndex = 75;
            this.label13.Text = "Cut Value";
            // 
            // panelScanConversion
            // 
            this.panelScanConversion.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.panelScanConversion.Controls.Add(this.scanConvertedImageWidthLabel);
            this.panelScanConversion.Controls.Add(this.label17);
            this.panelScanConversion.Controls.Add(this.scanConvertedImageHeightNumericUpDown);
            this.panelScanConversion.Controls.Add(this.label16);
            this.panelScanConversion.Controls.Add(this.HWSCCheckBox);
            this.panelScanConversion.Controls.Add(this.ReScanConvertButton);
            this.panelScanConversion.Controls.Add(this.CutValue);
            this.panelScanConversion.Controls.Add(this.label10);
            this.panelScanConversion.Controls.Add(this.CycleButton);
            this.panelScanConversion.Controls.Add(this.label13);
            this.panelScanConversion.Controls.Add(this.LogCompression);
            this.panelScanConversion.Controls.Add(this.Brightness);
            this.panelScanConversion.Controls.Add(this.label12);
            this.panelScanConversion.Location = new System.Drawing.Point(465, 3);
            this.panelScanConversion.Name = "panelScanConversion";
            this.panelScanConversion.Size = new System.Drawing.Size(368, 221);
            this.panelScanConversion.TabIndex = 77;
            // 
            // scanConvertedImageWidthLabel
            // 
            this.scanConvertedImageWidthLabel.AutoSize = true;
            this.scanConvertedImageWidthLabel.Location = new System.Drawing.Point(270, 48);
            this.scanConvertedImageWidthLabel.Name = "scanConvertedImageWidthLabel";
            this.scanConvertedImageWidthLabel.Size = new System.Drawing.Size(86, 17);
            this.scanConvertedImageWidthLabel.TabIndex = 80;
            this.scanConvertedImageWidthLabel.Text = "(Width: 300)";
            // 
            // label17
            // 
            this.label17.AutoSize = true;
            this.label17.Location = new System.Drawing.Point(145, 25);
            this.label17.Name = "label17";
            this.label17.Size = new System.Drawing.Size(98, 17);
            this.label17.TabIndex = 79;
            this.label17.Text = "Height (pixels)";
            // 
            // scanConvertedImageHeightNumericUpDown
            // 
            this.scanConvertedImageHeightNumericUpDown.Location = new System.Drawing.Point(148, 45);
            this.scanConvertedImageHeightNumericUpDown.Maximum = new decimal(new int[] {
            700,
            0,
            0,
            0});
            this.scanConvertedImageHeightNumericUpDown.Name = "scanConvertedImageHeightNumericUpDown";
            this.scanConvertedImageHeightNumericUpDown.Size = new System.Drawing.Size(120, 22);
            this.scanConvertedImageHeightNumericUpDown.TabIndex = 78;
            this.scanConvertedImageHeightNumericUpDown.Value = new decimal(new int[] {
            300,
            0,
            0,
            0});
            this.scanConvertedImageHeightNumericUpDown.ValueChanged += new System.EventHandler(this.scanConvertedImageHeightNumericUpDown_ValueChanged);
            // 
            // label16
            // 
            this.label16.AutoSize = true;
            this.label16.Location = new System.Drawing.Point(3, 1);
            this.label16.Name = "label16";
            this.label16.Size = new System.Drawing.Size(170, 17);
            this.label16.TabIndex = 67;
            this.label16.Text = "Scan Conversion Settings";
            // 
            // HWSCCheckBox
            // 
            this.HWSCCheckBox.AutoSize = true;
            this.HWSCCheckBox.Checked = true;
            this.HWSCCheckBox.CheckState = System.Windows.Forms.CheckState.Checked;
            this.HWSCCheckBox.Location = new System.Drawing.Point(148, 94);
            this.HWSCCheckBox.Name = "HWSCCheckBox";
            this.HWSCCheckBox.Size = new System.Drawing.Size(113, 21);
            this.HWSCCheckBox.TabIndex = 77;
            this.HWSCCheckBox.Text = "Show HW SC";
            this.HWSCCheckBox.UseVisualStyleBackColor = true;
            this.HWSCCheckBox.CheckedChanged += new System.EventHandler(this.HWSCCheckBox_CheckedChanged);
            // 
            // panelSettings
            // 
            this.panelSettings.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.panelSettings.Controls.Add(this.phantomLabel);
            this.panelSettings.Controls.Add(this.label14);
            this.panelSettings.Controls.Add(this.button3);
            this.panelSettings.Controls.Add(this.label7);
            this.panelSettings.Controls.Add(this.PhantomChooser);
            this.panelSettings.Controls.Add(this.connectButton);
            this.panelSettings.Location = new System.Drawing.Point(3, 3);
            this.panelSettings.Name = "panelSettings";
            this.panelSettings.Size = new System.Drawing.Size(242, 221);
            this.panelSettings.TabIndex = 78;
            // 
            // phantomLabel
            // 
            this.phantomLabel.AutoSize = true;
            this.phantomLabel.Location = new System.Drawing.Point(3, 112);
            this.phantomLabel.Name = "phantomLabel";
            this.phantomLabel.Size = new System.Drawing.Size(167, 17);
            this.phantomLabel.TabIndex = 66;
            this.phantomLabel.Text = "Please select a phantom.";
            // 
            // label14
            // 
            this.label14.AutoSize = true;
            this.label14.Location = new System.Drawing.Point(3, 1);
            this.label14.Name = "label14";
            this.label14.Size = new System.Drawing.Size(93, 17);
            this.label14.TabIndex = 65;
            this.label14.Text = "Main Settings";
            // 
            // panelZoneImaging
            // 
            this.panelZoneImaging.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.panelZoneImaging.Controls.Add(this.label15);
            this.panelZoneImaging.Controls.Add(this.ZoneChooser);
            this.panelZoneImaging.Controls.Add(this.label8);
            this.panelZoneImaging.Controls.Add(this.label11);
            this.panelZoneImaging.Controls.Add(this.CompoundOp);
            this.panelZoneImaging.Controls.Add(this.label9);
            this.panelZoneImaging.Controls.Add(this.CompoundChooser);
            this.panelZoneImaging.Location = new System.Drawing.Point(251, 3);
            this.panelZoneImaging.Name = "panelZoneImaging";
            this.panelZoneImaging.Size = new System.Drawing.Size(208, 221);
            this.panelZoneImaging.TabIndex = 79;
            // 
            // label15
            // 
            this.label15.AutoSize = true;
            this.label15.Location = new System.Drawing.Point(3, 1);
            this.label15.Name = "label15";
            this.label15.Size = new System.Drawing.Size(149, 17);
            this.label15.TabIndex = 66;
            this.label15.Text = "Zone Imaging Settings";
            // 
            // panelProgress
            // 
            this.panelProgress.Controls.Add(this.progressBar);
            this.panelProgress.Controls.Add(this.panelProgressBar);
            this.panelProgress.Controls.Add(this.ProgressLabel);
            this.panelProgress.Location = new System.Drawing.Point(3, 521);
            this.panelProgress.Margin = new System.Windows.Forms.Padding(3, 0, 3, 0);
            this.panelProgress.Name = "panelProgress";
            this.panelProgress.Size = new System.Drawing.Size(1024, 61);
            this.panelProgress.TabIndex = 80;
            // 
            // flowLayoutPanelImages
            // 
            this.flowLayoutPanelImages.AutoSize = true;
            this.flowLayoutPanelImages.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.flowLayoutPanelImages.Controls.Add(this.panelReconstructed);
            this.flowLayoutPanelImages.Controls.Add(this.panelReference);
            this.flowLayoutPanelImages.Location = new System.Drawing.Point(3, 3);
            this.flowLayoutPanelImages.Name = "flowLayoutPanelImages";
            this.flowLayoutPanelImages.Size = new System.Drawing.Size(1677, 515);
            this.flowLayoutPanelImages.TabIndex = 69;
            // 
            // flowLayoutPanelControls
            // 
            this.flowLayoutPanelControls.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.flowLayoutPanelControls.AutoSize = true;
            this.flowLayoutPanelControls.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.flowLayoutPanelControls.Controls.Add(this.panelSettings);
            this.flowLayoutPanelControls.Controls.Add(this.panelZoneImaging);
            this.flowLayoutPanelControls.Controls.Add(this.panelScanConversion);
            this.flowLayoutPanelControls.Controls.Add(this.panelStartButtons);
            this.flowLayoutPanelControls.Location = new System.Drawing.Point(3, 585);
            this.flowLayoutPanelControls.Name = "flowLayoutPanelControls";
            this.flowLayoutPanelControls.Size = new System.Drawing.Size(1024, 227);
            this.flowLayoutPanelControls.TabIndex = 81;
            // 
            // panelStartButtons
            // 
            this.panelStartButtons.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D;
            this.panelStartButtons.Controls.Add(this.StartListenButton);
            this.panelStartButtons.Controls.Add(this.StartStreamingButton);
            this.panelStartButtons.Controls.Add(this.StartMicroblazeButton);
            this.panelStartButtons.Controls.Add(this.StartListenForeverButton);
            this.panelStartButtons.Location = new System.Drawing.Point(839, 3);
            this.panelStartButtons.Name = "panelStartButtons";
            this.panelStartButtons.Size = new System.Drawing.Size(182, 220);
            this.panelStartButtons.TabIndex = 180;
            // 
            // flowLayoutPanelOverall
            // 
            this.flowLayoutPanelOverall.Controls.Add(this.flowLayoutPanelImages);
            this.flowLayoutPanelOverall.Controls.Add(this.panelProgress);
            this.flowLayoutPanelOverall.Controls.Add(this.flowLayoutPanelControls);
            this.flowLayoutPanelOverall.Dock = System.Windows.Forms.DockStyle.Fill;
            this.flowLayoutPanelOverall.FlowDirection = System.Windows.Forms.FlowDirection.TopDown;
            this.flowLayoutPanelOverall.Location = new System.Drawing.Point(0, 0);
            this.flowLayoutPanelOverall.Name = "flowLayoutPanelOverall";
            this.flowLayoutPanelOverall.Size = new System.Drawing.Size(1690, 1055);
            this.flowLayoutPanelOverall.TabIndex = 82;
            // 
            // VirtualScope
            // 
            this.AutoScaleBaseSize = new System.Drawing.Size(6, 15);
            this.AutoScroll = true;
            this.ClientSize = new System.Drawing.Size(1690, 1055);
            this.Controls.Add(this.flowLayoutPanelOverall);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "VirtualScope";
            this.Text = "Virtual Scope";
            this.Closing += new System.ComponentModel.CancelEventHandler(this.VirtualScope_Closing);
            ((System.ComponentModel.ISupportInitialize)(this.BeamformedImage)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.ReferenceImage)).EndInit();
            this.panelReconstructed.ResumeLayout(false);
            this.panelReconstructed.PerformLayout();
            this.panelReference.ResumeLayout(false);
            this.panelReference.PerformLayout();
            this.panelProgressBar.ResumeLayout(false);
            this.panelProgressBar.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.LogCompression)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.Brightness)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.CutValue)).EndInit();
            this.panelScanConversion.ResumeLayout(false);
            this.panelScanConversion.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.scanConvertedImageHeightNumericUpDown)).EndInit();
            this.panelSettings.ResumeLayout(false);
            this.panelSettings.PerformLayout();
            this.panelZoneImaging.ResumeLayout(false);
            this.panelZoneImaging.PerformLayout();
            this.panelProgress.ResumeLayout(false);
            this.panelProgress.PerformLayout();
            this.flowLayoutPanelImages.ResumeLayout(false);
            this.flowLayoutPanelControls.ResumeLayout(false);
            this.panelStartButtons.ResumeLayout(false);
            this.flowLayoutPanelOverall.ResumeLayout(false);
            this.flowLayoutPanelOverall.PerformLayout();
            this.ResumeLayout(false);

        }
        #endregion

        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.Run(new VirtualScope());
        }

        private void drawGraph1_Paint(object sender, System.Windows.Forms.PaintEventArgs e)
        {
            //			graph[(int)selectChannel1.Value - 1].Draw(e.Graphics);
            //			lmax1.Text = graph[(int)selectChannel1.Value - 1].MaxL;
            //			lmin1.Text = graph[(int)selectChannel1.Value - 1].MinL;
        }

        private void tcpclient_StateChangedEvent(object source, bool connected)
        {
            if (connected)
            {
                // Use this "trick", instead of just setting control properties,
                // so that the update happens on the UI thread, not on the network thread.
                this.Invoke((MethodInvoker) delegate
                {
                    boardConnected = true;
                    connectButton.Text = "Disconnect";
                    if (PhantomChooser.SelectedIndex != -1)
                    {
                        StartMicroblazeButton.Enabled = true;
                        StartStreamingButton.Enabled = true;
                    }
                    StartListenButton.Enabled = true;
                    StartListenForeverButton.Enabled = true;
                    // Disabled because we need to run a full reconstruction first
                    ReScanConvertButton.Enabled = false;
                });

                changeFPGAState(FPGA_FSM.FPGA_CONNECTED);
            }
            else
            {
                // Use this "trick", instead of just setting control properties,
                // so that the update happens on the UI thread, not on the network thread.
                this.Invoke((MethodInvoker)delegate
                {
                    boardConnected = false;
                    connectButton.Text = "Connect";
                    StartMicroblazeButton.Enabled = false;
                    StartStreamingButton.Enabled = false;
                    StartListenButton.Enabled = false;
                    StartListenForeverButton.Enabled = false;
                    ReScanConvertButton.Enabled = false;
                });

                changeFPGAState(FPGA_FSM.FPGA_DISCONNECTED);
            }
        }

        private void tcpclient_DataReceivedEvent(object source, byte[] values)
        {
            if (FPGAState == FPGA_FSM.FPGA_DISCONNECTED)
            {
                Console.WriteLine("Unexpected response from FPGA while " + FPGAState.ToString() + ": " + values.ToString());
            }
            if (FPGAState == FPGA_FSM.FPGA_CONNECTED)
            {
                string msg = System.Text.Encoding.ASCII.GetString(values);
                if (msg == "ok#")
                {
                    String optionString;
                    // If in Listen Only Mode: go directly to receive
                    if (CoordMode == COORD_MODE.COORD_LISTEN || CoordMode == COORD_MODE.COORD_LISTEN_FOREVER)
                    {
                        optionString = "NN: " +
                            (radialLines + 1).ToString().PadLeft(3, '0') + " " +
                            radialLines.ToString().PadLeft(4, '0') + " " +
                            azimuthLines.ToString().PadLeft(3, '0') + " " +
                            elevationLines.ToString().PadLeft(3, '0') + " " +
                            RFDepth.ToString().PadLeft(5, '0') + " " +
                            // Pad left with 0s to five digits if >= 0; minus sign and pad left with 0s to four digits is < 0
                            ZeroOffset.ToString("00000;-0000;00000") + " " +
                            // TODO the SC settings are sent "too late" for the upcoming frame and will be used for the following
                            // one. Not ideal, but if the frames come in a stream, doesn't matter much
                            LogCompression.Value.ToString().PadLeft(3, '0') + " " +
                            Brightness.Value.ToString().PadLeft(3, '0') + " " +
                            CutValue.Value.ToString().PadLeft(3, '0') + " " +
                            ((int)selectedCutDirection).ToString().PadLeft(3, '0') + " " +
                            HWSWSCString +
                            SCResString +
                            "FIFO";
                        tcpclient.Send(optionString);
                        if (HWSCCheckBox.Checked)
                            changeFPGAState(FPGA_FSM.FPGA_RECEIVINGIMAGE);
                        else
                            changeFPGAState(FPGA_FSM.FPGA_RECEIVINGNAPPES);
                        // TODO these lines can probably be put in a better place, shared with the other two modes.
                        // (the other two modes do them at the end of AWAITINGBF). FPGA_RECEIVINGIMAGE does not need them.
                        returnedByteCounter = 0;
                        // Size it according to the configured line counts. 4 bytes per voxel.
                        VoxelBytes = new byte[elevationLines * azimuthLines * 4];
                    }
                    // If in Streaming Mode: start sending data to the end of the frame
                    else if (CoordMode == COORD_MODE.COORD_STREAMING)
                    {
                        changeFPGAState(FPGA_FSM.FPGA_SENDINGRF);
                        optionString = "NN: " +
                            (radialLines + 1).ToString().PadLeft(3, '0') + " " +
                            radialLines.ToString().PadLeft(4, '0') + " " +
                            azimuthLines.ToString().PadLeft(3, '0') + " " +
                            elevationLines.ToString().PadLeft(3, '0') + " " +
                            RFDepth.ToString().PadLeft(5, '0') + " " +
                            // Pad left with 0s to five digits if >= 0; minus sign and pad left with 0s to four digits is < 0
                            ZeroOffset.ToString("00000;-0000;00000") + " " +
                            LogCompression.Value.ToString().PadLeft(3, '0') + " " +
                            Brightness.Value.ToString().PadLeft(3, '0') + " " +
                            CutValue.Value.ToString().PadLeft(3, '0') + " " +
                            ((int)selectedCutDirection).ToString().PadLeft(3, '0') + " " +
                            HWSWSCString +
                            SCResString +
                            "STRM";
                        tcpclient.Send(optionString);
                    }
                    // Else: start sending data, enough data until the nappe identified by NN
                    else if (CoordMode == COORD_MODE.COORD_UBLZ)
                    {
                        changeFPGAState(FPGA_FSM.FPGA_SENDINGRF);
                        // Tell the beamformer what next nappe requires a fresh supply of RF data
                        if (nappeRequiringNewRFDataIndex < nappesRequiringNewRFData.Length - 1)
                            optionString = "NN: " +
                                nappesRequiringNewRFData[nappeRequiringNewRFDataIndex + 1].ToString().PadLeft(3, '0') + " " +
                                radialLines.ToString().PadLeft(4, '0') + " " +
                                azimuthLines.ToString().PadLeft(3, '0') + " " +
                                elevationLines.ToString().PadLeft(3, '0') + " " +
                                RFDepth.ToString().PadLeft(5, '0') + " " +
                                // Pad left with 0s to five digits if >= 0; minus sign and pad left with 0s to four digits is < 0
                                ZeroOffset.ToString("00000;-0000;00000") + " " +
                                LogCompression.Value.ToString().PadLeft(3, '0') + " " +
                                Brightness.Value.ToString().PadLeft(3, '0') + " " +
                                CutValue.Value.ToString().PadLeft(3, '0') + " " +
                                ((int)selectedCutDirection).ToString().PadLeft(3, '0') + " " +
                                HWSWSCString +
                                SCResString +
                                "UBLZ";
                        else
                            optionString = "NN: " +
                                (radialLines + 1).ToString().PadLeft(3, '0') + " " +
                                radialLines.ToString().PadLeft(4, '0') + " " +
                                azimuthLines.ToString().PadLeft(3, '0') + " " +
                                elevationLines.ToString().PadLeft(3, '0') + " " +
                                RFDepth.ToString().PadLeft(5, '0') + " " +
                                // Pad left with 0s to five digits if >= 0; minus sign and pad left with 0s to four digits is < 0
                                ZeroOffset.ToString("00000;-0000;00000") + " " +
                                LogCompression.Value.ToString().PadLeft(3, '0') + " " +
                                Brightness.Value.ToString().PadLeft(3, '0') + " " +
                                CutValue.Value.ToString().PadLeft(3, '0') + " " +
                                ((int)selectedCutDirection).ToString().PadLeft(3, '0') + " " +
                                HWSWSCString +
                                SCResString +
                                "UBLZ";
                        tcpclient.Send(optionString);
                    }
                    else // COORD_RE_SCANCONVERT
                    {
                        changeFPGAState(FPGA_FSM.FPGA_RESCANCONVERTING);
                        optionString = "SC: " +
                            "xxx " +
                            radialLines.ToString().PadLeft(4, '0') + " " +
                            azimuthLines.ToString().PadLeft(3, '0') + " " +
                            elevationLines.ToString().PadLeft(3, '0') + " " +
                            RFDepth.ToString().PadLeft(5, '0') + " " +
                            // Pad left with 0s to five digits if >= 0; minus sign and pad left with 0s to four digits is < 0
                            ZeroOffset.ToString("00000;-0000;00000") + " " +
                            LogCompression.Value.ToString().PadLeft(3, '0') + " " +
                            Brightness.Value.ToString().PadLeft(3, '0') + " " +
                            CutValue.Value.ToString().PadLeft(3, '0') + " " +
                            ((int)selectedCutDirection).ToString().PadLeft(3, '0') + " " +
                            HWSWSCString +
                            SCResString +
                            "RESC";
                        tcpclient.Send(optionString);
                        Debug.WriteLine("Asked for re-SC");
                    }
                    // Debug.WriteLine("Sent the following string: \"" + optionString + "\"");
                }
                else
                    Console.WriteLine("Unexpected response from FPGA while " + FPGAState.ToString() + ": " + values.ToString());
            }
            else if (FPGAState == FPGA_FSM.FPGA_SENDINGRF)
            {
                string msg = System.Text.Encoding.ASCII.GetString(values);
                if (msg == "ok#")
                {
                    VirtualScopeNS.Components.CEchoFileReader echoReader;
                    if (CoordMode == COORD_MODE.COORD_STREAMING)
                    {
                        // Get all the echoes in the file
                        echoReader = new VirtualScopeNS.Components.CEchoFileReader(N_elements_x, N_elements_y, -1);
                        echoReader.Read(PhantomFolderPath + SelectedRunType + Path.DirectorySeparatorChar, SelectedPhantom, 0, true, (UInt32)runCount, zoneCount, compoundCount);
                    }
                    else // COORD_MODE.COORD_UBLZ
                    {
                        echoReader = new VirtualScopeNS.Components.CEchoFileReader(N_elements_x, N_elements_y, (Int32)samplesPerBRAM);
                        echoReader.Read(PhantomFolderPath + SelectedRunType + Path.DirectorySeparatorChar, SelectedPhantom, nappeIndex, false, runIndex, zoneCount, compoundCount);
                    }

                    Int32[,] echoValues = new Int32[echoReader.EchoLength(), BRAMCount];
                    echoValues = echoReader.Echoes();

                    // Use this "trick", instead of just setting control properties,
                    // so that the update happens on the UI thread, not on the network thread.                    
                    this.Invoke((MethodInvoker)delegate
                    {
                        progressBar.Value = (int)Math.Min(nappeIndex, radialLines) + (int)radialLines * runIndex;
                        progressBar.Refresh();
                        string progressString = "Sending RF inputs " + progressBar.Value.ToString() + " / " + (runCount * radialLines).ToString();
                        Font progressFont = new Font("Arial", (float)12, FontStyle.Bold);
                        using (Graphics gr = progressBar.CreateGraphics())
                        {
                            gr.DrawString(progressString, progressFont, Brushes.Black, new PointF(progressBar.Width / 2 - (gr.MeasureString(progressString, progressFont).Width / 2.0F),
                                                                                                  progressBar.Height / 2 - (gr.MeasureString(progressString, progressFont).Height / 2.0F)));
                        }
                    });

                    Debug.WriteLine("Sending to FPGA RF data starting from nappe " + nappeIndex.ToString());

                    // Iterate most frequently on the elements, and once a whole set of samples is written in,
                    // switch to the next sample index
                    for (UInt16 s = 0; s < echoValues.GetLength(0); s++)
                    {
                        for (UInt16 t = 0; t < BRAMCount; t++)
                        {
                            Int32 valueToSend = echoValues[s, t];
                            Byte[] bytes = BitConverter.GetBytes(valueToSend);
                            if (tcpclient != null)
                                tcpclient.Send(bytes);
                        }
                    }
                    // for (int o = 0; o < 30; o ++)
                    //    Debug.WriteLine("Wrote output " + o.ToString() + ": " + ((double)echoValues[0, o] / 4).ToString());

                    // Now fast-forward to the next nappe which will need fresh RF data while the beamformer
                    // proceeds in parallel. The first branch of the if can only occur when in UBLZ mode.
                    if (nappeRequiringNewRFDataIndex < nappesRequiringNewRFData.Length - 1)
                        nappeIndex = nappesRequiringNewRFData[++ nappeRequiringNewRFDataIndex];
                    // If the current supply of RF data is sufficient until the end of the volume,
                    // prepare for the next run
                    else
                    {
                        nappeRequiringNewRFDataIndex = 0;
                        // STRM mode: we have transmitted all data in a single chunk
                        // set runIndex to 0 (to let other code detect the end-of-reconstruction situation)
                        // set nappeIndex to an artificial value to ensure the progress bar is displayed right
                        if (CoordMode == COORD_MODE.COORD_STREAMING)
                        {
                            runIndex = 0;
                            nappeIndex = (UInt16)(radialLines * runCount);
                        }
                        // UBLZ mode, normally: push up runIndex
                        else if (runIndex < runCount - 1)
                        {
                            runIndex++;
                            nappeIndex = nappesRequiringNewRFData[0];
                        }
                        // UBLZ mode, at the end of the reconstruction:
                        // set runIndex to 0 (to let other code detect the end-of-reconstruction situation)
                        // set nappeIndex to an artificial value to ensure the progress bar is displayed right
                        else
                        {
                            runIndex = 0;
                            nappeIndex = (UInt16)(radialLines * runCount);
                        }
                    }

                    // Use this "trick", instead of just setting control properties,
                    // so that the update happens on the UI thread, not on the network thread.                    
                    this.Invoke((MethodInvoker)delegate
                    {
                        progressBar.Value = (int)nappeIndex + (int)radialLines * runIndex;
                        progressBar.Refresh();
                        string progressString = "Sending RF inputs " + progressBar.Value.ToString() + " / " + (runCount * radialLines).ToString();
                        Font progressFont = new Font("Arial", (float)12, FontStyle.Bold);
                        using (Graphics gr = progressBar.CreateGraphics())
                        {
                            gr.DrawString(progressString, progressFont, Brushes.Black, new PointF(progressBar.Width / 2 - (gr.MeasureString(progressString, progressFont).Width / 2.0F),
                                                                                                  progressBar.Height / 2 - (gr.MeasureString(progressString, progressFont).Height / 2.0F)));
                        }
                    });

                    if (CoordMode == COORD_MODE.COORD_STREAMING)
                    {
                        tcpclient.Send("sendnappes#");
                        if (HWSCCheckBox.Checked)
                            changeFPGAState(FPGA_FSM.FPGA_RECEIVINGIMAGE);
                        else
                            changeFPGAState(FPGA_FSM.FPGA_RECEIVINGNAPPES);
                        returnedByteCounter = 0;
                        // Size it according to the configured line counts. 4 bytes per voxel.
                        VoxelBytes = new byte[elevationLines * azimuthLines * 4];
                    }
                    else // COORD_UBLZ
                    {
                        tcpclient.Send("startbf#");
                        changeFPGAState(FPGA_FSM.FPGA_AWAITINGBF);
                    }
                }
                else
                    Console.WriteLine("Unexpected response from FPGA while " + FPGAState.ToString() + ": " + values.ToString());
            }
            else if (FPGAState == FPGA_FSM.FPGA_AWAITINGBF)
            {
                string msg = System.Text.Encoding.ASCII.GetString(values);
                if (msg.Contains("ok#"))
                {
                    // If this condition occurs, we are at the last nappe of the last run
                    if (nappeRequiringNewRFDataIndex == 0 && runIndex == 0)
                    {
                        tcpclient.Send("sendnappes#");
                        if (HWSCCheckBox.Checked)
                            // TODO must verify if we can do this in case of multi-zone or compounding
                            changeFPGAState(FPGA_FSM.FPGA_RECEIVINGIMAGE);
                        else
                            changeFPGAState(FPGA_FSM.FPGA_RECEIVINGNAPPES);
                    }
                    else
                    {
                        tcpclient.Send("####sendrf#");
                        changeFPGAState(FPGA_FSM.FPGA_CONNECTED);
                    }
                    returnedByteCounter = 0;
                    // Size it according to the configured line counts. 4 bytes per voxel.
                    VoxelBytes = new byte[elevationLines * azimuthLines * 4];
                }
                else
                    Console.WriteLine("Unexpected response from FPGA while " + FPGAState.ToString() +  ": " + values.ToString());
            }
            else if (FPGAState == FPGA_FSM.FPGA_RECEIVINGNAPPES)
            {
                // There might have been leftover bytes from a previous packet. Append the current
                // packet to them and pass along.
                // Debug.WriteLine("New packet has: " + values.Length.ToString() + " bytes, prepending previous Message of " + Message.Length.ToString());
                //Array.Resize(ref lastpacket_prev, lastpacket.Length);
                //Array.Copy(lastpacket, 0, lastpacket_prev, 0, lastpacket.Length);
                //Array.Resize(ref lastpacket, values.Length);
                //Array.Copy(values, 0, lastpacket, 0, values.Length);
                //Array.Resize(ref lastpacket_leftovers, Message.Length);
                //Array.Copy(Message, 0, lastpacket_leftovers, 0, Message.Length);

                Array.Resize(ref Message, Message.Length + values.Length);
                Array.Copy(values, 0, Message, Message.Length - values.Length, values.Length);
                Array.Resize(ref values, 0);

                ProcessIncomingNappePacket();
            }
            else if (FPGAState == FPGA_FSM.FPGA_RECEIVINGIMAGE)
            {
                // There might have been leftover bytes from a previous packet. Append the current
                // packet to them and pass along.
                // Debug.WriteLine("New packet has: " + values.Length.ToString() + " bytes, prepending previous Message of " + Message.Length.ToString());
                //Array.Resize(ref lastpacket_prev, lastpacket.Length);
                //Array.Copy(lastpacket, 0, lastpacket_prev, 0, lastpacket.Length);
                //Array.Resize(ref lastpacket, values.Length);
                //Array.Copy(values, 0, lastpacket, 0, values.Length);
                //Array.Resize(ref lastpacket_leftovers, Message.Length);
                //Array.Copy(Message, 0, lastpacket_leftovers, 0, Message.Length);

                Array.Resize(ref Message, Message.Length + values.Length);
                Array.Copy(values, 0, Message, Message.Length - values.Length, values.Length);
                Array.Resize(ref values, 0);

                ProcessIncomingImagePacket();
            }
            else if (FPGAState == FPGA_FSM.FPGA_RESCANCONVERTING)
            {
                string msg = System.Text.Encoding.ASCII.GetString(values);
                
                if (msg == "ok#")
                {
                    changeFPGAState(FPGA_FSM.FPGA_CONNECTED);

                    this.Invoke((MethodInvoker)delegate
                    {
                        ProgressLabel.Text = "";
                        progressBar.Visible = false;

                        // Usually, wrap up and get ready to restart.
                        StartMicroblazeButton.Enabled = true;
                        StartStreamingButton.Enabled = true;
                        StartListenButton.Enabled = true;
                        StartListenForeverButton.Enabled = true;
                        ReScanConvertButton.Enabled = true;
                    });
                }
                else
                    Console.WriteLine("Unexpected response from FPGA while " + FPGAState.ToString() + ": " + values.ToString());

                // TODO read a packet back now, if HW SC is enabled
            }
        }

        private void ProcessIncomingNappePacket()
        {
            bool EndOfNappe = true;
            byte[] tmp = new byte[0];

            // Iteratively keep searching for "ok#" in the incoming string.
            // If found, process the nappe ending with the "ok#".
            // Especially for 2D imaging, multiple nappes may come in a single packet,
            // so repeat as long as "ok#"s are found.
            // Two possible exit conditions: last nappe of the volume, in which
            // case just exit; or no more "ok#"s in the packet, in which case just store
            // the packet leftovers (if any) into a storage array to be processed with the
            // next packet
            while (EndOfNappe && Message.Length >= 3)
            {
                int index = 0;
                while (index == 0)
                {
                    index = System.Text.Encoding.ASCII.GetString(Message).IndexOf("ok#");
                    if (index == 0)
                    {
                        // Special case: an "ok#" was broken right at the end of the previous message,
                        // so this one has an "ok#" right at the beginning.
                        // Trim it away and repeat the processing.
                        tmp = new byte[Message.Length - 3];
                        // TODO check if this can be done with a copy over itself or a start trim instead of this mess.
                        Array.Copy(Message, 3, tmp, 0, Message.Length - 3);
                        Array.Copy(tmp, 0, Message, 0, tmp.Length);
                        Array.Resize(ref Message, Message.Length - 3);
                        Array.Resize(ref tmp, 0);
                    }
                    else if (index == -1)
                    {
                        // Special case: an "ok#" may be broken right at the end of the message,
                        // so the previous search returns -1 but there are more packet bytes than
                        // the remaining bytes to fill up the nappe.
                        int maxLength = (int)azimuthLines * (int)elevationLines * 4 - (int)returnedByteCounter;
                        if (Message.Length > maxLength)
                        {
                            tmp = new byte[Message.Length - maxLength];
                            Array.Copy(Message, maxLength, tmp, 0, Message.Length - maxLength);
                            Array.Resize(ref Message, maxLength);
                        }
                        // If the message is just long enough to reach the end of the nappe without any extra bytes
                        // (pieces of "ok#"), no need to save any extra info into "tmp"
                        else if (Message.Length == maxLength)
                        {
                        }
                        // Else, we have really run out of data to fill the nappe in.
                        else
                            EndOfNappe = false;
                    }
                    else // index > 0: location of "ok#" in string
                    {
                        // If an "ok#" is found, copy anything after it into a tmp array, while
                        // trimming "Message" to just this nappe
                        tmp = new byte[Message.Length - (index + 3)];
                        Array.Copy(Message, index + 3, tmp, 0, Message.Length - (index + 3));
                        Array.Resize(ref Message, index);
                    }
                }

                // Get all the voxels of the nappe from the packet and put them into VoxelBytes.
                // returnedByteCounter tracks how many bytes of this nappe we have accumulated. The count is in bytes (not voxels) because
                // sometimes packets may carry a fraction of voxel (i.e. 1-3 bytes) that will be completed in the next packet.
                // TODO there is no need to keep all of VoxelBytes in memory; it can be progressively written to file and to preSCImage.
                Array.Copy(Message, 0, VoxelBytes, returnedByteCounter, Message.Length);
                returnedByteCounter += (uint)Message.Length;
                Array.Resize(ref Message, 0);

                // We have reached the end of a nappe. In that case save it to the image data,
                // save it to file (if requested), and update the GUI.
                if (EndOfNappe)
                {
                    // Use this "trick", instead of just setting control properties,
                    // so that the update happens on the UI thread, not on the network thread.
                    this.Invoke((MethodInvoker)delegate
                    {
                        progressBar.Value = (int)(receivedNappeIndex + radialLines * runCount);
                        progressBar.Refresh();
                        string progressString = "Receiving nappe " + receivedNappeIndex.ToString() + " / " + radialLines.ToString();
                        Font progressFont = new Font("Arial", (float)12, FontStyle.Bold);
                        using (Graphics gr = progressBar.CreateGraphics())
                        {
                            gr.DrawString(progressString, progressFont, Brushes.Black, new PointF(progressBar.Width / 2 - (gr.MeasureString(progressString, progressFont).Width / 2.0F),
                                                                                                  progressBar.Height / 2 - (gr.MeasureString(progressString, progressFont).Height / 2.0F)));
                        }
                    });

                    Debug.Assert(returnedByteCounter == azimuthLines * elevationLines * 4);
#if SAVE_NAPPES
                    nappeFile = new StreamWriter(NappeFolderPath + SelectedPhantom + "_nappe_" + receivedNappeIndex + ".txt");
#endif
                    for (int ByteCounter = 0; ByteCounter < returnedByteCounter; ByteCounter += 4)
                    {
                        int voxel = BitConverter.ToInt32(VoxelBytes, ByteCounter);
#if SAVE_NAPPES
                        nappeFile.WriteLine("{0:F2}", (double)voxel / 4);
#endif
                        int retval = preSCImage.AddPixel(voxel);
                    }

#if SAVE_NAPPES
                    nappeFile.Flush();
                    nappeFile.Close();
#endif
                    returnedByteCounter = 0;

                    // This might have been the last nappe. Take special action.
                    if (receivedNappeIndex < radialLines)
                        receivedNappeIndex++;
                    else
                    {
                        receivedNappeIndex = 1;
                        changeFPGAState(FPGA_FSM.FPGA_CONNECTED);
                        // Use this "trick", instead of just setting control properties,
                        // so that the update happens on the UI thread, not on the network thread.
                        this.Invoke((MethodInvoker)delegate
                        {
                            progressBar.Value = (int)(radialLines) * (runCount + 1);
                            progressBar.Refresh();
                            string progressString = "Scan Converting";
                            Font progressFont = new Font("Arial", (float)12, FontStyle.Bold);
                            using (Graphics gr = progressBar.CreateGraphics())
                            {
                                gr.DrawString(progressString, progressFont, Brushes.Black, new PointF(progressBar.Width / 2 - (gr.MeasureString(progressString, progressFont).Width / 2.0F),
                                                                                                      progressBar.Height / 2 - (gr.MeasureString(progressString, progressFont).Height / 2.0F)));
                            }

                            ProgressLabel.Text = "Scan converting...";

                            Int32 midX = Convert.ToInt32(scanConverter.WidthAfterScanConversion(preSCImage.GetSizeX(), theta * 2.0 * Math.PI / 360.0) / 2);
                            Int32 midY = Convert.ToInt32(scanConverter.HeightAfterScanConversion(preSCImage.GetSizeX(), phi * 2.0 * Math.PI / 360.0) / 2);
                            Int32 midZ = Convert.ToInt32(preSCImage.GetSizeX() / 2);

                            // The value in dB must be converted into an absolute voxel brightness value;
                            // the dB input has a range [1, 192] (== 32-bit dynamic range)
                            // To achieve a bright image, we need to pass a small value,
                            // so the exponent is taken with inverted sign
                            // +20 dB => 10 times smaller reference voxel intensity; 
                            Double referenceMaxVoxel;
                            if (Brightness.Value == 0)
                                referenceMaxVoxel = 0.0;
                            else
                                referenceMaxVoxel = Math.Pow(10.0, (193.0 - (double)Brightness.Value) / 20.0);

                            postSCImageXY = scanConverter.ScanConvertBitmap(preSCImage, preSCImage.GetSizeX(), theta * 2.0 * Math.PI / 360.0, phi * 2.0 * Math.PI / 360.0, r, true, -1, -1, midZ, (UInt32)LogCompression.Value, referenceMaxVoxel);
                            postSCImageXZ = scanConverter.ScanConvertBitmap(preSCImage, preSCImage.GetSizeX(), theta * 2.0 * Math.PI / 360.0, phi * 2.0 * Math.PI / 360.0, r, true, -1, midY, -1, (UInt32)LogCompression.Value, referenceMaxVoxel);
                            postSCImageYZ = scanConverter.ScanConvertBitmap(preSCImage, preSCImage.GetSizeX(), theta * 2.0 * Math.PI / 360.0, phi * 2.0 * Math.PI / 360.0, r, true, midX, -1, -1, (UInt32)LogCompression.Value, referenceMaxVoxel);
                            
                            int.TryParse(CompoundChooser.SelectedItem.ToString(), out compoundCount);
                            FrameRateLabel.Text = (clk_freq_mhz * 1000000 / (radialLines * azimuthLines * elevationLines * compoundCount)).ToString(); // TODO actually measure it more accurately

                            ProgressLabel.Text = "Plotting...";

                            drawPlots();

                            ProgressLabel.Text = "";
                            progressBar.Visible = false;

                            stopWatch.Stop();
                            TimeSpan ts = stopWatch.Elapsed;
                            // Format and display the TimeSpan value.
                            string elapsedTime = String.Format("{0}:{1:00} minutes", ts.Minutes, ts.Seconds);
                            Console.WriteLine("This reconstruction took " + elapsedTime);
                            stopWatch.Reset();

                            // Usually, wrap up and get ready to restart. However,
                            // if COORD_LISTEN_FOREVER, get auto-restarted
                            if (CoordMode != COORD_MODE.COORD_LISTEN_FOREVER)
                            {
                                StartMicroblazeButton.Enabled = true;
                                StartStreamingButton.Enabled = true;
                                StartListenButton.Enabled = true;
                                StartListenForeverButton.Enabled = true;
                                ReScanConvertButton.Enabled = true;
                            }
                            else
                            {
                                FinalizeStart();
                            }
                        });
                    }
                }

                // There may be more full nappes in tmp. Keep iterating until there
                // are only some bytes left which we will process together with the next packet.
                if (tmp.Length != 0)
                {
                    Array.Resize(ref Message, tmp.Length);
                    Array.Copy(tmp, Message, tmp.Length);
                    Array.Resize(ref tmp, 0);
                }
            }
        }
        
        private void ProcessIncomingImagePacket()
        {
            // Search for "ok#" in the incoming string.
            // Two possible exit conditions: "ok#", in which case just exit;
            // or not, in which case just store the packet leftovers (if any)
            // into a storage array to be processed with the next packet.
            // Note that, contrary to nappe processing, we cannot receive multiple
            // images in a sequence (and therefore in a packet), which simplifies
            // the logic.
            int index = System.Text.Encoding.ASCII.GetString(Message).IndexOf("ok#");
            if (index == -1)
            {
                // This packet does not contain the "ok#" yet. Don't process this image yet.
                // Keep the previous data in Message, then wait for whatever
                // remaining fragments to flush them, after which we will take care of things.
                // Returns here.
            }
            else // index > 0: location of "ok#" in string
            {
                // If an "ok#" is found, trim "Message" to just what precedes it
                Array.Resize(ref Message, index);

                UInt32 x_pointer = 0, y_pointer = 0;
                // We have reached the end of the image data. In this case update the GUI.
                for (int ByteCounter = 0; ByteCounter < Message.Length; ByteCounter += 4)
                {
                    // The pixels are 32-bit encoded, but since the image is greyscale,
                    // they have 0RGB format; the real grey level is e.g. in the 8 LSBs
                    int pixel = BitConverter.ToInt32(Message, ByteCounter) & 0xff;
                    postSCImage.SetPixel(x_pointer, y_pointer, 0, (double)pixel);
                    if (x_pointer < scanConvertedImageWidth - 1)
                        x_pointer ++;
                    else
                    {
                        Debug.Assert(y_pointer < scanConvertedImageHeight);
                        x_pointer = 0;
                        y_pointer ++;
                    }
                }

                Array.Resize(ref Message, 0);

                changeFPGAState(FPGA_FSM.FPGA_CONNECTED);
                // Use this "trick", instead of just setting control properties,
                // so that the update happens on the UI thread, not on the network thread.
                this.Invoke((MethodInvoker)delegate
                {
                    progressBar.Value = (int)radialLines * (runCount + 1);
                    progressBar.Refresh();
                    string progressString = "Plotting";
                    Font progressFont = new Font("Arial", (float)12, FontStyle.Bold);
                    using (Graphics gr = progressBar.CreateGraphics())
                    {
                         gr.DrawString(progressString, progressFont, Brushes.Black, new PointF(progressBar.Width / 2 - (gr.MeasureString(progressString, progressFont).Width / 2.0F),
                                                                                               progressBar.Height / 2 - (gr.MeasureString(progressString, progressFont).Height / 2.0F)));
                    }

                    // TODO a bit dumb to have 3 copies
                    postSCImageXY = postSCImage.GetBitmap(-1, -1, 0);
                    postSCImageXZ = postSCImage.GetBitmap(-1, -1, 0);
                    postSCImageYZ = postSCImage.GetBitmap(-1, -1, 0);


                    int.TryParse(CompoundChooser.SelectedItem.ToString(), out compoundCount);
                    FrameRateLabel.Text = (clk_freq_mhz * 1000000 / (radialLines * azimuthLines * elevationLines * compoundCount)).ToString(); // TODO actually measure it more accurately

                    ProgressLabel.Text = "Plotting...";

                    drawPlots();

                    ProgressLabel.Text = "";
                    progressBar.Visible = false;

                    stopWatch.Stop();
                    TimeSpan ts = stopWatch.Elapsed;
                    // Format and display the TimeSpan value.
                    string elapsedTime = String.Format("{0}:{1:00} minutes", ts.Minutes, ts.Seconds);
                    Console.WriteLine("This reconstruction took " + elapsedTime);
                    stopWatch.Reset();

                    // Usually, wrap up and get ready to restart. However,
                    // if COORD_LISTEN_FOREVER, get auto-restarted
                    if (CoordMode != COORD_MODE.COORD_LISTEN_FOREVER)
                    {
                        StartMicroblazeButton.Enabled = true;
                        StartStreamingButton.Enabled = true;
                        StartListenButton.Enabled = true;
                        StartListenForeverButton.Enabled = true;
                        ReScanConvertButton.Enabled = true;
                    }
                    else
                    {
                        FinalizeStart();
                    }
                });
            }
        }
        
        private void changeFPGAState(FPGA_FSM newState)
        {
            FPGAState = newState;
            //Debug.WriteLine("New FSM state is " + newState.ToString());
        }

        private void changeCoordMode(COORD_MODE newMode)
        {
            CoordMode = newMode;
            //Debug.WriteLine("New coordination mode is " + newMode.ToString());
        }

        private void refreshUI(bool resizeWindow = false)
        {
            // Temporarily maximize the window to make sure we have enough space to fit the controls if the images grow in size.
            // TODO should also resize if theta/phi change, actually.
            bool wasMaximized = true;
            if (resizeWindow && this.WindowState != FormWindowState.Maximized)
            {
                // Temporarily maximize the window
                this.WindowState = FormWindowState.Maximized;
                wasMaximized = false;
            }

            // If the view rotation button has been clicked and/or the SC output resolution has been edited
            Double angle = 0.0;
            Double multiplier = 1.0;
            switch (viewCounter)
            {
                case View.XZViewFirst:
                    // Height is Z, width X depends on theta
                    angle = theta;
                    multiplier = 2.0;
                    CutValue.Maximum = elevationLines - 1;
                    selectedCutDirection = CUT_DIRECTION.AZIRAD;
                    break;
                case View.YZViewFirst:
                    // Height is Z, width Y depends on phi
                    angle = phi;
                    multiplier = 2.0;
                    CutValue.Maximum = azimuthLines - 1;
                    selectedCutDirection = CUT_DIRECTION.ELERAD;
                    break;
                case View.XYViewFirst:
                    // Image is roughly square, achieve this with a "hack"
                    angle = 180;
                    multiplier = 1.0;
                    CutValue.Maximum = radialLines - 1;
                    selectedCutDirection = CUT_DIRECTION.ELEAZI;
                    break;
                default:
                    angle = 0.0;
                    multiplier = 1.0;
                    CutValue.Maximum = elevationLines - 1;
                    selectedCutDirection = CUT_DIRECTION.AZIRAD;
                    break;
            }
            scanConvertedImageWidth = (UInt32)(multiplier * (Double)scanConvertedImageHeight * Math.Sin(angle / 2 * Math.PI / 180));
            scanConvertedImageWidthLabel.Text = "(Width: " + scanConvertedImageWidth.ToString() + ")";
            SCResString = scanConvertedImageWidth.ToString() + " " + scanConvertedImageHeight.ToString() + " ";
            drawPlots();

            // TODO these two margins are quite empirical and possibly fragile.
            Int32 widthMargin = 30;
            Int32 heightMargin = 70;
            this.MinimumSize = new Size(Math.Max(this.flowLayoutPanelImages.Width, this.flowLayoutPanelControls.Width) + widthMargin, this.flowLayoutPanelImages.Height + this.flowLayoutPanelControls.Height + heightMargin);
            if (resizeWindow && !wasMaximized)
            {
                this.Width = this.MinimumSize.Width;
                this.Height = this.MinimumSize.Height;
                this.WindowState = FormWindowState.Normal;
            }

            // If the zone imaging chooser has been edited
            // TODO a bit lame, must disable zone imaging before enabling compounding
            if (ZoneChooser.SelectedIndex > 0)
            {
                CompoundChooser.Enabled = false;
                CompoundOp.Enabled = false;
            }
            else
            {
                CompoundChooser.Enabled = true;
                CompoundOp.Enabled = true;
            }

            // If the compounding chooser has been edited
            if (CompoundChooser.SelectedIndex > 0)
            {
                SelectedRunType = "compounding_" + CompoundChooser.SelectedItem.ToString();
                ZoneChooser.Enabled = false;
            }
            else
            {
                SelectedRunType = "zone_" + ZoneChooser.SelectedItem.ToString();
                ZoneChooser.Enabled = true;
            }

            // If the phantom chooser and/or the zone/compounding chooser have been edited
            if (PhantomChooser.SelectedIndex != -1)
            {
                SelectedPhantom = PhantomChooser.Text;
                String settingsPath = Path.Combine(DataFolderPath, SelectedPhantom) + Path.DirectorySeparatorChar + SelectedRunType + Path.DirectorySeparatorChar + "settings.txt";
                VirtualScopeNS.Components.CSettings Settings = new VirtualScopeNS.Components.CSettings(settingsPath);
                if (SelectedPhantom == "LightProbe")
                {
                    // TODO need a special case because this won't be generated by Matlab.
                    // But is it a good idea to hardcode it here? Maybe commit to git a preset settings.txt? Especially RFD and ZO.
                    f0 = 4.0;
                    fs = 20.0;
                    c = 1540;
                    theta = 73;
                    phi = 0;
                    r = 10.0;
                    N_elements_x = 64;
                    N_elements_y = 1;
                    BRAMCount = (N_elements_y > 1 ? (N_elements_x * N_elements_y / 2) : (N_elements_x * N_elements_y));
                    samplesPerBRAM = 1024;
                    radialLines = 500;
                    azimuthLines = 64;
                    elevationLines = 1;
                    RFDepth = 2743;
                    ZeroOffset = -100;
                }
                else if (Settings.Read())
                {
                    f0 = Settings.CenterFrequencyMHz;
                    fs = Settings.SamplingFrequencyMHz;
                    c = Settings.SpeedOfSound;
                    theta = Settings.ThetaDeg;
                    phi = Settings.PhiDeg;
                    r = Settings.RCentimeters;
                    N_elements_x = Settings.ElementCountX;
                    N_elements_y = Settings.ElementCountY;
                    BRAMCount = (N_elements_y > 1 ? (N_elements_x * N_elements_y / 2) : (N_elements_x * N_elements_y));
                    samplesPerBRAM = Settings.SamplesInBRAM;
                    radialLines = Settings.RadialLines;
                    azimuthLines = Settings.AzimuthLines;
                    elevationLines = Settings.ElevationLines;
                    RFDepth = Settings.RFDepth;
                    ZeroOffset = Settings.ZeroOffset;
                }
                // TODO else?

                probe = new VirtualScopeNS.Components.CProbe();
                probe.f0 = Convert.ToUInt32(f0 * 1000000);
                probe.fs = Convert.ToUInt32(fs * 1000000);
                probe.c = c;
                double lambda = probe.c / probe.f0;
                probe.width = lambda / 4;
                probe.height = lambda / 4;
                probe.kerf_x = lambda / 10;
                probe.kerf_y = lambda / 10;
                probe.pitch_x = probe.width + probe.kerf_x;
                probe.pitch_y = probe.height + probe.kerf_y;
                probe.N_elements_x = N_elements_x;
                probe.N_elements_y = N_elements_y;

                scanConverter = new VirtualScopeNS.Components.CScanConverter(probe);

                phantomLabel.Text = N_elements_x.ToString() + "x" + N_elements_y.ToString() + "-element probe, \n" +
                                    f0.ToString() + "MHz center f sampled at " + fs.ToString() + "MHz, \n" +
                                    azimuthLines.ToString() + "x" + elevationLines.ToString() + "x" + radialLines.ToString() + " FP in a " + theta.ToString() + "'x" + phi.ToString() + "'x" + r.ToString() + "cm volume";
            }
        }

        private void connectButton_Click(object sender, System.EventArgs e)
        {
            if (tcpclient.IsOpened)
                tcpclient.Disconnect();
            if (boardConnected)
            {
                tcpclient.Disconnect();
            }
            else
            {
                tcpclient.Connect(host, port);
            }
        }

        private void setupButtonClick(object sender, System.EventArgs e)
        {
            TCPSetup setup = new TCPSetup();
            setup.host = host;
            setup.port = port;
            setup.clk_freq_mhz = clk_freq_mhz;

            setup.ShowDialog();

            host = setup.host;
            port = setup.port;
            clk_freq_mhz = setup.clk_freq_mhz;
        }

        private void VirtualScope_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (MessageBox.Show(this, "Are you sure you want to exit?", "Virtual Scope", System.Windows.Forms.MessageBoxButtons.OKCancel, System.Windows.Forms.MessageBoxIcon.Question) == System.Windows.Forms.DialogResult.OK)
            {
                tcpclient.Disconnect();
            }
            else
            {
                e.Cancel = true;
            }
        }

        private void CycleButton_Click(object sender, EventArgs e)
        {
            switch (viewCounter)
            {
                case View.XZViewFirst:
                    viewCounter = View.YZViewFirst;
                    break;
                case View.YZViewFirst:
                    viewCounter = View.XYViewFirst;
                    break;
                case View.XYViewFirst:
                    viewCounter = View.XZViewFirst;
                    break;
                default:
                    viewCounter = View.XZViewFirst;
                    break;
            }

            refreshUI();

            // TODO and also (HW SC) launch a re-scanconvert
        }

        private void drawPlots()
        {
            // Space around the beamformed/reference images and their panels
            // (to put the axes)
            Int32 panelMargin = 128;
            // Label "cm" position
            Int32 labelCmMargin = 22;
            // Checkboxes under the reference image
            Int32 checkBoxMargin = 69;

            BeamformedImage.Width = (int)scanConvertedImageWidth;
            BeamformedImage.Height = (int)scanConvertedImageHeight;
            panelReconstructed.Width = (int)scanConvertedImageWidth + panelMargin;
            panelReconstructed.Height = (int)scanConvertedImageHeight + panelMargin;
            labelReconstructed.Location = new Point((panelReconstructed.Width - labelReconstructed.Width) / 2, labelReconstructed.Location.Y);
            labelReconstructedCm.Location = new Point(labelReconstructedCm.Location.X, BeamformedImage.Location.Y + BeamformedImage.Height + labelCmMargin);

            ReferenceImage.Width = (int)scanConvertedImageWidth;
            ReferenceImage.Height = (int)scanConvertedImageHeight;
            panelReference.Width = (int)scanConvertedImageWidth + panelMargin;
            panelReference.Height = (int)scanConvertedImageHeight + panelMargin;
            labelReference.Location = new Point((panelReference.Width - labelReference.Width) / 2, labelReference.Location.Y);
            labelReferenceCm.Location = new Point(labelReferenceCm.Location.X, ReferenceImage.Location.Y + ReferenceImage.Height + labelCmMargin);
            //TODO when the image size goes below ~300, this results in some unsightly cropping
            Int32 widthMargin = panelReference.Width - FixedPointCheckBox.Width - DelayApproximationCheckBox.Width - StaticApodizationCheckBox.Width;
            FixedPointCheckBox.Location = new Point(widthMargin / 4, ReferenceImage.Location.Y + ReferenceImage.Height + checkBoxMargin);
            DelayApproximationCheckBox.Location = new Point(widthMargin / 4 + FixedPointCheckBox.Width + widthMargin / 4, ReferenceImage.Location.Y + ReferenceImage.Height + checkBoxMargin);
            StaticApodizationCheckBox.Location = new Point(widthMargin / 4 + FixedPointCheckBox.Width + widthMargin / 4 + DelayApproximationCheckBox.Width + widthMargin / 4, ReferenceImage.Location.Y + ReferenceImage.Height + checkBoxMargin);

            if (viewCounter == View.XZViewFirst)
            {
                BeamformedImage.Image = (Image)postSCImageXZ;
                BeamformedImageLabel.Text = "XZ Plane";
                ReferenceImage.Image = (Image)referenceImageXZ;
                ReferenceImageLabel.Text = "XZ Plane";
            }
            else if (viewCounter == View.YZViewFirst)
            {
                BeamformedImage.Image = (Image)postSCImageYZ;
                BeamformedImageLabel.Text = "YZ Plane";
                ReferenceImage.Image = (Image)referenceImageYZ;
                ReferenceImageLabel.Text = "YZ Plane";
            }
            else if (viewCounter == View.XYViewFirst)
            {
                BeamformedImage.Image = (Image)postSCImageXY;
                BeamformedImageLabel.Text = "XY Plane";
                ReferenceImage.Image = (Image)referenceImageXY;
                ReferenceImageLabel.Text = "XY Plane";
            }

            panelReconstructed.Refresh();
            panelReference.Refresh();
        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {
            base.OnPaint(e);
            using (Graphics g = e.Graphics)
            {
                // TODO a bit of manual pixel adjustments in this function

                int top = BeamformedImage.Location.Y;
                int bottom = BeamformedImage.Location.Y + BeamformedImage.ClientRectangle.Bottom;
                int right = BeamformedImage.Location.X + BeamformedImage.ClientRectangle.Right;
                int left = BeamformedImage.Location.X;

                // Axes
                Pen p = new Pen(Color.Black, 2);
                g.DrawLine(p, left, top, left, bottom);
                g.DrawLine(p, left, bottom, right, bottom);
                p = new Pen(Color.Black, 1);
                
                // Calibrate the tick count so that we have ~1 per cm along the Z axis of the image
                // (nice round number if r is integer, else with decimals)
                UInt16 tickCount = Convert.ToUInt16(Math.Floor(r));

                if (viewCounter == View.XZViewFirst || viewCounter == View.YZViewFirst)
                {
                    // Ticks on Y axis of the figure
                    Double minY = 0; // TODO we don't support shallow trimming yet.
                    Double maxY = r;
                    for (UInt16 i = 0; i <= tickCount; i++)
                    {
                        Int16 yCoord = Convert.ToInt16(top + Math.Round(i * (bottom - top) / r));
                        g.DrawLine(p, new Point(left - 10, yCoord), new Point(left, yCoord));
                        Double yVal = minY + i * (maxY - minY) / tickCount;
                        panel1YLabels[i].Location = new Point(left - 50, yCoord - 10);
                        panel1YLabels[i].Text = string.Format("{0:F1}", yVal);
                    }

                    // Ticks on X axis of the figure
                    Double xSpan = (maxY - minY) * BeamformedImage.Width / BeamformedImage.Height;
                    Double minX = -xSpan / 2;
                    Double maxX = xSpan / 2;
                    for (UInt16 i = 0; i <= tickCount; i++)
                    {
                        Int16 xCoord = Convert.ToInt16(left + Math.Round(i * (right - left) / r) - 1);
                        g.DrawLine(p, new Point(xCoord, bottom), new Point(xCoord, bottom + 10));
                        Double xVal = minX + i * (maxX - minX) / tickCount;
                        panel1XLabels[i].Location = new Point(xCoord - 20, bottom + 15);
                        panel1XLabels[i].Text = string.Format("{0:F1}", xVal);
                    }
                }
                else // viewCounter == View.XYViewFirst
                {
                    // Ticks on Y axis of the figure
                    // In this view, the vertical axis of the image covers the same range that was
                    // spanned along the horizontal axis of the other views.
                    Double minY = 0;
                    Double maxY = r * BeamformedImage.Width / BeamformedImage.Height;
                    for (UInt16 i = 0; i <= tickCount; i++)
                    {
                        Int16 yCoord = Convert.ToInt16(top + Math.Round(i * (bottom - top) / r));
                        g.DrawLine(p, new Point(left - 10, yCoord), new Point(left, yCoord));
                        Double yVal = minY + i * (maxY - minY) / tickCount;
                        panel1YLabels[i].Location = new Point(left - 50, yCoord - 10);
                        panel1YLabels[i].Text = string.Format("{0:F1}", yVal);
                    }

                    // Ticks on X axis of the figure
                    Double xSpan = (maxY - minY) * BeamformedImage.Width / BeamformedImage.Height;
                    Double minX = -xSpan / 2;
                    Double maxX = xSpan / 2;
                    for (UInt16 i = 0; i <= tickCount; i++)
                    {
                        Int16 xCoord = Convert.ToInt16(left + Math.Round(i * (right - left) / r) - 1);
                        g.DrawLine(p, new Point(xCoord, bottom), new Point(xCoord, bottom + 10));
                        Double xVal = minX + i * (maxX - minX) / tickCount;
                        panel1XLabels[i].Location = new Point(xCoord - 20, bottom + 15);
                        panel1XLabels[i].Text = string.Format("{0:F1}", xVal);
                    }
                }

            }
        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {
            base.OnPaint(e);
            using (Graphics g = e.Graphics)
            {
                // TODO a bit of manual pixel adjustments in this function

                int top = ReferenceImage.Location.Y;
                int bottom = ReferenceImage.Location.Y + BeamformedImage.ClientRectangle.Bottom;
                int right = ReferenceImage.Location.X + BeamformedImage.ClientRectangle.Right;
                int left = ReferenceImage.Location.X;

                // Axes
                Pen p = new Pen(Color.Black, 2);
                g.DrawLine(p, left, top, left, bottom);
                g.DrawLine(p, left, bottom, right, bottom);
                p = new Pen(Color.Black, 1);

                // Calibrate the tick count so that we have ~1 per cm along the Z axis of the image
                // (nice round number if r is integer, else with decimals)
                UInt16 tickCount = Convert.ToUInt16(Math.Floor(r));

                if (viewCounter == View.XZViewFirst || viewCounter == View.YZViewFirst)
                {
                    // Ticks on Y axis of the figure
                    Double minY = 0; // TODO we don't support shallow trimming yet.
                    Double maxY = r;
                    for (UInt16 i = 0; i <= tickCount; i++)
                    {
                        Int16 yCoord = Convert.ToInt16(top + Math.Round(i * (bottom - top) / r));
                        g.DrawLine(p, new Point(left - 10, yCoord), new Point(left, yCoord));
                        Double yVal = minY + i * (maxY - minY) / tickCount;
                        panel2YLabels[i].Location = new Point(left - 50, yCoord - 10);
                        panel2YLabels[i].Text = string.Format("{0:F1}", yVal);
                    }

                    // Ticks on X axis of the figure
                    Double xSpan = (maxY - minY) * ReferenceImage.Width / ReferenceImage.Height;
                    Double minX = -xSpan / 2;
                    Double maxX = xSpan / 2;
                    for (UInt16 i = 0; i <= tickCount; i++)
                    {
                        Int16 xCoord = Convert.ToInt16(left + Math.Round(i * (right - left) / r) - 1);
                        g.DrawLine(p, new Point(xCoord, bottom), new Point(xCoord, bottom + 10));
                        Double xVal = minX + i * (maxX - minX) / tickCount;
                        panel2XLabels[i].Location = new Point(xCoord - 20, bottom + 15);
                        panel2XLabels[i].Text = string.Format("{0:F1}", xVal);
                    }
                }
                else // viewCounter == View.XYViewFirst
                {
                    // Ticks on Y axis of the figure
                    // In this view, the vertical axis of the image covers the same range that was
                    // spanned along the horizontal axis of the other views.
                    Double minY = 0;
                    Double maxY = r * ReferenceImage.Width / ReferenceImage.Height;
                    for (UInt16 i = 0; i <= tickCount; i++)
                    {
                        Int16 yCoord = Convert.ToInt16(top + Math.Round(i * (bottom - top) / r));
                        g.DrawLine(p, new Point(left - 10, yCoord), new Point(left, yCoord));
                        Double yVal = minY + i * (maxY - minY) / tickCount;
                        panel2YLabels[i].Location = new Point(left - 50, yCoord - 10);
                        panel2YLabels[i].Text = string.Format("{0:F1}", yVal);
                    }

                    // Ticks on X axis of the figure
                    Double xSpan = (maxY - minY) * BeamformedImage.Width / BeamformedImage.Height;
                    Double minX = -xSpan / 2;
                    Double maxX = xSpan / 2;
                    for (UInt16 i = 0; i <= tickCount; i++)
                    {
                        Int16 xCoord = Convert.ToInt16(left + Math.Round(i * (right - left) / r) - 1);
                        g.DrawLine(p, new Point(xCoord, bottom), new Point(xCoord, bottom + 10));
                        Double xVal = minX + i * (maxX - minX) / tickCount;
                        panel2XLabels[i].Location = new Point(xCoord - 20, bottom + 15);
                        panel2XLabels[i].Text = string.Format("{0:F1}", xVal);
                    }
                }
            }
        }

        private void FixedPointCheckBox_CheckedChanged(object sender, EventArgs e)
        {
        }

        private void DelayApproximationCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            LoadReferenceImages();

            refreshUI();
        }

        private void ApodizationCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            LoadReferenceImages();

            refreshUI();
        }

        private void SaveReferenceBitmaps(String path)
        {
            try
            {
                referenceImageXY.Save(path.Replace(Path.GetFileName(path), Path.GetFileNameWithoutExtension(path) + "_XY.bmp"));
                referenceImageXZ.Save(path.Replace(Path.GetFileName(path), Path.GetFileNameWithoutExtension(path) + "_XZ.bmp"));
                referenceImageYZ.Save(path.Replace(Path.GetFileName(path), Path.GetFileNameWithoutExtension(path) + "_YZ.bmp"));
            }
            catch
            {
                // Probably the file exists already.
            }
        }

        private void ZoneChooser_SelectedValueChanged(object sender, EventArgs e)
        {
            refreshUI();
        }

        private void CompoundChooser_SelectedValueChanged(object sender, EventArgs e)
        {
            refreshUI();
        }

        private void PhantomChooser_SelectedValueChanged(object sender, EventArgs e)
        {
            if (tcpclient.IsOpened)
            {
                StartMicroblazeButton.Enabled = true;
                StartStreamingButton.Enabled = true;
                StartListenButton.Enabled = true;
                StartListenForeverButton.Enabled = true;
                // Disabled because we need to run a full reconstruction first
                ReScanConvertButton.Enabled = false;
            }
            if (TestMode)
                StartMicroblazeButton.Enabled = true;
            SelectedPhantom = PhantomChooser.Text;
            PhantomFolderPath = Path.Combine(DataFolderPath, SelectedPhantom) + Path.DirectorySeparatorChar;
            string[] folderEntries = Directory.GetDirectories(PhantomFolderPath);
            int value;
            // TODO some of this stuff should be in RefreshUI()
            ZoneChooser.Enabled = true;
            ZoneChooser.Items.Clear();
            ZoneChooser.Items.Add("1");
            CompoundChooser.Enabled = true;
            CompoundChooser.Items.Clear();
            CompoundChooser.Items.Add("1");
            foreach (string folderName in folderEntries)
            {
                if (folderName.IndexOf("zone") != -1)
                {
                    int.TryParse(folderName.Substring(folderName.LastIndexOf('_') + 1), out value);
                    if (value != 1)
                        ZoneChooser.Items.Add(value.ToString());
                }
                else if (folderName.IndexOf("compounding") != -1)
                {
                    int.TryParse(folderName.Substring(folderName.LastIndexOf('_') + 1), out value);
                    if (value != 1)
                        CompoundChooser.Items.Add(value.ToString());
                }
            }
            ZoneChooser.SelectedIndex = 0;
            CompoundChooser.SelectedIndex = 0;
            LogCompression.Value = 45;   // In dB
            Brightness.Value = 0;        // In dB, 0 = auto brightness

            // Find out the file paths for all other files to be used in the GUI
            // (Done here else touching the checkboxes will crash as there is no image path).
            preSCImagePath = Path.Combine(DataFolderPath, SelectedPhantom, SelectedRunType) + Path.DirectorySeparatorChar + SelectedPhantom + "_bf.mat";
            referenceExactDynamicImagePath = preSCImagePath.Replace("_bf", "_bf_sc_exact_dynamic");
            referenceSteeredDynamicImagePath = preSCImagePath.Replace("_bf", "_bf_sc_steered_dynamic");
            referenceExactStaticImagePath = preSCImagePath.Replace("_bf", "_bf_sc_exact_static");
            referenceSteeredStaticImagePath = preSCImagePath.Replace("_bf", "_bf_sc_steered_static");
            // These cannot be enabled at boot, else clicking them (before a phantom is selected) will just crash
            FixedPointCheckBox.Enabled = false; // TODO we have no comparison images for this one.
            DelayApproximationCheckBox.Enabled = true;
            StaticApodizationCheckBox.Enabled = true;

            refreshUI();
        }

        private void InitializeStart()
        {
            // Can't click too fast twice in a row.
            StartMicroblazeButton.Enabled = false;
            StartStreamingButton.Enabled = false;
            StartListenButton.Enabled = false;
            StartListenForeverButton.Enabled = false;
            ReScanConvertButton.Enabled = false;

            if (CompoundChooser.SelectedIndex > 0)
                SelectedRunType = "compounding_" + CompoundChooser.SelectedItem.ToString();
            else
                SelectedRunType = "zone_" + ZoneChooser.SelectedItem.ToString();
            // TODO this is clunky. May be better to permanently add a hidden entry "LightProbe" to the phantom selector, and
            // just pick it from here, thus triggering the phantom selector event
            if (CoordMode == COORD_MODE.COORD_UBLZ || CoordMode == COORD_MODE.COORD_STREAMING)
            {
                // Refresh this choice because, if switching modes, the value of the dropdown might have been overridden by "LightProbe"
                SelectedPhantom = PhantomChooser.Text;

                // Find out the file paths for all other files to be used in the GUI
                preSCImagePath = Path.Combine(DataFolderPath, SelectedPhantom, SelectedRunType) + Path.DirectorySeparatorChar + SelectedPhantom + "_bf.mat";
                referenceExactDynamicImagePath = preSCImagePath.Replace("_bf", "_bf_sc_exact_dynamic");
                referenceSteeredDynamicImagePath = preSCImagePath.Replace("_bf", "_bf_sc_steered_dynamic");
                referenceExactStaticImagePath = preSCImagePath.Replace("_bf", "_bf_sc_exact_static");
                referenceSteeredStaticImagePath = preSCImagePath.Replace("_bf", "_bf_sc_steered_static");

                // Load reference images
                // Do this before loading the next image, as we will need the reference brightness values from this load
                // to adjust the log compression of the next.
                LoadReferenceImages();
            }
            else if (CoordMode == COORD_MODE.COORD_LISTEN || CoordMode == COORD_MODE.COORD_LISTEN_FOREVER)
            {
                SelectedPhantom = "LightProbe";
            }
            PhantomFolderPath = Path.Combine(DataFolderPath, SelectedPhantom) + Path.DirectorySeparatorChar;
            RunFolderPath = Path.Combine(DataFolderPath, SelectedPhantom, SelectedRunType);
            NappeFolderPath = Path.Combine(new string[] { DataFolderPath, SelectedPhantom, SelectedRunType, "fpga_nappes"}) + Path.DirectorySeparatorChar.ToString();
            // This might happen for the "LightProbe" case only
            if (!Directory.Exists(PhantomFolderPath))
                Directory.CreateDirectory(PhantomFolderPath);
            if (!Directory.Exists(RunFolderPath))
                Directory.CreateDirectory(RunFolderPath);
            // This can happen for any phantom
            if (!Directory.Exists(NappeFolderPath))
                Directory.CreateDirectory(NappeFolderPath);
        }

        private void FinalizeStart()
        {
            nappeIndex = 1;

            preSCImage = new VirtualScopeNS.Components.CPreScanConvertImage(radialLines, azimuthLines, elevationLines);
            postSCImage = new VirtualScopeNS.Components.CPostScanConvertImage(scanConvertedImageWidth, scanConvertedImageHeight, 1);

            // These lines tell the board how many zones/compound images we are using
            // Send as ASCII characters to make decoding easier for Microblaze
            // This command triggers the whole GUI / FPGA state machine lockstep.
            // The progress of the communication will be tracked in the DataReceivedEvent code,
            // and upon completion, that code will also display outputs.
            ProgressLabel.Text = "Communicating with the FPGA board...";
            int.TryParse(ZoneChooser.SelectedItem.ToString(), out zoneCount);
            int.TryParse(CompoundChooser.SelectedItem.ToString(), out compoundCount);
            runCount = compoundCount * zoneCount;
            runIndex = 0;

            progressBar.Value = 0;
            progressBar.Step = 1;
            progressBar.Visible = true;
            progressBar.Minimum = 0;
            // Multiple increments per nappe (one for each send RF run and one for receive), plus 1 increment for scan conversion
            progressBar.Maximum = (int)radialLines * (runCount + 1) + 1;
            progressBar.Refresh();
            string progressString = "Sending Options";
            Font progressFont = new Font("Arial", (float)12, FontStyle.Bold);
            using (Graphics gr = progressBar.CreateGraphics())
            {
                gr.DrawString(progressString, progressFont, Brushes.Black, new PointF(progressBar.Width / 2 - (gr.MeasureString(progressString, progressFont).Width / 2.0F),
                                                                                      progressBar.Height / 2 - (gr.MeasureString(progressString, progressFont).Height / 2.0F)));
            }
            stopWatch.Start();

            // TODO max 99x99 zones, 99-compound; make this cleaner/more configurable
            int elevationZoneCount;
            if (elevationLines == 1)
                elevationZoneCount = 1;
            else
            {
                zoneCount = (int)Math.Sqrt(zoneCount);
                elevationZoneCount = zoneCount;
            }
            string options = zoneCount.ToString().PadLeft(2, '0') + "x" + elevationZoneCount.ToString().PadLeft(2, '0') + "_" + compoundCount.ToString().PadLeft(2, '0') + "_" + (CompoundOp.SelectedIndex + 1).ToString() + "#";
            tcpclient.Send(options);
            
            // And now wait for a response from the board in the CONNECTED state of the FSM above, at which point 
            // we will move to the next stages.
        }

        private void StartMicroblazeButton_Click(object sender, EventArgs e)
        {
            changeCoordMode(COORD_MODE.COORD_UBLZ);
            InitializeStart();

            // Load beamformed, non-scan-converted image
            // TODO the code in this branch assumes 3D and won't work in 2D.
            if (TestMode == true)
            {
                ProgressLabel.Text = "Loading via Matlab...";

                // Create the MATLAB instance
                MLApp.MLApp matlab = new MLApp.MLApp();

                // Load image from disk
                matlab.Execute(string.Format("file = load('{0}');", preSCImagePath));
                matlab.Execute(string.Format("bf_im = file.bf_im;"));
                var bf_im = (double[,,])matlab.GetVariable("bf_im", "base");
                // Quit Matlab
                matlab.Quit();

                //Debug.WriteLine("ndims(bf_im) = {0}, numel(bf_im) = {1}", bf_im.Rank, bf_im.Length);

                ProgressLabel.Text = "Scan converting...";

                Int32 midX = Convert.ToInt32(scanConverter.WidthAfterScanConversion(preSCImage.GetSizeX(), theta * 2.0 * Math.PI / 360.0) / 2);
                Int32 midY = Convert.ToInt32(scanConverter.HeightAfterScanConversion(preSCImage.GetSizeX(), phi * 2.0 * Math.PI / 360.0) / 2);
                Int32 midZ = Convert.ToInt32(preSCImage.GetSizeX() / 2);

                // The value in dB must be converted into an absolute voxel brightness value;
                // the dB input has a range [1, 192] (== 32-bit dynamic range)
                // To achieve a bright image, we need to pass a small value,
                // so the exponent is taken with inverted sign
                // +20 dB => 10 times smaller reference voxel intensity; 
                Double referenceMaxVoxel;
                if (Brightness.Value == 0)
                    referenceMaxVoxel = 0.0;
                else
                    referenceMaxVoxel = Math.Pow(10.0, (193.0 - (double)Brightness.Value) / 20.0);

                postSCImageXY = scanConverter.ScanConvertBitmap(preSCImage, preSCImage.GetSizeX(), theta * 2.0 * Math.PI / 360.0, phi * 2.0 * Math.PI / 360.0, r, true, -1, -1, midZ, (UInt32)LogCompression.Value, referenceMaxVoxel);
                postSCImageXZ = scanConverter.ScanConvertBitmap(preSCImage, preSCImage.GetSizeX(), theta * 2.0 * Math.PI / 360.0, phi * 2.0 * Math.PI / 360.0, r, true, -1, midY, -1, (UInt32)LogCompression.Value, referenceMaxVoxel);
                postSCImageYZ = scanConverter.ScanConvertBitmap(preSCImage, preSCImage.GetSizeX(), theta * 2.0 * Math.PI / 360.0, phi * 2.0 * Math.PI / 360.0, r, true, midX, -1, -1, (UInt32)LogCompression.Value, referenceMaxVoxel);
                
                ProgressLabel.Text = "Plotting...";

                drawPlots();

                ProgressLabel.Text = "";

                StartMicroblazeButton.Enabled = true;
                StartStreamingButton.Enabled = true;
                StartListenButton.Enabled = true;
                StartListenForeverButton.Enabled = true;
                ReScanConvertButton.Enabled = true;
            }
            else
            {
                // Must be in the FPGA_CONNECTED state as we have to communicate with the board
                Debug.Assert(FPGAState == FPGA_FSM.FPGA_CONNECTED);

                string[] filenames = System.IO.Directory.GetFiles(PhantomFolderPath + SelectedRunType + Path.DirectorySeparatorChar, SelectedPhantom + "_rfa_*.txt");
                List<string> tmp_filenames = new List<string>(filenames);
                filenames = tmp_filenames.ToArray();
                nappesRequiringNewRFData = new UInt16[filenames.Length];
                for (int i = 0; i < filenames.Length; i = i + 1)
                    UInt16.TryParse(filenames[i].Substring(filenames[i].IndexOf("rfa_") + 4, 3), out nappesRequiringNewRFData[i]);
                // Uniquify the array (will contain multiple entries of the same index when doing zone/compound imaging)
                // Easiest way is to copy everything in a temporary List which features the method Contains
                List<UInt16> tmpList = new List<UInt16>();
                foreach (UInt16 val in nappesRequiringNewRFData)
                    // The special file with index "000" is only for streaming mode.
                    if (!tmpList.Contains(val) && val != 0)
                        tmpList.Add(val);
                nappesRequiringNewRFData = (UInt16[])tmpList.ToArray();
                Array.Sort(nappesRequiringNewRFData);

                FinalizeStart();
            }
        }

        private void HWSCCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            if (HWSCCheckBox.Checked)
                HWSWSCString = "HWSC ";
            else
                HWSWSCString = "SWSC ";
        }

        private void scanConvertedImageHeightNumericUpDown_ValueChanged(object sender, EventArgs e)
        {
            scanConvertedImageHeight = (UInt32)scanConvertedImageHeightNumericUpDown.Value;
            refreshUI(true);
        }

        private void StartStreamingButton_Click(object sender, EventArgs e)
        {
            changeCoordMode(COORD_MODE.COORD_STREAMING);
            InitializeStart();

            // Must be in the FPGA_CONNECTED state as we have to communicate with the board
            Debug.Assert(FPGAState == FPGA_FSM.FPGA_CONNECTED);

            // Locate the nappes we need to send RF data for
            nappesRequiringNewRFData = new UInt16[1];
            nappesRequiringNewRFData[0] = (ushort)(radialLines + 1);

            FinalizeStart();
        }

        private void StartListenButton_Click(object sender, EventArgs e)
        {
            changeCoordMode(COORD_MODE.COORD_LISTEN);
            InitializeStart();

            // Must be in the FPGA_CONNECTED state as we have to communicate with the board
            Debug.Assert(FPGAState == FPGA_FSM.FPGA_CONNECTED);

            FinalizeStart();
        }

        private void StartListenForeverButton_Click(object sender, EventArgs e)
        {
            changeCoordMode(COORD_MODE.COORD_LISTEN_FOREVER);
            InitializeStart();

            // Must be in the FPGA_CONNECTED state as we have to communicate with the board
            Debug.Assert(FPGAState == FPGA_FSM.FPGA_CONNECTED);

            FinalizeStart();
        }

        private void ReScanConvertButton_Click(object sender, EventArgs e)
        {
            // TODO if SW SC, just update the images in the GUI.

            changeCoordMode(COORD_MODE.COORD_RE_SCANCONVERT);

            // Can't click on these if re-scanconverting.
            StartMicroblazeButton.Enabled = false;
            StartStreamingButton.Enabled = false;
            StartListenButton.Enabled = false;
            StartListenForeverButton.Enabled = false;
            ReScanConvertButton.Enabled = false;

            // Must be in the FPGA_CONNECTED state as we have to communicate with the board
            Debug.Assert(FPGAState == FPGA_FSM.FPGA_CONNECTED);

            // These lines tell the board to re-scan-convert.
            // Send as ASCII characters to make decoding easier for Microblaze
            // This command triggers a GUI / FPGA state machine lockstep.
            // The progress of the communication will be tracked in the DataReceivedEvent code,
            // and upon completion, that code will also display outputs.
            ProgressLabel.Text = "Communicating with the FPGA board...";

            progressBar.Value = 0;
            progressBar.Step = 1;
            progressBar.Visible = true;
            progressBar.Minimum = 0;
            progressBar.Refresh();

            string progressString = "Scan-Converting...";
            Font progressFont = new Font("Arial", (float)12, FontStyle.Bold);
            using (Graphics gr = progressBar.CreateGraphics())
            {
                gr.DrawString(progressString, progressFont, Brushes.Black, new PointF(progressBar.Width / 2 - (gr.MeasureString(progressString, progressFont).Width / 2.0F),
                                                                                      progressBar.Height / 2 - (gr.MeasureString(progressString, progressFont).Height / 2.0F)));
            }
            stopWatch.Start();

            string options = "resc$";
            tcpclient.Send(options);
            // And now wait for a response from the board in the CONNECTED state of the FSM above, at which point 
            // we will move to the next stages.
        }

        private void LoadReferenceImages()
        {
            string ReferencePath;
            string ReferenceBitmapPathXY, ReferenceBitmapPathXZ, ReferenceBitmapPathYZ;
            if (StaticApodizationCheckBox.Checked == true && DelayApproximationCheckBox.Checked == true)
            {
                ReferencePath = referenceSteeredStaticImagePath;
            }
            else if (StaticApodizationCheckBox.Checked == true && DelayApproximationCheckBox.Checked == false)
            {
                ReferencePath = referenceExactStaticImagePath;
            }
            else if (StaticApodizationCheckBox.Checked == false && DelayApproximationCheckBox.Checked == true)
            {
                ReferencePath = referenceSteeredDynamicImagePath;
            }
            else // (StaticApodizationCheckBox.Checked == false && DelayApproximationCheckBox.Checked == false)
            {
                ReferencePath = referenceExactDynamicImagePath;
            }
            // First try to see if it is possible to load cached bitmaps from disk
            ReferenceBitmapPathXY = ReferencePath.Replace(Path.GetFileName(ReferencePath), Path.GetFileNameWithoutExtension(ReferencePath) + "_XY.bmp");
            ReferenceBitmapPathXZ = ReferencePath.Replace(Path.GetFileName(ReferencePath), Path.GetFileNameWithoutExtension(ReferencePath) + "_XZ.bmp");
            ReferenceBitmapPathYZ = ReferencePath.Replace(Path.GetFileName(ReferencePath), Path.GetFileNameWithoutExtension(ReferencePath) + "_YZ.bmp");
            if (File.Exists(ReferenceBitmapPathXY) && File.Exists(ReferenceBitmapPathXZ) && File.Exists(ReferenceBitmapPathYZ))
            {
                referenceImageXY = new Bitmap(ReferenceBitmapPathXY);
                referenceImageXZ = new Bitmap(ReferenceBitmapPathXZ);
                referenceImageYZ = new Bitmap(ReferenceBitmapPathYZ);
            }
            // If not, load the whole thing from Matlab
            else
            {
                ProgressLabel.Text = "Loading via Matlab...";

                // Create the MATLAB instance 
                MLApp.MLApp matlab = new MLApp.MLApp();
                matlab.Execute(string.Format("file = load('{0}');", ReferencePath));
                matlab.Execute(string.Format("sc_im = file.im_log_rescaled;"));
                matlab.Execute(string.Format("[X, Y, Z] = size(sc_im);"));

                var Z = matlab.GetVariable("Z", "base");
                
                // 3D image
                if (Z > 1)
                {
                    matlab.Execute(string.Format("XY_cut = squeeze(sc_im(:, :, round(Z / 2)));"));
                    var XY_cut = (double[,])matlab.GetVariable("XY_cut", "base");
                    matlab.Execute(string.Format("clear XY_cut;")); // Save memory, these may be huge

                    matlab.Execute(string.Format("XZ_cut = squeeze(sc_im(:, round(Y / 2), :));"));
                    var XZ_cut = (double[,])matlab.GetVariable("XZ_cut", "base");
                    matlab.Execute(string.Format("clear XZ_cut;")); // Save memory, these may be huge

                    matlab.Execute(string.Format("YZ_cut = squeeze(sc_im(round(X / 2), :, :));"));
                    var YZ_cut = (double[,])matlab.GetVariable("YZ_cut", "base");
                    matlab.Execute(string.Format("clear YZ_cut;")); // Save memory, these may be huge

                    referenceImageXY = scanConverter.imageSliceToBitmap(XY_cut);
                    referenceImageXZ = scanConverter.imageSliceToBitmap(XZ_cut);
                    referenceImageYZ = scanConverter.imageSliceToBitmap(YZ_cut);
                }
                else
                {
                    matlab.Execute(string.Format("XY_cut = zeros(Y, Y);"));
                    var XY_cut = (double[,])matlab.GetVariable("XY_cut", "base");
                    matlab.Execute(string.Format("clear XY_cut;")); // Save memory, these may be huge

                    matlab.Execute(string.Format("XZ_cut = sc_im';"));
                    var XZ_cut = (double[,])matlab.GetVariable("XZ_cut", "base");
                    matlab.Execute(string.Format("clear XZ_cut;")); // Save memory, these may be huge

                    matlab.Execute(string.Format("YZ_cut = zeros(Y, X);"));
                    var YZ_cut = (double[,])matlab.GetVariable("YZ_cut", "base");
                    matlab.Execute(string.Format("clear YZ_cut;")); // Save memory, these may be huge

                    referenceImageXY = scanConverter.imageSliceToBitmap(XY_cut);
                    referenceImageXZ = scanConverter.imageSliceToBitmap(XZ_cut);
                    referenceImageYZ = scanConverter.imageSliceToBitmap(YZ_cut);
                }

                matlab.Quit();

                ProgressLabel.Text = "";
            }

            // Cache to disk for next invocation
            if (StaticApodizationCheckBox.Checked == true && DelayApproximationCheckBox.Checked == true)
            {
                SaveReferenceBitmaps(referenceSteeredStaticImagePath);
            }
            else if (StaticApodizationCheckBox.Checked == true && DelayApproximationCheckBox.Checked == false)
            {
                SaveReferenceBitmaps(referenceExactStaticImagePath);
            }
            else if (StaticApodizationCheckBox.Checked == false && DelayApproximationCheckBox.Checked == true)
            {
                SaveReferenceBitmaps(referenceSteeredDynamicImagePath);
            }
            else // (StaticApodizationCheckBox.Checked == false && DelayApproximationCheckBox.Checked == false)
            {
                SaveReferenceBitmaps(referenceExactDynamicImagePath);
            }
        }
    }
}