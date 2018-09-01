-- ***************************************************************************
-- ***************************************************************************
--  Copyright (C) 2014-2018  EPFL
--  "BeamformerIP" custom IP
--
--   Permission is hereby granted, free of charge, to any person
--   obtaining a copy of this software and associated documentation
--   files (the "Software"), to deal in the Software without
--   restriction, including without limitation the rights to use,
--   copy, modify, merge, publish, distribute, sublicense, and/or sell
--   copies of the Software, and to permit persons to whom the
--   Software is furnished to do so, subject to the following
--   conditions:
--
--   The above copyright notice and this permission notice shall be
--   included in all copies or substantial portions of the Software.
--
--   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
--   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
--   OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
--   NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
--   HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
--   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
--   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
--   OTHER DEALINGS IN THE SOFTWARE.
-- ***************************************************************************
-- ***************************************************************************
-- ***************************************************************************
-- ***************************************************************************

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/02/2016 11:32:51 AM
-- Design Name: 
-- Module Name: delay_calculator - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.types_pkg.all;
use WORK.y_constants.all;
use WORK.x_constants.all;
use WORK.nt_constants.all;
use WORK.offset_constants.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ref_delay_calculator is
    Generic (
            TRANSDUCER_ELEMENTS_X : integer := 32;
            TRANSDUCER_ELEMENTS_Y : integer := 32
            );
    Port (
            clk     :   in  std_logic;
            rst_n     :   in  std_logic;

            inp_rdy :   in  std_logic;              -- Tells the ref_delay_calculator to start generating reference delays from the x,y and nappe inputs
            out_rdy :   out std_logic;              -- Indicates the validity of the output

            nt_cnt      :   in  integer range 0 to NO_DEPTH-1 := 0;                 -- Nappe we are calculating ref delay for
            x_cnt       :   in  integer range 0 to TRANSDUCER_ELEMENTS_X-1 := 0;    -- x_cnt and y_cnt are the coordinates of the element to calculate delays for
            y_cnt       :   in  integer range 0 to TRANSDUCER_ELEMENTS_Y-1 := 0;
            
            streaming_not_fixed : in std_logic;     -- If 1: data is coming in a streaming fashion (use only the offset delay from the ZERO_OFFSET_REG)
                                                    -- If 0: data is coming in packets of BRAM_SAMPLES_PER_NAPPE, use a precomputed offset table from Matlab 
            ref_delay   :  out  unsigned(17 downto 0);          -- Reference delay for the current element
            zero_offset   : in signed(13 downto 0)              -- zero offset in the input samples (at which time the first sample comes)
             );
end ref_delay_calculator;

architecture Behavioral of ref_delay_calculator is

-- cordic IP used for the square root
component sqrt_cordic is
    port(
        clk        :   in  std_logic;
        rst_n      :   in  std_logic;
        enable     :   in  std_logic;
        start      :   in  std_logic;
        data_valid :   out std_logic;

        input   :   in  unsigned(35 downto 0);
        output  :   out unsigned(17 downto 0)
    );
end component;

constant    w       :   unsigned(17 downto 0) := "00"&x"1BAE";                  --442.9
constant    h       :   unsigned(17 downto 0) := "00"&x"1BAE";                  --442.9

signal      sqr_and_sum :   unsigned(35 downto 0);                              -- input to the cordic
signal      sqrt_res    :   unsigned(17 downto 0);                              -- output of the cordic
signal      start       :   std_logic       :=  '0';                            -- start performing square root
signal      data_valid  :   std_logic       :=  '0';                            -- data from the cordic is valid
signal      reset_delay :   std_logic       :=  '0';                            -- used for timing of the ref delay calculator
begin

sqrt_cordic_int1: sqrt_cordic
port map(
        clk     =>  clk,
        rst_n   =>  rst_n,
        enable  =>  inp_rdy,
        start   =>  start,
        data_valid  =>  data_valid,
        input   =>  sqr_and_sum,
        output  =>  sqrt_res
    );

-- this process prepares the input to the cordic (one input per transducer element). The counters help to get the correct inputs from the arrays generated
-- by Matlab.
-- The reference delays are then outputted.
-- For information on the mathematics of the ref_delay_calculator, see Ahmed's paper :)
-- TODO since the reference RX delays are always symmetrical, can cut computation time and storage in two (2D) / four (3D)
process (clk)
variable      Tx  :   unsigned(17 downto 0);
begin
    if rising_edge(clk) then
        if rst_n = '0' then
            sqr_and_sum <= (others => '0');
            out_rdy <= '0';
            reset_delay <= '0';
        else
            if inp_rdy = '1' then
                Tx  :=  nt(nt_cnt) / 2;
                sqr_and_sum <=  Tx*Tx + x(x_cnt) + y(y_cnt);
                start   <=  '1';
            else
                start   <=  '0';
            end if;
            if reset_delay = '0' then
                reset_delay <= '1';
            end if;
            if reset_delay = '1' and data_valid = '1' then
                if streaming_not_fixed = '1' then
                    ref_delay <= unsigned(signed(sqrt_res) + signed(excitation_peak_time) - shift_left(zero_offset, 4) - "000000000000010000");
                else
                    ref_delay <= sqrt_res + excitation_peak_time - offset(nt_cnt) - "000000000000010000";
                end if;
                out_rdy <=  '1';
            else
                out_rdy <=  '0';
            end if;
        end if;
    end if;
end process;

end Behavioral;
