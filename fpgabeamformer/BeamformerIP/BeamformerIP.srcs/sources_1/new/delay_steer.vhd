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
-- Create Date: 03/11/2016 06:09:22 PM
-- Design Name: 
-- Module Name: delay_steer - Behavioral
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
library UNISIM;
use UNISIM.VComponents.all;

Library UNIMACRO;
use UNIMACRO.vcomponents.all;

use WORK.y_constants.all;
use WORK.x_constants.all;
use WORK.c1_constants.all;
use WORK.c2_filenames.all;
use WORK.types_pkg.all;

entity delay_steer is
    Generic(
        row    :   integer;
        TRANSDUCER_ELEMENTS_X : integer;
        TRANSDUCER_ELEMENTS_Y : integer
    );
    Port (
          clk : in STD_LOGIC;                                                   -- clock
          rst_n : in STD_LOGIC;                                                 -- reset
          start_nappe  :   in  std_logic;                                       -- start a new nappe

          tx_delay : in std_logic_vector(17 downto 0);                          -- tx delays coming from the tx_calculator
          tx_offset : in std_logic_vector(17 downto 0);                         -- tx offset, varies for every origin point
          zone_cnt : in std_logic_vector(5 downto 0);                           -- keeps track of the zone that is reconstructed
          zone_theta : in std_logic_vector(3 downto 0);                         -- # of zones in one direction
          zone_width : in std_logic_vector(6 downto 0);                         -- width of each zone
          zone_height : in std_logic_vector(6 downto 0);                        -- height of each zone
          end_of_nappe  : out std_logic;                                        -- indicates the end of the reconstruction of a zone in one nappe
          start_steering : in std_logic := '0';                                 -- the first ref delays are ready so the steering can start (the first tx delay is also ready since it has a lower initial latency)
          ref_delay_2 : in ref_delay_row;                                       -- ref_delays are taken from the recond register
          delay   :   out  delay_row;                                           -- output of this block
          delay_valid : out std_logic                                           -- confirms validity of output
           );
end delay_steer;

architecture Behavioral of delay_steer is

-- BRAM where the c2 values are stored. the correct c2 values are fetched using the correct read address
component dual_port_bram is
    generic(
    ind :   integer
    );
    port(
    clk : in std_logic;
    ena   : in  std_logic;
    web  : in std_logic;
    addra : in std_logic_vector(12 downto 0);
    doa   : out std_logic_vector(17 downto 0);
    dib   : in std_logic_vector(17 downto 0)
    );

end component;

signal  theta    :   integer range 0 to NO_THETA-1    :=  0;                    -- used as counter for azimuth elements
signal  phi    :   integer range 0 to NO_PHI-1    :=  0;                        -- used as counter for elevation elements

signal  rdaddr   :   std_logic_vector(12 downto 0)    :=  (others => '0');      -- correct BRAM address
signal  dout   :   std_logic_vector(17 downto 0)    :=  (others => '0');        -- connected to the BRAM output

type stateS_type is (idle,startRead);
signal stateS : stateS_type := idle;
type c1_coeff_type is array(0 to TRANSDUCER_ELEMENTS_X - 1) of signed(17 downto 0);
type rx_debug_type is array(0 to TRANSDUCER_ELEMENTS_X - 1) of signed(17 downto 0);
signal c1_debug : c1_coeff_type;                                                -- c1 used for debug
signal c2_debug : signed(17 downto 0);                                          -- c2 used for debug

signal c1_index : integer range 0 to NO_THETA-1;                                -- index to fetch the correct c1 in LUTs
signal rx_debug : rx_debug_type;                                                -- rx delay used for debug
signal tx       :signed(17 downto 0);
signal run_nappe : std_logic;                                                   -- indicates that the zone of the nappe is being produced
begin

bram1:  dual_port_bram
generic map(
    ind   =>  row
)
port map(
    clk =>  clk,
    ena =>  '1',
    web  => '0',
    addra =>    rdaddr,
    doa   =>    dout,
    dib  => (others => '0')
);

-- This process takes the inputs from the tx_calculator and the ref_delay_calculator and sums them to constrants and offsets, creating the final delay
process (clk)
variable    c1_var  :   signed(17 downto 0);
variable    c2_var  :   signed(17 downto 0);
variable    delay_18bit :   unsigned(17 downto 0);
begin
    if rising_edge(clk) then
        if rst_n = '0' then
            stateS <= idle;
            theta <= 0;
            phi <= 0;
            rdaddr <= (others => '0');
            delay <= (others => (others => '0'));
            c1_index <= 0;
            run_nappe <= '0';
            delay_valid <= '0';
        else
        case stateS is
            when idle =>
                delay_valid <= '0';
                theta <= 0;
                phi <= 0;
                end_of_nappe <= '0';
                if start_nappe = '1' then                                                   -- start_nappe pulse is given
                    run_nappe <= '1';
                end if;
                if (start_nappe = '1' or run_nappe = '1') and start_steering = '1' then     -- ref_delays are ready, reconstruction an start
                    rdaddr <=  std_logic_vector(unsigned(rdaddr)+1);
                    stateS <= startRead;
                end if;
            when startRead =>
                delay_valid <= '1';
                if phi = to_integer(unsigned(zone_height)) - 2 then
                    phi <= phi + 1;
                    -- TODO what is this line?
                    rdaddr <= std_logic_vector(unsigned(rdaddr) + (NO_PHI - to_integer(unsigned(zone_width))) + 1 ); -- rdaddr is incremented keeping zone imaging into account
                elsif phi < to_integer(unsigned(zone_height)) - 1 then
                    phi <= phi + 1;
                    rdaddr  <=  std_logic_vector(unsigned(rdaddr) + 1);
                else
                    phi <= 0;
                    if theta < to_integer(unsigned(zone_width)) - 1 then
                        theta <= theta + 1;
                        c1_index <= c1_index + 1;
                        rdaddr  <=  std_logic_vector(unsigned(rdaddr)+1);
                    else
                        theta <= 0;
                        run_nappe <= '0';
                        stateS <= idle;
                        end_of_nappe <= '1';
                        c1_index <= (to_integer(unsigned(zone_cnt)) rem (to_integer(unsigned(zone_theta))))*to_integer(unsigned(zone_width));  -- take correct c1 index taking zone imaging into account
                        -- TODO this line is way too slow and becomes timing-critical. Do the math one cycle earlier 
                        rdaddr <= std_logic_vector(to_unsigned((to_integer(unsigned(zone_cnt)) rem (to_integer(unsigned(zone_theta)))) * to_integer(unsigned(zone_width))*NO_PHI + to_integer(unsigned(zone_width))*(to_integer(unsigned(zone_cnt))/to_integer(unsigned(zone_theta))),rdaddr'length));
                        --rdaddr  <= (others => '0');
                    end if;
                end if;
                c2_var := signed(dout(17 downto 0));

                -- for every voxel, produce one delay per transducer.
                for column in 0 to TRANSDUCER_ELEMENTS_X - 1 loop
                   c1_var      := c1(column)(c1_index);
                   c1_debug(column) <= c1_var;
                   rx_debug(column) <= signed(std_logic_vector(signed(std_logic_vector(ref_delay_2(column))) + c1_var + c2_var));
                   -- reference RX delay plus c1 correction plus c2 correction plus TX delay minus TX offset; to round it, add 0.5 (notation is 14.4) then trunsate
                   delay_18bit := unsigned(std_logic_vector(signed(std_logic_vector(ref_delay_2(column))) + c1_var + c2_var + signed(tx_delay) - signed(tx_offset))) + "000000000000001000";
                   delay(column) <= delay_18bit(17 downto 4);
                end loop;
            end case;
            c2_var := signed(dout(17 downto 0));
            c2_debug <= c2_var;
        end if;
    end if;
end process;

end Behavioral;
