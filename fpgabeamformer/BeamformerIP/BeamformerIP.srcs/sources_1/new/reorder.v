// ***************************************************************************
// ***************************************************************************
//  Copyright (C) 2014-2018  EPFL
//  "BeamformerIP" custom IP
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

reg [9 : 0] chan_phy_order [0 : 63] = {10'd17, 10'd2,  10'd6,  10'd10, 10'd14, 10'd37, 10'd33, 10'd29,
                                       10'd25, 10'd21, 10'd50, 10'd54, 10'd58, 10'd62, 10'd45, 10'd41,
                                       10'd19, 10'd0,  10'd4,  10'd8,  10'd12, 10'd39, 10'd35, 10'd31,
                                       10'd27, 10'd23, 10'd48, 10'd52, 10'd56, 10'd60, 10'd47, 10'd43,
                                       10'd16, 10'd3,  10'd7,  10'd11, 10'd15, 10'd36, 10'd32, 10'd28,
                                       10'd24, 10'd20, 10'd51, 10'd55, 10'd59, 10'd63, 10'd44, 10'd40,
                                       10'd18, 10'd1,  10'd5,  10'd9,  10'd13, 10'd38, 10'd34, 10'd30,
                                       10'd26, 10'd22, 10'd49, 10'd53, 10'd57, 10'd61, 10'd46, 10'd42};

//reg [9 : 0] chan_phy_order [0 : 63] = {10'd42, 10'd46, 10'd61, 10'd57, 10'd53, 10'd49, 10'd22, 10'd26,
//                                       10'd30, 10'd34, 10'd38, 10'd13, 10'd9,  10'd5,  10'd1,  10'd18,
//                                       10'd40, 10'd44, 10'd63, 10'd59, 10'd55, 10'd51, 10'd20, 10'd24,
//                                       10'd28, 10'd32, 10'd36, 10'd15, 10'd11, 10'd7,  10'd3,  10'd16,
//                                       10'd43, 10'd47, 10'd60, 10'd56, 10'd52, 10'd48, 10'd23, 10'd27,
//                                       10'd31, 10'd35, 10'd39, 10'd12, 10'd8,  10'd4,  10'd0,  10'd19,
//                                       10'd41, 10'd45, 10'd62, 10'd58, 10'd54, 10'd50, 10'd21, 10'd25,
//                                       10'd29, 10'd33, 10'd37, 10'd14, 10'd10, 10'd6,  10'd2,  10'd17};
