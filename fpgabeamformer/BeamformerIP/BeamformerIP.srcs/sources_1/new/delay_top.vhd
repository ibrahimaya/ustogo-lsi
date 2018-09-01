-- ***************************************************************************
-- ***************************************************************************
--  Copyright (C) 2014-2018  EPFL
--   "BeamformerIP" custom IP
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
-- Create Date: 03/14/2016 03:34:13 PM
-- Design Name: 
-- Module Name: delay_top - Behavioral
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
use WORK.types_pkg.all;
use WORK.tx_offsets_constants.all;

-- TODO width of the zone counter fields
entity delay_top is
    Generic(
        TRANSDUCER_ELEMENTS_X : integer := 32;                        --Elements of the transducer in X and Y direction
        TRANSDUCER_ELEMENTS_Y : integer := 32;
        RADIAL_LINES_LOG      : integer := 10;
        IMAGING2D             : integer := 0
    );
    Port (
        clk                 : in STD_LOGIC;
        rst_n               : in STD_LOGIC;
        start_nappe         : in std_logic;                                 -- start to reconstruct a new nappe
        phi_cnt_out         : inout integer range 0 to NO_PHI - 1;          -- counter for phi (elevation) elements
        theta_cnt_out       : inout integer range 0 to NO_THETA - 1;        -- counter for theta (azimuth) elements
        nt_cnt              : inout std_logic_vector(RADIAL_LINES_LOG - 1 downto 0);           -- counter for nappes
        compound_not_zone_imaging : in std_logic;                           -- 0 for zone imaging, 1 for compounding
        azimuth_zones       : in std_logic_vector(3 downto 0);              -- Azimuth zones
        elevation_zones     : in std_logic_vector(3 downto 0);              -- Elevation zones
        compounding_count   : in std_logic_vector(4 downto 0);              -- counter for compounding
        run_cnt             : inout std_logic_vector(6 downto 0);           -- # of zones or compounded images
        zone_width          : inout std_logic_vector(6 downto 0);           -- width of each zone
        zone_height         : inout std_logic_vector(6 downto 0);           -- height of each zone
        delay_valid         : inout std_logic;                              -- delay produced by the block is valid
        end_of_nappe        : inout std_logic;                              -- pulse signal, it is one when a nappe's reconstruction is finished
        delay               : out unsigned(TRANSDUCER_ELEMENTS_X * TRANSDUCER_ELEMENTS_Y * 14 - 1 downto 0);  -- final delay produced by the gen_steer block
        zone_cnt_out        : inout std_logic_vector(5 downto 0);           -- indicates the zone that is reconstructed.
        zero_offset         : in signed(13 downto 0);                       -- zero offset in the input samples (at which time the first sample comes)
        streaming_not_fixed : in std_logic                                  -- If 1: data is coming in a streaming fashion (use only the offset delay from the ZERO_OFFSET_REG)
                                                                            -- If 0: data is coming in packets of BRAM_SAMPLES_PER_NAPPE, use a precomputed offset table from Matlab
        );
end delay_top;

architecture Behavioral of delay_top is

-- component that generates the TX delays (one delay per voxel)
component tx_calculator is
    Generic (  IMAGING2D : integer := 0 );
    Port ( clk : in STD_LOGIC;                              -- Clock: tested at 133 MHz
           rst_n : in STD_LOGIC;                            -- Reset Low
           start_nappe : in STD_LOGIC;
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
           out_ready : inout STD_LOGIC                      -- Indicator that Tx Delay output is valid
             );
end component;

-- component that generates the reference delays (one delay per transducer element)
-- Delay is the TRANSDUCER_ELEMENTS_X * TRANSDUCER_ELEMENTS_Y, one cycle per element.
-- CURRENTLY, We calculate the ref delays for the next nappe while we are processing the current nappe
-- TODO: this will present problems with zone imaging, if the time required to process the current nappe + the time to store/transmit the current nappe
-- is shorter than the time it takes to calculate the ref delays for the next nappe
component ref_delay_calculator is
    Generic(
        TRANSDUCER_ELEMENTS_X : integer := 32;
        TRANSDUCER_ELEMENTS_Y : integer := 32
    );
    Port (
            clk       : in  std_logic;
            rst_n     : in  std_logic;

            inp_rdy   : in  std_logic;
            out_rdy   : out std_logic;

            nt_cnt    : in  integer range 0 to NO_DEPTH - 1;
            x_cnt     : in  integer range 0 to TRANSDUCER_ELEMENTS_X - 1;
            y_cnt     : in  integer range 0 to TRANSDUCER_ELEMENTS_Y - 1;

            streaming_not_fixed : in std_logic;     -- If 1: data is coming in a streaming fashion (use only the offset delay from the ZERO_OFFSET_REG)
                                                    -- If 0: data is coming in packets of BRAM_SAMPLES_PER_NAPPE, use a precomputed offset table from Matlab
            ref_delay : out  unsigned(17 downto 0);
            zero_offset   : in signed(13 downto 0)              -- zero offset in the input samples (at which time the first sample comes)
             );
end component;

-- component that generates the final delay (sum of TX delay, reference delay and some offset constants). 
-- We generate TRANSDUCER_ELEMENTS_Y delay_steer components, or 1 per element row. 
-- These each in turn generate one delay per element in its respective row per cycle.
-- The sum of all the gen_delay_steer components generates one delay per focal point per transducer element
component delay_steer is
    Generic(
        row    :   integer;
        TRANSDUCER_ELEMENTS_X: integer;
        TRANSDUCER_ELEMENTS_Y: integer
    );
    Port (
        clk : in STD_LOGIC;
        rst_n : in STD_LOGIC;
        start_nappe  :   in  std_logic;

        -- TODO signal widths
        tx_delay : in std_logic_vector(17 downto 0);
        tx_offset : in std_logic_vector(17 downto 0);
        zone_cnt : in std_logic_vector(5 downto 0);
        zone_theta : in std_logic_vector(3 downto 0);
        zone_width : in std_logic_vector(6 downto 0);
        zone_height : in std_logic_vector(6 downto 0);

        start_steering : in std_logic := '0';
        ref_delay_2 : in ref_delay_row;
        end_of_nappe : out std_logic;
        delay   :   out  delay_row;
        delay_valid : out std_logic
           );
end component;

signal  x_cnt_in       : integer range 0 to TRANSDUCER_ELEMENTS_X-1 := 0;       -- counter for transducer elements
signal  y_cnt_in       : integer range 0 to TRANSDUCER_ELEMENTS_Y-1 := 0;       -- counter for transducer elements
signal  nt_cnt_in      : integer range 0 to NO_DEPTH-1              := 0;       -- counter for nappes

signal  ref_x_cnt      : integer range 0 to TRANSDUCER_ELEMENTS_X-1 := 0;       -- counter for reference delays
signal  ref_y_cnt      : integer range 0 to TRANSDUCER_ELEMENTS_Y-1 := 0;       -- counter for reference delays
signal  next_nappe     : integer range 0 to NO_DEPTH-1              := 0;       -- indicates the next nappe that has to be produced. used for synchronization
signal  ref_delay_res  : unsigned(17 downto 0);                                 -- result of the ref delay calculator
signal  ref_delay_1    : ref_delay_matrix;                                      -- register to store the reference delays when they are produced
signal  ref_delay_2    : ref_delay_matrix;                                      -- register to store reference delays coming from ref_delay_1 before feeding them to the gen_delay_steer
signal  delay_int      : delay_matrix;                                          -- steered delays
signal  ref_delay_reset : std_logic;                                            -- reset for the reference delay calculator

signal gen_delay_reset_1 : std_logic;                                           -- reset signal for ref_delay calculator
signal gen_delay_reset_2 : std_logic;                                           -- reset signal for ref_delay_calculator
signal  start_steering : std_logic := '0';                                      -- start producing delays  in the gen_delay_Steer block

signal  inp_rdy        : std_logic := '0';                                      -- indicates that there is an input ready for the ref_delay_calculator
signal  ref_delay_rdy  : std_logic := '0';                                      -- ref_calculator has a ready output that can be stored in the ref_delay_1 register

signal zone_origin_base_pointer : std_logic_vector(5 downto 0);                 -- pointer to fetch the zone imaging origins from LUTs
signal compound_origin_base_pointer : std_logic_vector(5 downto 0);             -- pointer to fetch the compound imaging origins from LUTs
signal tx_delay_out     : std_logic_vector(17 downto 0);                        -- delay from tx_calculator
signal tx_out_ready     : std_logic;                                            -- tx delay ready
signal tx_offset        :   std_logic_vector(17 downto 0);                      -- tx offset, taken from LUT. Changes per every origin point. Format: 14.4

signal end_of_nappe_bundle : std_logic_vector(TRANSDUCER_ELEMENTS_X - 1 downto 0);
signal delay_valid_bundle  : std_logic_vector(TRANSDUCER_ELEMENTS_X - 1 downto 0); 
type state_ref_in is (reset,running,waiting);                                   -- state to control the production of ref_delays
signal stateRin : state_ref_in := running;
type state_ref_out is (reset,idle,ready,stop);                                  -- state to take the output coming from the ref_delay calculator
signal stateRout : state_ref_out := reset;
signal zone_tot : std_logic_vector(7 downto 0);

begin

ref_delay_reset <= gen_delay_reset_1 or gen_delay_reset_2;
zone_tot <= std_logic_vector(unsigned(azimuth_zones) * unsigned(elevation_zones));

ref_delay_calculator1:  ref_delay_calculator
generic map(
    TRANSDUCER_ELEMENTS_X => TRANSDUCER_ELEMENTS_X,
    TRANSDUCER_ELEMENTS_Y => TRANSDUCER_ELEMENTS_Y
)
port map(
    clk       =>  clk,
    rst_n     =>  ref_delay_reset,
    inp_rdy   =>  inp_rdy,
    out_rdy   =>  ref_delay_rdy,
    nt_cnt    =>  nt_cnt_in,
    x_cnt     =>  x_cnt_in,
    y_cnt     =>  y_cnt_in,
    streaming_not_fixed => streaming_not_fixed,
    ref_delay =>  ref_delay_res,
    zero_offset => zero_offset
);

tx_calculator1: tx_calculator
    generic map(
        IMAGING2D => IMAGING2D
    )
    port map( clk => clk,                                                       -- Clock: 133 MHz
           rst_n =>rst_n,                                                       -- Reset Low
            start_nappe => start_nappe,
           start_steering => start_steering,                                    -- Signal Indicating Steering Modules are ready to receive Tx
           zone_cmd_switch => compound_not_zone_imaging,                        -- 0: Zone Imaging, 1: Compound Imaging

           zone_azi => azimuth_zones,                                           -- How many zones the user wants in the azi direction.
           zone_elev => elevation_zones,                                        -- How many zones does the user want in the elev direction.
           run_cnt => run_cnt,                                                  -- # of zones or compounded images
           zone_width => zone_width,                                            -- width of a zone
           zone_height => zone_height,                                          -- height of a zone
           zone_origin_base_pointer => zone_origin_base_pointer,                -- Starting point in zone_origins LUT
           compound_origin_base_pointer => compound_origin_base_pointer,        -- Starting point in compound_origins LUT
           -- Outputs
           tx_out => tx_delay_out,                                              -- Tx Delay output
           out_ready => tx_out_ready                                            -- Indicator that Tx Delay output is valid
             );

-- generate a gen_delay_steer component for every TRANSDUCER_ELEMENTS_Y (row of the transducer)
GEN_DELAY_STEER:
for row in 0 to TRANSDUCER_ELEMENTS_Y - 1 generate
  delay_steer0 : delay_steer
    generic map(
    row => row,
    TRANSDUCER_ELEMENTS_Y => TRANSDUCER_ELEMENTS_Y,
    TRANSDUCER_ELEMENTS_X => TRANSDUCER_ELEMENTS_X
    )
    port map(
    clk            =>  clk,
    tx_delay       =>  tx_delay_out,
    rst_n          =>  rst_n,
    start_nappe    =>  start_nappe,
    start_steering =>  start_steering,
    ref_delay_2    =>  ref_delay_2(row),
    delay          =>  delay_int(row),
    delay_valid    =>  delay_valid_bundle(row),
    end_of_nappe   =>  end_of_nappe_bundle(row),
    tx_offset      =>  tx_offset,
    zone_cnt       =>  zone_cnt_out,
    zone_theta     =>  azimuth_zones,
    zone_width     =>  zone_width,
    zone_height    =>  zone_height
);
end generate GEN_DELAY_STEER;

end_of_nappe <= end_of_nappe_bundle(0);
delay_valid  <= delay_valid_bundle(0);
-- take delays from gen_delay_steer blocks and save them in the output array
PACK:
for COL in 0 to TRANSDUCER_ELEMENTS_X - 1 generate
begin
    PACK2:
    for ROW in 0 to TRANSDUCER_ELEMENTS_Y - 1 generate
    begin
        delay((COL * TRANSDUCER_ELEMENTS_Y + ROW) * 14 + 13 downto (COL * TRANSDUCER_ELEMENTS_Y + ROW) * 14) <= delay_int(ROW)(COL);
    end generate PACK2;
end generate PACK;

-- This process controls the next_nappe signal and the nt_cnt signal. Both are used for timings in the rest of the delay block.
-- The signal nt_cnt_in is the next nappe that the ref delay calculator is ready to calculate,
-- which is incremented when the ref delay calculator finishes the nappe it is currently processing.
-- next_nappe is incremented when the beamformer finishes generating delays for the current nappe, and indicates the next nappe the beamformer will process.
-- It also increments the zone_counter when next_nappe is put to zero. It is necessary to increment zone_counter one nappe early so the 
-- gen_delay constants have time to update for the zone.
next_nappe_control: 
process(clk)
begin
    if rising_edge(clk) then
        if rst_n = '0' then
            next_nappe <= 1;
            nt_cnt <= (others => '0');
            zone_cnt_out <= (others => '0');
        else
            if end_of_nappe = '1' then
                if next_nappe < NO_DEPTH-1 then
                    next_nappe <= next_nappe + 1;
                else
                    next_nappe <= 0;
                    if (to_integer(unsigned(zone_tot)) > 1 and (unsigned(zone_cnt_out) + 1 < unsigned(zone_tot))) then
                        zone_cnt_out <= std_logic_vector(unsigned(zone_cnt_out) + 1);
                    else
                        zone_cnt_out <= (others => '0');
                    end if;
                end if;
                if to_integer(unsigned(nt_cnt)) < NO_DEPTH - 1 then
                    nt_cnt <= std_logic_vector(unsigned(nt_cnt) + 1);
                else
                    nt_cnt <= (others => '0');
                end if;
            end if;
        end if;
    end if;
end process;

-- This process controls the ref_delay calculator. It increments two counters to allow the ref_delay calculator to produce one delay per
-- transducer element. 
-- Initially, the ref_delay calculator starts producing delays as soon as the reset goes high. The first set of delays is produced and saved in 
-- ref_delay_1 (by process ref_delay_out_control) and then immediately latched to the second register (ref_delay_2) and the start_steering signal is 
-- put to 1 to indicate that the beamformer can use the values stored in ref_delay_2 to generate nappe 0. Another set of reference delays is 
-- produced and saved in ref_delay_1. Then the whole process stalls until the gen_delay_steer component has finished (indicated by next_nappe > nt_cnt_in)
-- Once these delays are used, the delays in ref_delay_1 will be transferred to ref_delay_2 and the ref_calculator 
-- will produce new delays to store in ref_delay_1.
ref_delay_in_control:
process(clk)
begin
    if rising_edge(clk) then
        gen_delay_reset_1 <= '1';
        if rst_n = '0' then
            x_cnt_in <= 0;
            y_cnt_in <= 0;
            inp_rdy <= '0';
            gen_delay_reset_1 <= '0';
            stateRin <= reset;
        else
            case stateRin is
                when reset =>
                    inp_rdy <= '1';
                    stateRin <= running;
                when running =>
                    if (TRANSDUCER_ELEMENTS_Y > 1 and y_cnt_in < TRANSDUCER_ELEMENTS_Y - 1) then
                        y_cnt_in <= y_cnt_in + 1;
                    else
                        y_cnt_in <= 0;
                        if x_cnt_in < TRANSDUCER_ELEMENTS_X-1 then
                            x_cnt_in <= x_cnt_in + 1;
                        else
                            x_cnt_in <= 0;
                            stateRin <= waiting;
                        end if;
                    end if;
                when waiting =>
                    -- Wait for both the current nappe to be finished being processed and for ref_delay_out_control to finish
                    -- to synchronize the state machines. Note that we lose some cycles doing this, but gain
                    -- clarity and transparency in the waveforms for debuging processes. Optimizaiton possible.
                    if nt_cnt_in = next_nappe and stateRout = stop and tx_out_ready = '1' then
                        gen_delay_reset_1 <= '0';
                        stateRin <= reset;
                    else
                        stateRin <= waiting;
                    end if;
            end case;
        end if;
    end if;
end process;


-- This process controls the output of the ref_calculator. When the first ref delays are ready, they are stored in ref_delay_1
ref_delay_out_control:
process(clk)
begin
    if rising_edge(clk) then
        gen_delay_reset_2 <= '1';
        if rst_n = '0' then
            ref_x_cnt <= 0;
            ref_y_cnt <= 0;
            start_steering <= '0';
            stateRout <= reset;
            nt_cnt_in <= 0;
            ref_delay_1 <= (others => (others => (others => '0')));
            ref_delay_2 <= (others => (others => (others => '0')));
            gen_delay_reset_2 <= '0';
        else
            case stateRout is
                when reset =>
                    stateRout <= idle;
                when idle =>
                    if ref_delay_rdy = '1' then                                 -- start storing ref_delay values
                        stateRout <= ready;
                        ref_delay_1(ref_y_cnt)(ref_x_cnt) <= ref_delay_res;
                        -- Prepare for the next element already
                        if (TRANSDUCER_ELEMENTS_Y > 1) then
                            ref_y_cnt <= ref_y_cnt + 1;
                            ref_x_cnt <= 0;
                        else
                            ref_y_cnt <= 0;
                            ref_x_cnt <= 1;
                        end if;
                    else
                        stateRout <= idle;
                        ref_y_cnt <= 0;
                        ref_x_cnt <= 0;
                    end if;
                when ready =>                                                   -- continue storing ref delay values for every transducer element
                    ref_delay_1(ref_y_cnt)(ref_x_cnt) <= ref_delay_res;
                    if (TRANSDUCER_ELEMENTS_Y > 1 and ref_y_cnt < TRANSDUCER_ELEMENTS_Y - 1) then
                        ref_y_cnt <= ref_y_cnt + 1;
                    else
                        ref_y_cnt <= 0;
                        if ref_x_cnt < TRANSDUCER_ELEMENTS_X - 1 then
                            ref_x_cnt <= ref_x_cnt + 1;
                        else
                            ref_x_cnt <= 0;
                            stateRout <= stop;
                            if nt_cnt_in < NO_DEPTH-1 then
                                nt_cnt_in <= nt_cnt_in + 1;                     -- nt_cnt_in is incremented here, representing the next nappe 
                            else                                                -- the ref delay calculator will calculate delays for
                                nt_cnt_in <= 0;
                            end if;
                        end if;
                    end if;
                when stop =>
                    -- TODO at boot, despite a very long wait, tx_out_ready stays low, while this FSM is in stop.
                    -- Thus start_steering stays low. At the beginning of operation (first start_nappe) this FSM must
                    -- do a full cycle again to raise start_steering, with the result that master_enable ends up
                    -- staying up for too long. This causes the TX module to get misaligned (see azimuth_pointer).
                    if tx_out_ready = '1' then
                        start_steering <= '1';                                      -- a whole set of reference delays is produced. steering can start         
                        if nt_cnt_in = next_nappe then                              -- When we have finished the current nappe (next nappe is incremented)
                            ref_delay_2 <= ref_delay_1;                             -- Latch the delays in ref_delay_1 to ref_delay_2 and begin 
                            gen_delay_reset_2 <= '0';                               -- calculating delays for nappe nt_cnt_in
                            stateRout <= reset;
                        else
                            stateRout <= stop;
                        end if;
                    end if;
            end case;
        end if;
    end if;
end process;


-- This process translates the user's commands about the custom options for zone imaging and compounding in useful signals for the rest of the block
process(clk)
    begin
    if rising_edge(clk) then
        if rst_n='0' then
            zone_width <= (others=>'0');
            zone_height <= (others=>'0');
            zone_origin_base_pointer <= (others => '0');
            compound_origin_base_pointer <= (others => '0');
            run_cnt <= (others =>'0');
            tx_offset <= (others => '0');
        else
           if compound_not_zone_imaging = '0' then
                -- TODO some of this code is not parametric and not compact
                if azimuth_zones = "0001" then
                    zone_width <= std_logic_vector(to_unsigned(NO_THETA, 7));
                    tx_offset <= tx_offsets(0);
                elsif azimuth_zones = "0010" then
                    zone_width <= std_logic_vector(to_unsigned(NO_THETA / 2, 7));
                    tx_offset <= tx_offsets(1);
                elsif azimuth_zones = "0100" then
                    zone_width <= std_logic_vector(to_unsigned(NO_THETA / 4, 7));
                    tx_offset <= tx_offsets(2);
                elsif azimuth_zones = "1000" then
                    zone_width <= std_logic_vector(to_unsigned(NO_THETA / 8, 7));
                    tx_offset <= tx_offsets(3);
                end if;
                if elevation_zones = "0001" then
                    zone_height <= std_logic_vector(to_unsigned(NO_PHI, 7));
                elsif elevation_zones = "0010" then
                    zone_height <= std_logic_vector(to_unsigned(NO_PHI / 2, 7));
                elsif elevation_zones = "0100" then
                    zone_height <= std_logic_vector(to_unsigned(NO_PHI / 4, 7));
                elsif elevation_zones = "1000" then
                    zone_height <= std_logic_vector(to_unsigned(NO_PHI / 8, 7));
                end if;
                run_cnt <= zone_tot(6 downto 0);
                -- 3D: offsets 0 (1x1 zones), 1 (2x2 zones), 5 (4x4 zones), 21 (8x8 zones)
                if azimuth_zones = "0001" and elevation_zones = "0001" then
                    zone_origin_base_pointer <= std_logic_vector(to_unsigned(0, 6));
                elsif azimuth_zones = "0010" and elevation_zones = "0010" then
                    zone_origin_base_pointer <= std_logic_vector(to_unsigned(1, 6));
                elsif azimuth_zones = "0100" and elevation_zones = "0100" then
                    zone_origin_base_pointer <= std_logic_vector(to_unsigned(5, 6));
                elsif azimuth_zones = "1000" and elevation_zones = "1000" then
                    zone_origin_base_pointer <= std_logic_vector(to_unsigned(21, 6));
                -- 2D: offsets 0 (1 zone), 1 (2 zones), 3 (4 zones), 7 (8 zones)
                elsif azimuth_zones = "0001" and elevation_zones = "0001" then
                    zone_origin_base_pointer <= std_logic_vector(to_unsigned(0, 6));
                elsif azimuth_zones = "0010" and elevation_zones = "0001" then
                    zone_origin_base_pointer <= std_logic_vector(to_unsigned(1, 6));
                elsif azimuth_zones = "0100" and elevation_zones = "0001" then
                    zone_origin_base_pointer <= std_logic_vector(to_unsigned(3, 6));
                elsif azimuth_zones = "1000" and elevation_zones = "0001" then
                    zone_origin_base_pointer <= std_logic_vector(to_unsigned(7, 6));
                end if;
            elsif compound_not_zone_imaging = '1' then
                zone_width <= std_logic_vector(to_unsigned(NO_THETA, 7));
                zone_height <= std_logic_vector(to_unsigned(NO_PHI, 7));
                run_cnt <= "00" & compounding_count;
                tx_offset <= tx_offsets(4);
                compound_origin_base_pointer <= std_logic_vector(to_unsigned(0, 6));
            end if;

        end if;
    end if;
end process;

end Behavioral;
