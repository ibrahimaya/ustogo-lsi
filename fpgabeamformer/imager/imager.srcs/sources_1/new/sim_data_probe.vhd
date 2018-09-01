-- ***************************************************************************
-- ***************************************************************************
--  Copyright (C) 2014-2018  EPFL
--  "imager" toplevel block design.
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
-- Create Date: 01/24/2017 10:29:11 AM
-- Design Name: 
-- Module Name: sim_data_probe - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use WORK.data.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sim_data_probe is
    Port ( axis_tvalid : out STD_LOGIC;
           axis_tready : in STD_LOGIC;
           axis_tdata  : out STD_LOGIC_VECTOR (63 downto 0);
           axis_aclk   : in STD_LOGIC;
           reset       : in STD_LOGIC);
end sim_data_probe;

architecture Behavioral of sim_data_probe is

signal index: unsigned(15 downto 0);
-- How many samples to send
constant SAMPLES : integer := 31476; -- 31476 times 64 bits = 2623 samples (12-bit, for 64 elements)
-- Of which, how many from the data file (the rest will be filled with 0s)
constant DATA_PIECES : integer := 128;

begin
    process (axis_aclk, reset)
    begin
        if reset = '0' then
            index <= (others => '0');
            axis_tvalid <= '0';
            axis_tdata <= (others => '0');
        elsif rising_edge(axis_aclk) then
            if index < SAMPLES then
                if axis_tready = '1' then
                    index <= index + 1;
                end if;
                axis_tvalid <= '1';
                if index < DATA_PIECES then
                    -- TODO: this lane swapping compensates an issue with the Aurora TX block.
                    -- Vivado forces the mapping of Aurora lanes to resources and swaps the LSB lanes.
                    -- It doesn't look like this can be fixed via contraints or settings.
                    axis_tdata <= data_probe(to_integer(index))(63 downto 32) & data_probe(to_integer(index))(15 downto 0) & data_probe(to_integer(index))(31 downto 16);
                else
                    axis_tdata <= (others => '0');
                end if;
            else
                axis_tvalid <= '0';
                axis_tdata <= (others => '0');
            end if;
        end if;
    end process;
end Behavioral;
