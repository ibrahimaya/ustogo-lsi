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
-- Create Date: 11/11/2016 06:41:05 PM
-- Design Name:
-- Module Name: tx_calculator - Behavioral
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
use WORK.zone_imaging_origin_constants.all;
use WORK.compound_imaging_origin_constants.all;
use WORK.radius_constants.all;
use WORK.sin_constants.all;
use WORK.cos_constants.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- ASSUMPTIONS:
-- the number of zones in the azimuth and elevation direction is the same

entity tx_calculator is
    Generic (
            TX_LATENCY : integer := 2;
            IMAGING2D : integer := 0
        );
    Port ( clk : in STD_LOGIC;                              -- Clock: 133 MHz
           rst_n : in STD_LOGIC;                            -- Reset Low
           start_nappe : in STD_LOGIC;                      -- Beginning of a new nappe
           start_steering : in STD_LOGIC;                   -- Signal Indicating Steering Modules are ready to receive Tx
           zone_cmd_switch : in STD_LOGIC;                  -- 0: Zone Imaging, 1: Compound Imaging
           zone_azi : in STD_LOGIC_VECTOR(3 downto 0);      -- How many zones the user wants in the azi direction.
           zone_elev : in STD_LOGIC_VECTOR(3 downto 0);     -- How many zones does the user want in the elev direction.
           run_cnt : in STD_LOGIC_VECTOR(6 downto 0);       -- # of zones or compounded images
           zone_width : in STD_LOGIC_VECTOR(6 downto 0);    -- width of a zone
           zone_height : in STD_LOGIC_VECTOR(6 downto 0);   -- height of a zone
           zone_origin_base_pointer : in std_logic_vector(5 downto 0); -- Starting point in zone_origins LUT
           compound_origin_base_pointer : in std_logic_vector(5 downto 0); -- Starting point in compound_origins LUT
           -- Outputs
           tx_out : out STD_LOGIC_VECTOR(17 downto 0);      -- Tx Delay output
           out_ready : inout STD_LOGIC                      -- -- Signal from cordic indicating valid square root
             );
end tx_calculator;

architecture Behavioral of tx_calculator is

    component sqrt_cordic_tx is                     -- Square root Cordic for Calculating Tx Distance between Origin and Voxel
        port(
            clk     :   in  std_logic;
            rst_n   :   in  std_logic;
            enable  :   in  std_logic;
            start   :   in  std_logic;
            data_valid  :   out std_logic;          --the data coming from the square root cordic is valid

            input   :   in  unsigned(35 downto 0);
            output  :   out unsigned(17 downto 0)
        );
    end component;

    signal master_enable     : std_logic;                               -- Enable signal for controlling all components of Tx calculator

    -- Counters - Used in the voxel_lut_pointer_calculaton process to track the current voxel in the zone
    signal nappe_counter     : STD_LOGIC_VECTOR(10 downto 0);           -- NOTE nappe_counter is also a pointer to an LUT
    signal azimuth_counter   : STD_LOGIC_VECTOR(6 downto 0);            
    signal elevation_counter : STD_LOGIC_VECTOR(6 downto 0);
    signal curr_zone_azi     : unsigned(2 downto 0);                    -- used to keep track of the zone we are currently
    signal curr_zone_elev    : unsigned(2 downto 0);                    -- calculating TX delays for
    
    -- Pointers
    signal azimuth_pointer   : unsigned(6 downto 0);                    -- These counters are used as indices for the LUTs
    signal elevation_pointer : unsigned(6 downto 0);                    -- when calculating Xs, Ys and Zs
    
    -- Origin point calculation
    signal inc              : unsigned(5 downto 0);                     -- Incrementing value for selecting next origin point on LUTs
    signal end_of_zone      : std_logic;                                -- Indicates end of zone or compound to select new origin
    signal end_of_zone_delay: std_logic_vector(TX_LATENCY - 1 downto 0);-- Indicates end of zone or compound to select new origin
    signal x0, y0, z0       : STD_LOGIC_VECTOR(17 downto 0);            -- Origin point.               Format: 18 bits, 14.4

    -- Voxel point Calculation
    signal radius_v         : signed(18 downto 0);                      -- Radius to current nappe.    Format: 19 bits, 14.5
    signal sin_theta        : signed(18 downto 0);                      -- Sin value of current theta. Format: 19 bits, 2.17
    signal cos_theta        : signed(18 downto 0);                      -- Cos value of current theta. Format: 19 bits, 2.17
    signal cos_theta_delay  : signed(18 downto 0);                      -- Cos value of current theta. Format: 19 bits, 2.17
    signal sin_phi          : signed(18 downto 0);                      -- Sin value of current phi.   Format: 19 bits, 2.17
    signal cos_phi          : signed(18 downto 0);                      -- Cos value of current phi.   Format: 19 bits, 2.17
    signal xS_delay         : std_logic_vector(37 downto 0);            --38 bits, 15.23 format
    signal yS_part          : std_logic_vector(37 downto 0);            --38 bits, 15.23 format
    signal zS_part          : std_logic_vector(37 downto 0);            --38 bits, 15.23 format
    signal xS, yS, zS       : STD_LOGIC_VECTOR(17 downto 0);            -- Voxel point.                Format: 18 bits, 14.4
    signal xS_subtract, yS_subtract, zS_subtract : signed(17 downto 0); 
    signal xyz_valid        : std_logic;                                -- Indicates that voxel point is valid
    signal xyz_valid_delay  : std_logic_vector(TX_LATENCY - 1 downto 0); -- Indicates that voxel point is valid

    -- Square root Calculation
    signal sqr_and_sum      :   std_logic_vector(35 downto 0);          -- Squared and summed values of origin and voxel. Format: 36 bits, 28.8
    signal start_sqrt       :   std_logic       :=  '0';                -- Signal indicates that sqr_and_sum is valid for cordic
    signal start_sqrt_delayed : std_logic       :=  '0';                -- Delayed Signal indicates that sqr_and_sum is valid for cordic
    signal sqrt_res         :   unsigned(17 downto 0);                  -- Square root output from cordic
    signal init             :   std_logic;                              -- flag used to control run_nappe during the reconstruction of nappe 1,zone 0
    signal tx_out_cnt_debug : integer :=0;                             -- Debug counter indicating number of computed Tx delays

    type stateTx_type is (idle,runNappe);                               -- State machine for controlling the output of the Tx delays
    signal stateTx : stateTx_type := idle;

    signal phi_cnt_out   :  integer range 0 to NO_PHI - 1;              -- counter that keeps track of the outputted voxels in the phi(elev) direction
    signal theta_cnt_out :  integer range 0 to NO_THETA - 1;            -- counter that keeps track of the outputted voxels in the theta(azi) direction
    signal run_nappe     : std_logic;                                   -- is high when the nappe is outputted, used to control the master_enable
begin


    master_enable <= run_nappe and (not(out_ready) or start_steering); -- Controls the processing of Tx delays. 

	sqrt_cordic_2: sqrt_cordic_tx
    port map(
            clk     =>  clk,
            rst_n   =>  rst_n,
            enable  =>  master_enable,
            start   =>  start_sqrt,
            data_valid  =>  out_ready,
            input   =>  unsigned(sqr_and_sum),
            output  =>  sqrt_res
        );

-- This process is in charge of selecting the correct origin coordinates from the LUT in the library WORK.zone_origins_constants.all
-- or WORK.compound_origins_constants.all (depending on whether zone imaging or compouding is selected). The zone_origin_base_pointer
-- constant, coming from delay_top, selects the values for the origin in zone 0. New origins are selected every time all nappes have
-- been reconstructed for a certain zone.
origin_point_calculator:
process(clk)
begin
    if rising_edge(clk) then
        if rst_n = '0' then
            x0 <= (others => '0');
            y0 <= (others => '0');
            z0 <= (others => '0');
            inc <= (others => '0');
        else
            if (zone_cmd_switch = '0') then
                x0 <= std_logic_vector(zone_imaging_origin(to_integer(unsigned(zone_origin_base_pointer) + inc))(0));
                y0 <= std_logic_vector(zone_imaging_origin(to_integer(unsigned(zone_origin_base_pointer) + inc))(1));
                z0 <= std_logic_vector(zone_imaging_origin(to_integer(unsigned(zone_origin_base_pointer) + inc))(2));
            else
                x0 <= std_logic_vector(compound_imaging_origin(to_integer(unsigned(compound_origin_base_pointer) + inc))(0));
                y0 <= std_logic_vector(compound_imaging_origin(to_integer(unsigned(compound_origin_base_pointer) + inc))(1));
                z0 <= std_logic_vector(compound_imaging_origin(to_integer(unsigned(compound_origin_base_pointer) + inc))(2));
            end if;
            -- When end_of_zone is reached, retrieve new origin point
            if (end_of_zone_delay(end_of_zone_delay'high) = '1') then
                if (inc + 1 = unsigned(run_cnt)) then
                    inc <= (others => '0');
                else
                    inc <= inc + 1;
                end if;
            end if;
        end if;
    end if;
end process;


-- This process increments phi_cnt_out and theta_cnt_out when start_steering is asserted (meaning that the other modules are ready to
-- receive TX delays). Run_nappe is asserted when the recontruction of the new nappe begins and is put back to 0 when the two counters
-- for phi and theta have iterated on all the voxels of the zone that is reconstructed. The timing of run_nappe is important since it controls
-- the master_enable, which controls the timing of this whole block. The final goal is to have the correct tx_delay in the delay_steer modules
-- at the correct time
voxel_output_counter:
process (clk)
begin
    if rising_edge(clk) then
        if rst_n = '0' then
            run_nappe <= '0';
            phi_cnt_out <= 0;
            theta_cnt_out <= 0;
            stateTx <= idle;
            init <= '0';
        else
            case stateTx is
                when idle =>
                    run_nappe <= '0';
                    if start_nappe = '1' then
                        stateTx <= runNappe;
                        run_nappe <= '1';
                    end if;
                when runNappe =>
                    if start_steering = '1' then
                        if (to_integer(unsigned(zone_height)) > 1 and (phi_cnt_out < to_integer(unsigned(zone_height)) - 1)) then
                            phi_cnt_out <= phi_cnt_out + 1;
                        else
                            phi_cnt_out <= 0;
                            if theta_cnt_out < to_integer(unsigned(zone_width)) - 1 then
                                theta_cnt_out <= theta_cnt_out + 1;
                            else
                                theta_cnt_out <= 0;
                                stateTx <= idle;
                                if init = '0' then            -- run_nappe stays at 1 for one cycle longer the first time
                                    init <= '1';              -- this is necessary to allow the first tx_delay value of the second nappe
                                else                          -- to be ready in the gen_delay_steer module.
                                    run_nappe <= '0';         -- TODO however this creates an offset of 1 in azimuth_pointer. Check if this is OK.
                                end if;
                            end if;
                        end if;
                    end if;
                end case;
            end if;
        end if;
end process;

-- This process counts the iterations on the elevation and azimuth lines and increments nappe counter.
-- It also controls the elevation and azimuth pointer that are responsible for fetching the correct sin and cos
-- values in LUTs for later calculation. While the counters always have to go until zone_width - 1, the pointers
-- have to be initialized correctly in case of zone imaging.
voxel_lut_pointer_calculaton:
process (clk)
variable elevation_mult : unsigned (9 downto 0);
variable azimuth_mult : unsigned (9 downto 0);
begin
    if rising_edge(clk) then
        nappe_counter <= nappe_counter;
        azimuth_counter <= azimuth_counter;
        elevation_counter <= elevation_counter;
        elevation_pointer <= elevation_pointer;
        azimuth_pointer   <= azimuth_pointer;
        curr_zone_elev <= curr_zone_elev;
        curr_zone_azi <= curr_zone_azi;
        end_of_zone <= '0';
        if rst_n = '0' then
            nappe_counter       <= (others => '0');
            azimuth_counter     <= (others => '0');
            elevation_counter   <= (others => '0');
            elevation_pointer   <= (others => '0');
            azimuth_pointer     <= (others => '0');
            curr_zone_elev      <= (others => '0');
            curr_zone_azi       <= (others => '0');
            end_of_zone         <= '0';
            end_of_zone_delay   <= (others => '0');
        else
            -- Every time we finish processing a zone, enqueue a '1' into the LSB of this signal.
            -- Every cycle, shift left by 1 position until the '1' bubbles up to the MSB, at which
            -- point we will load new origin coordinates.
            end_of_zone_delay <= end_of_zone_delay(end_of_zone_delay'high-1 downto 0) & end_of_zone;

            if master_enable = '1' then
                if elevation_counter < std_logic_vector(unsigned(zone_height) - 1) then
                    elevation_counter  <=  std_logic_vector(unsigned(elevation_counter) + 1);
                    elevation_pointer <= elevation_pointer + 1;
                else
                    elevation_counter <= (others =>'0');
                    elevation_mult := curr_zone_elev * unsigned(zone_height);
                    elevation_pointer <= elevation_mult(6 downto 0);
                    if azimuth_counter < std_logic_vector(unsigned(zone_width)-1) then
                        azimuth_counter <= std_logic_vector(unsigned(azimuth_counter) + 1);
                        azimuth_pointer <= azimuth_pointer + 1;
                    else
                        azimuth_counter <= (others => '0');
                        azimuth_mult := curr_zone_azi * unsigned(zone_width);
                        azimuth_pointer <= azimuth_mult(6 downto 0);
                        if nappe_counter < std_logic_vector(to_unsigned(NO_DEPTH-1,nappe_counter'length)) then
                            nappe_counter <= std_logic_vector(unsigned(nappe_counter) + 1);
                        else
                            if (curr_zone_azi < unsigned(zone_azi) - 1) then                        -- this if/else statement ensures that the azimuth
                                curr_zone_azi <= curr_zone_azi + 1;                                 -- and elevation pointers are placed correctly when going from
                                azimuth_mult := (curr_zone_azi + 1) * unsigned(zone_width);         -- one zone to the next one
                                azimuth_pointer <= azimuth_mult(6 downto 0);
                            else
                                curr_zone_azi <= (others => '0');
                                azimuth_pointer <= (others => '0');
                                if (curr_zone_elev < unsigned(zone_elev) - 1) then
                                    curr_zone_elev <= curr_zone_elev + 1;
                                    elevation_mult := (curr_zone_elev + 1) * unsigned(zone_height);
                                    elevation_pointer <= elevation_mult(6 downto 0);
                                else
                                    curr_zone_elev <= (others => '0');
                                    elevation_pointer <= (others => '0');
                                end if;
                            end if;
                            nappe_counter <= (others => '0');
                            end_of_zone <= '1';
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end if;
end process;


-- Since zone imaging is implemented for 1,4,16 and 64 zones, it was easier and more efficient to include LUTs for sine and cosine values
-- rather than including cordic IPs to perform these calculations. This process uses the nappe_counter, the azimuth_pointer and the elevation_pointer
-- to fetch the correct values of sin,cos and radius. It then calculates the coordinates Xs,Ys and Zs which are the coordinates of each
-- voxel in the nappe.

process (clk)
    variable xS_temp : std_logic_vector(37 downto 0); --38 bits, 15.23 format
    variable yS_temp : std_logic_vector(56 downto 0); --57 bits, 17.40 format
    variable zS_temp : std_logic_vector(56 downto 0); --57 bits, 17.40 format
begin
    if rising_edge(clk) then
        xS <= xS;
        yS <= yS;
        zS <= zS;
        xyz_valid_delay <= xyz_valid_delay(xyz_valid_delay'high-1 downto 0) & xyz_valid;
        if rst_n = '0' then
            xS <= (others => '0');
            yS <= (others => '0');
            zS <= (others => '0');
            xS_delay <= (others => '0');
            yS_part  <= (others => '0');
            zS_part  <= (others => '0');
            xyz_valid <= '0';
            xyz_valid_delay <= (others => '0');
        elsif master_enable = '1' then
            radius_v        <= radius(to_integer(unsigned(nappe_counter)));
            sin_theta       <= sin(to_integer(unsigned(azimuth_pointer)));
            cos_theta       <= cos_theta_delay;
            cos_theta_delay <= cos(to_integer(unsigned(azimuth_pointer)));
            if (IMAGING2D = 1) then
                sin_phi         <= (others => '0');
                cos_phi         <= "0100000000000000000";
            else
                sin_phi         <= sin(to_integer(unsigned(elevation_pointer)));
                cos_phi         <= cos(to_integer(unsigned(elevation_pointer)));
            end if;
            xS_delay <=  std_logic_vector(radius_v*sin_theta);
            yS_part  <=  std_logic_vector(radius_v*sin_phi);
            zS_part  <=  std_logic_vector(radius_v*cos_phi);
            yS_temp  :=  std_logic_vector((signed(yS_part)*cos_theta));
            zS_temp  :=  std_logic_vector((signed(zS_part)*cos_theta));
            xS <= xS_delay(36 downto 19);
            yS <= yS_temp(53 downto 36);
            zS <= zS_temp(53 downto 36);
            xyz_valid <= '1';
        end if;
    end if;
end process;

-- This process feeds to the sqrt_cordic module the values that must be square-rooted, as soon as the Xs,Ys,Zs coordinates are available
-- and the mater_enable is asserted. It then waits for the sqrt to produce a valid value (there is a delay of 13 cycles). This values is
-- placed on the tx_out line, while the out_ready line states that a tx_delay is ready to be used. According to the timing imposed by
-- master_enable, new values are generated from the sqrt_cordic and then are outputted in such a way that they arrive in the delay_steer
-- block at the correct time.
process (clk)
begin    
    if rising_edge(clk) then
        sqr_and_sum <= sqr_and_sum;
        start_sqrt <= start_sqrt_delayed;
        if rst_n = '0' then
            start_sqrt <= '0';
            start_sqrt_delayed <= '0';
            sqr_and_sum <= (others => '0');
            xS_subtract <= (others => '0');
            yS_subtract <= (others => '0');
            zS_subtract <= (others => '0');
        elsif master_enable = '1' then
            if xyz_valid_delay(xyz_valid_delay'high) = '1' then
                xS_subtract <= signed(xS)-signed(x0);
                yS_subtract <= signed(yS)-signed(y0);
                zS_subtract <= signed(zS)-signed(z0);
                sqr_and_sum <=  std_logic_vector(xS_subtract*xS_subtract + yS_subtract*yS_subtract+ zS_subtract*zS_subtract);
                start_sqrt_delayed   <=  '1';
            end if;

            if (out_ready = '1' and start_sqrt = '1')  then
                tx_out <= std_logic_vector(sqrt_res);
                if start_steering = '1' then
                    tx_out_cnt_debug <= tx_out_cnt_debug +1;
                end if;
            end if;
        end if;
    end if;
end process;

end Behavioral;

