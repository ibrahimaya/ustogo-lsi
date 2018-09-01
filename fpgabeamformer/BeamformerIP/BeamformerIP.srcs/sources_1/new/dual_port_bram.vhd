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

-- Dual-Port Block RAM with Two Write Ports
   -- Correct Modelization with a Shared Variable
   -- File: HDL_Coding_Techniques/rams/rams_16b.vhd
   library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.std_logic_unsigned.all;
    use ieee.std_logic_textio.all;
    use std.textio.all;
    use WORK.c2_filenames.all;
    
    entity dual_port_bram is
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
        
        attribute RAM_STYLE : string;
        attribute RAM_STYLE of dual_port_bram: entity is "BLOCK";
   end dual_port_bram;
    
   architecture syn of dual_port_bram is
   
   type ram_type is array (0 to 8191) of std_logic_vector(17 downto 0);
   
   impure function InitRamFromFile (RamFileName : in string) return ram_type is
      FILE RamFile : text is in RamFileName;
      variable RamFileLine : line;
      variable RAM : ram_type;
      begin
      for I in ram_type'range loop
      readline (RamFile, RamFileLine);
      read (RamFileLine, RAM(I));
      end loop;
      return RAM;
   end function;
  
--   shared variable RAM : ram_type   :=  InitRamFromFile("mem_init_1.txt");
   shared variable RAM : ram_type   :=  InitRamFromFile(c2_filename(ind));
    
   begin
   
   process (CLK)
   begin
    if CLK'event and CLK = '1' then
        if ENA = '1' then
            DOA <= RAM(conv_integer(ADDRA));
        end if;
    end if;
   end process;
      process (CLK)
   begin
   if CLK'event and CLK = '1' then
       if  ENA = '1' then 
           if WEB = '1' then
               RAM(conv_integer(ADDRA)) := DIB;
           end if;
       end if;
   end if;
   end process;

--   process (CLK)
--   begin
--   if CLK'event and CLK = '1' then
--       if  ENB = '1' then 
--           if WEB = '1' then
--               RAM(conv_integer(ADDRB)) := DIB;
--           end if;
--       end if;
--   end if;
--   end process;
   
   end syn;