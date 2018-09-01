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
-- Create Date: 01/14/2017 02:57:17 PM
-- Design Name: 
-- Module Name: reorder_chan - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reorder_chan is
Generic(FIFO_WIDTH: integer:= 64;
    FIFO_CHAN_WIDTH: integer:= 16
);
Port (
    -- AXI Stream interface with the FIFO
    fifo_axis_aresetn: in std_logic;
    fifo_axis_aclk: in std_logic;
    fifo_axis_tready: out std_logic;
    fifo_axis_tvalid: in std_logic;
    fifo_axis_tdata : in std_logic_vector(FIFO_WIDTH-1 downto 0);
    
    -- Interface with the BF
    chan_data : out std_logic_vector(FIFO_CHAN_WIDTH-1 downto 0);
    stall : in std_logic;
    valid: out std_logic
);
end reorder_chan;

architecture Behavioral of reorder_chan is

signal fifo_data_cur, fifo_data_next : std_logic_vector(FIFO_WIDTH-1 downto 0);
signal wrap_around_cur, wrap_around_next : std_logic_vector(7 downto 0);
signal cnt_cur, cnt_next: unsigned(3 downto 0);
signal first_cur, first_next: std_logic;
signal valid_next, valid_cur : std_logic;

begin

register_process:
process(fifo_axis_aresetn, fifo_axis_aclk)
begin
    if fifo_axis_aresetn = '0' then
        fifo_data_cur <= (others => '0');
        wrap_around_cur <= (others => '0');
        cnt_cur <= (others => '0');
        first_cur <= '1';
        valid_cur <= '0';
    elsif rising_edge(fifo_axis_aclk) then
        fifo_data_cur <= fifo_data_next;
        if (valid_cur = '1' and stall = '0') then
            wrap_around_cur <= wrap_around_next;
        end if;
        cnt_cur <= cnt_next;
        first_cur <= first_next;
        valid_cur <= valid_next;
    end if;
end process;

next_process:
process(cnt_cur, fifo_data_cur, wrap_around_cur, first_cur)
begin
    wrap_around_next <= wrap_around_cur;
    chan_data <= (others => '0');
    case cnt_cur is
        when x"0" =>
          chan_data <=  fifo_data_cur(59) & fifo_data_cur(59) & fifo_data_cur(59) & fifo_data_cur(59) & fifo_data_cur(59 downto 48);
          wrap_around_next <= fifo_data_cur(63) & fifo_data_cur(63) & fifo_data_cur(63) & fifo_data_cur(63) & fifo_data_cur(63 downto 60);
        when x"1" =>
           chan_data <= fifo_data_cur(47) & fifo_data_cur(47) & fifo_data_cur(47) & fifo_data_cur(47) & fifo_data_cur(47 downto 36);
        when x"2" =>
            chan_data <= fifo_data_cur(35) & fifo_data_cur(35) & fifo_data_cur(35) & fifo_data_cur(35) & fifo_data_cur(35 downto 24);
        when x"3" =>
            chan_data <= fifo_data_cur(23) & fifo_data_cur(23) & fifo_data_cur(23) & fifo_data_cur(23) & fifo_data_cur(23 downto 12);
        when x"4" =>
            chan_data <= fifo_data_cur(11) & fifo_data_cur(11) & fifo_data_cur(11) & fifo_data_cur(11) & fifo_data_cur(11 downto 0);
        when x"5" =>
            chan_data <= fifo_data_cur(55) & fifo_data_cur(55) & fifo_data_cur(55) & fifo_data_cur(55) & fifo_data_cur(55 downto 44);
        when x"6" =>
            chan_data <= fifo_data_cur(43) & fifo_data_cur(43) & fifo_data_cur(43) & fifo_data_cur(43) & fifo_data_cur(43 downto 32);
        when x"7" =>
            chan_data <= fifo_data_cur(31) & fifo_data_cur(31) & fifo_data_cur(31) & fifo_data_cur(31) & fifo_data_cur(31 downto 20);
        when x"8" =>
            chan_data <= fifo_data_cur(19) & fifo_data_cur(19) & fifo_data_cur(19) & fifo_data_cur(19) & fifo_data_cur(19 downto 8);
        when x"9" =>
            chan_data <= fifo_data_cur(7) & fifo_data_cur(7) & fifo_data_cur(7) & fifo_data_cur(7) & fifo_data_cur(7 downto 0) & wrap_around_cur(3 downto 0);
            wrap_around_next <= fifo_data_cur(63 downto 56);
        when x"a" =>
            chan_data <= fifo_data_cur(63) & fifo_data_cur(63) & fifo_data_cur(63) & fifo_data_cur(63) & fifo_data_cur(63 downto 52);
        when x"b" =>
            chan_data <= fifo_data_cur(51) & fifo_data_cur(51) & fifo_data_cur(51) & fifo_data_cur(51) & fifo_data_cur(51 downto 40);
        when x"c" =>
            chan_data <= fifo_data_cur(39) & fifo_data_cur(39) & fifo_data_cur(39) & fifo_data_cur(39) & fifo_data_cur(39 downto 28);
        when x"d" =>
            chan_data <= fifo_data_cur(27) & fifo_data_cur(27) & fifo_data_cur(27) & fifo_data_cur(27) & fifo_data_cur(27 downto 16);
        when x"e" =>
            chan_data <= fifo_data_cur(15) & fifo_data_cur(15) & fifo_data_cur(15) & fifo_data_cur(15) & fifo_data_cur(15 downto 4);
        when x"f" =>
            chan_data <= fifo_data_cur(3) & fifo_data_cur(3) & fifo_data_cur(3) & fifo_data_cur(3) & fifo_data_cur(3 downto 0) & wrap_around_cur;
        when others => null;
    end case;
end process;

update_reg:
process(cnt_cur, fifo_axis_tvalid, first_cur, stall, fifo_axis_tdata, fifo_data_cur, valid_cur)
begin
    cnt_next <= cnt_cur;
    first_next <= first_cur;
    fifo_axis_tready <= '0';
    fifo_data_next <= fifo_data_cur;
    valid_next <= valid_cur;
    if (stall = '0') then
        if (cnt_cur = x"f" or cnt_cur = x"4" or cnt_cur = x"9" or first_cur = '1') then
            if (fifo_axis_tvalid = '1') then
                fifo_axis_tready <= '1';
                fifo_data_next <= fifo_axis_tdata;
                first_next <= '0';
                if (first_cur = '0') then
                    cnt_next <= cnt_cur + 1; 
                end if;
                valid_next <= '1';
            else
                valid_next <= '0';
            end if;
        elsif first_cur = '0' then
            cnt_next <= cnt_cur + 1;
        end if;
    end if; 
end process;

valid <= valid_cur;

end Behavioral;
