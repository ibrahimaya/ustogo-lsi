// ***************************************************************************
// ***************************************************************************
//  Copyright (C) 2014-2018  EPFL
//  "ScanConverterIP" custom IP.
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

`timescale 1 ns / 1 ps

//  Xilinx True Dual Port RAM, Write First with Single Clock
//  This code implements a parameterizable true dual port memory (both ports can read and write).
//  This implements write-first mode where the data being written to the RAM also resides on
//  the output port.  If the output data is not needed during writes or the last read value is
//  desired to be retained, it is suggested to use no change as it is more power efficient.
//  If a reset or enable is not necessary, it may be tied off or removed from the code.

module dp_bram #(
                    parameter RAM_WIDTH = 18,                       // Specify RAM data width
                    parameter RAM_DEPTH = 1024,                     // Specify RAM depth (number of entries)
                    parameter RAM_PERFORMANCE = "HIGH_PERFORMANCE", // Select "HIGH_PERFORMANCE" or "LOW_LATENCY" 
                    parameter INIT_FILE = ""                        // Specify name/location of RAM initialization file if using one (leave blank if not)
               )
               (
                    input [clogb2(RAM_DEPTH - 1) - 1 : 0] addra,  // Port A address bus, width determined from RAM_DEPTH
                    input [clogb2(RAM_DEPTH - 1) - 1 : 0] addrb,  // Port B address bus, width determined from RAM_DEPTH
                    input [RAM_WIDTH - 1 : 0] dina,               // Port A RAM input data
                    input [RAM_WIDTH - 1 : 0] dinb,               // Port B RAM input data
                    input clka,                                   // Clock
                    input wea,                                    // Port A write enable
                    input web,                                    // Port B write enable
                    input ena,                                    // Port A RAM Enable, for additional power savings, disable port when not in use
                    input enb,                                    // Port B RAM Enable, for additional power savings, disable port when not in use
                    input rsta,                                   // Port A output reset (does not affect memory contents)
                    input rstb,                                   // Port B output reset (does not affect memory contents)
                    input regcea,                                 // Port A output register enable
                    input regceb,                                 // Port B output register enable
                    output [RAM_WIDTH - 1 : 0] douta,             // Port A RAM output data
                    output [RAM_WIDTH - 1 : 0] doutb              // Port B RAM output data
               );

    reg [RAM_WIDTH - 1 : 0] BRAM [RAM_DEPTH-1:0];
    reg [RAM_WIDTH - 1 : 0] ram_data_a = {RAM_WIDTH{1'b0}};
    reg [RAM_WIDTH - 1 : 0] ram_data_b = {RAM_WIDTH{1'b0}};

    // The following code either initializes the memory values to a specified file or to all zeros to match hardware
    generate
        if (INIT_FILE != "")
        begin: use_init_file
            initial
                $readmemb(INIT_FILE, BRAM, 0, RAM_DEPTH - 1);
        end
        else
        begin: init_bram_to_zero
            integer ram_index;
            initial
                for (ram_index = 0; ram_index < RAM_DEPTH; ram_index = ram_index + 1)
                    BRAM[ram_index] = {RAM_WIDTH{1'b0}};
        end
    endgenerate

    always @(posedge clka)
    if (ena)
        if (wea)
        begin
            BRAM[addra] <= dina;
            ram_data_a <= dina;
        end
        else
            ram_data_a <= BRAM[addra];

    always @(posedge clka)
    if (enb)
        if (web)
        begin
            BRAM[addrb] <= dinb;
            ram_data_b <= dinb;
        end
        else
            ram_data_b <= BRAM[addrb];

    // The following code generates HIGH_PERFORMANCE (use output register) or LOW_LATENCY (no output register)
    generate
        if (RAM_PERFORMANCE == "LOW_LATENCY")
        begin: no_output_register
            // The following is a 1 clock cycle read latency at the cost of a longer clock-to-out timing
            assign douta = ram_data_a;
            assign doutb = ram_data_b;
        end
        else
        begin: output_register
            // The following is a 2 clock cycle read latency with improve clock-to-out timing
            reg [RAM_WIDTH - 1 : 0] douta_reg = {RAM_WIDTH{1'b0}};
            reg [RAM_WIDTH - 1 : 0] doutb_reg = {RAM_WIDTH{1'b0}};
            always @(posedge clka)
            if (rsta == 1'b0)
                douta_reg <= {RAM_WIDTH{1'b0}};
            else if (regcea)
                douta_reg <= ram_data_a;

            always @(posedge clka)
            if (rstb == 1'b0)
                doutb_reg <= {RAM_WIDTH{1'b0}};
            else if (regceb)
                doutb_reg <= ram_data_b;

            assign douta = douta_reg;
            assign doutb = doutb_reg;
        end
    endgenerate

    // The following function calculates the address width based on specified RAM depth
    function integer clogb2;
        input integer depth;
        for (clogb2 = 0; depth > 0; clogb2 = clogb2 + 1)
            depth = depth >> 1;
    endfunction

endmodule
