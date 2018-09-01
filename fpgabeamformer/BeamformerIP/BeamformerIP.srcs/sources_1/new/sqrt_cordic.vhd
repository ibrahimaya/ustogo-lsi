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
-- Create Date: 03/09/2016 01:27:19 PM
-- Design Name: 
-- Module Name: sqrt_cordic - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sqrt_cordic is
    Port (         
        clk     :   in  std_logic;
        rst_n   :   in  std_logic;
        enable  :   in  std_logic;
        start   :   in  std_logic;
        data_valid  :   out std_logic;

        input   :   in  unsigned(35 downto 0);
        output  :   out unsigned(17 downto 0) 
        );
    end sqrt_cordic;

architecture Behavioral of sqrt_cordic is

COMPONENT cordic_0
  PORT (
    aclk : IN STD_LOGIC;
    aclken : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_cartesian_tvalid : IN STD_LOGIC;
    s_axis_cartesian_tdata : IN STD_LOGIC_VECTOR(39 DOWNTO 0);
    m_axis_dout_tvalid : OUT STD_LOGIC;
    m_axis_dout_tdata : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
  );
END COMPONENT;

signal tmp  :   std_logic_vector(23 downto 0);   

--attribute KEEP : string;
--attribute KEEP of output: signal is "TRUE";
begin

output  <=  unsigned(tmp(17 downto 0));

cordic_inst0 : cordic_0
  PORT MAP (
    aclk => clk,
    aclken => enable,
    aresetn => rst_n,
    s_axis_cartesian_tvalid => start,
    s_axis_cartesian_tdata(39 downto 36) => "0000",
    s_axis_cartesian_tdata(35 downto 0) => STD_LOGIC_VECTOR(input),
    m_axis_dout_tvalid => data_valid,
    m_axis_dout_tdata => tmp
  );

end Behavioral;
