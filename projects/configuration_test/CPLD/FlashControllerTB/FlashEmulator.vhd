------------------------------------------------------------------------
--
--  NETFPGA-10G www.netfpga.org
--
--  Module:
--          FlashEmulator.vhd
--
--  Description:
--          Emulates some of the functions of the XCF128XFTG64C Platform flash.
--          We model only 4096 words of flash (otherwise emulation and initialisation
--          would take too long by far. The address space, 12 bits, is taken as being 
--          eight bits at the top end, and four bits at the other. The other ten
--          bits in the supplied address address data are reckoned as zeros.
--                 
--  Revision history:
--          08/07/2011date Mark Grindell First Edition
--          date author description
--          date author description
--
--  Known issues:
--          This emulation does not include ANY timing information, nor does it cover
--          any functions beyond read electronic signature, read and write in single
--          byte synchronous mode.
--
--  Library: only need ieee.std_logic_1164 and ieee.std_logic_arith.
--
------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FlashEmulator is
    Port ( A  : in    STD_LOGIC_VECTOR (23 downto 0);
           DQ : inout STD_LOGIC_VECTOR (15 downto 0);
           E  : in    STD_LOGIC;
           G  : in    STD_LOGIC;
           W  : in    STD_LOGIC;
           WP : in    STD_LOGIC;
           K  : in    STD_LOGIC;
           L  : in    STD_LOGIC;
           RW : in    STD_LOGIC);
end FlashEmulator;

architecture Behavioral of FlashEmulator is

subtype elements is std_logic_vector(15 downto 0);
subtype BlockLocksTyp is std_logic_vector (130 downto 0);
type memory_array is array (4095 downto 0) of std_logic_vector(15 downto 0);-- elements;

signal memory          : memory_array;
signal command         : std_logic_vector (15 downto 0);
signal address         : std_logic_vector (23 downto 0);
signal actual_address  : natural;--std_logic_vector (11 downto 0);
signal address_defined : std_logic := '0';
signal BlockLocks      : BlockLocksTyp;
signal StatusRegister  : std_logic_vector (7 downto 0);

constant ActualElectronicSignature : std_logic_vector (15 downto 0) := x"0009";
constant CPLD_CLK_period           : time := 10 ns;
   
constant BlockLockConfirm  : std_logic_vector (7 downto 0) := x"01";
constant SetConfRegConfirm : std_logic_vector (7 downto 0) := x"03";
constant AltProgramSetup   : std_logic_vector (7 downto 0) := x"10";
constant BlockEraseSetup   : std_logic_vector (7 downto 0) := x"20";
constant LockDownConfirm   : std_logic_vector (7 downto 0) := x"2F";
constant ProgramSetup      : std_logic_vector (7 downto 0) := x"40";
constant ClearStatusReg    : std_logic_vector (7 downto 0) := x"50";
constant BlockLockSetup    : std_logic_vector (7 downto 0) := x"60";
constant ReadStatusReg     : std_logic_vector (7 downto 0) := x"70";
constant EnhancedSetup     : std_logic_vector (7 downto 0) := x"80";
constant ReadElecSignature : std_logic_vector (7 downto 0) := x"90";
constant ReadCFIQuery      : std_logic_vector (7 downto 0) := x"98";
constant ProgEraseSuspend  : std_logic_vector (7 downto 0) := x"B0";
constant BlankCheckSetup   : std_logic_vector (7 downto 0) := x"BC";
constant ProtRegProgram    : std_logic_vector (7 downto 0) := x"C0";
constant BlankCheckConfirm : std_logic_vector (7 downto 0) := x"CB";
constant ResumeConfirm     : std_logic_vector (7 downto 0) := x"D0";
constant BufferProgram     : std_logic_vector (7 downto 0) := x"E8";
constant ReadArray         : std_logic_vector (7 downto 0) := x"FF";

type StimulusTyp is (StimulusBlockLockConfirm,
                     StimulusSetConfRegConfirm,
                     StimulusAltProgramSetup,
                     StimulusBlockEraseSetup,
                     StimulusLockDownConfirm,
                     StimulusProgramSetup,
                     StimulusClearStatusReg,
                     StimulusBlockLockSetup,
                     StimulusReadStatusReg,
                     StimulusEnhancedSetup,
                     StimulusReadElecSignature,
                     StimulusReadCFIQuery,
                     StimulusProgEraseSuspend,
                     StimulusBlankCheckSetup,
                     StimulusProtRegProgram,
                     StimulusBlankCheckConfirm,
                     StimulusResumeConfirm,
                     StimulusEnhancedConfirm,
                     StimulusBufferProgram,
                     StimulusReadArray,
                     StimulusArbitraryWrite,
                     StimulusArbitraryRead,
                     StimulusReadStatusRegister,
                     StimulusReadElectronicSignature);
type ReadbackStatusTyp is (ReadData, ReadStatus);
signal ReadBackStatus : ReadBackStatusTyp;

type state_type is (Ready, 
                    ElectronicSignatureState0,
                    WriteState0, WriteState1, WriteState2, 
                    BlankCheck0, 
                    ReadState0, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27);
signal current_state : state_type;
signal next_state 	 : state_type;
signal Stimulus : StimulusTyp;
signal DataRegister : std_logic_vector (15 downto 0);

function arbitrary_write (Stimulus : StimulusTyp) return boolean is
begin
  if (Stimulus = StimulusBlockLockConfirm) or (Stimulus = StimulusSetConfRegConfirm) or
     (Stimulus = StimulusAltProgramSetup)  or (Stimulus = StimulusBlockEraseSetup) or
     (Stimulus = StimulusBlockLockConfirm) or (Stimulus = StimulusProgramSetup) or
     (Stimulus = StimulusClearStatusReg)   or (Stimulus = StimulusBlockLockSetup) or
     (Stimulus = StimulusReadStatusReg)    or (Stimulus = StimulusEnhancedSetup) or
     (Stimulus = StimulusReadElecSignature)or (Stimulus = StimulusReadCFIQuery) or
     (Stimulus = StimulusProgEraseSuspend) or (Stimulus = StimulusBlankCheckSetup) or
     (Stimulus = StimulusProtRegProgram)   or (Stimulus = StimulusBlankCheckConfirm) or
     (Stimulus = StimulusResumeConfirm)    or (Stimulus = StimulusEnhancedConfirm) or
     (Stimulus = StimulusBufferProgram)    or (Stimulus = StimulusReadArray) or
     (Stimulus = StimulusArbitraryWrite)
  then
    return true;
  else
    return false;
  end if;    
end;

function conv_natural (a : std_logic) return natural is
begin
  if a = '0'
  then
    return 0;
  else
    return 1;
  end if;
end;

function address_is_protected (a : std_logic_vector (23 downto 0);
                               BlockLocks : BlockLocksTyp) return boolean is
  variable page : natural;
begin
  page := 256 * conv_natural (a(22)) + 
          128 * conv_natural (a(21)) + 
           64 * conv_natural (a(20)) + 
           32 * conv_natural (a(19)) + 
           16 * conv_natural (a(18)) + 
            8 * conv_natural (a(17)) +   
            4 * conv_natural (a(16)) +  
            2 * conv_natural (a(15)) +  
            1 * conv_natural (a(14)); 

  if page >= 4              -- The object of this calculation is as follows; the 
  then                      -- The first 4 pages ae 64kbits in length; all those 
    page := 3 + (page / 4); -- following are 256kbits, four times larger.
  end if;  
  return BlockLocks (page) = '1';
end;

begin
  process (K) is
  begin
    actual_address <= natural (1) * conv_natural (a (0)) +
                      natural (2) * conv_natural (a (1)) +
                      natural (4) * conv_natural (a (2)) +
                      natural (8) * conv_natural (a (3)) +
                      natural (16) * conv_natural (a (15)) +
                      natural (32) * conv_natural (a (16)) +
                      natural (64) * conv_natural (a (17)) +
                      natural (128) * conv_natural (a (18)) +
                      natural (256) * conv_natural (a (19)) +
                      natural (512) * conv_natural (a (20)) +
                      natural (1024) * conv_natural (a (21)) +
                      natural (2048) * conv_natural (a (22));
                        
    if (L = '0') and (E = '0')
    then
      address <= A;
      address_defined <= '1';
    end if;
    
    if (K'event and K = '1')
    then
      if (G = '0') and (E = '0')
      then
        if ReadBackStatus = ReadData
        then
          if address_defined = '1'
          then
            DQ <= DataRegister; --memory(actual_address);
          else
            DQ <= (others => 'X');
          end if;
        else
          DQ (15 downto 8) <= (others => '0');
          DQ (7 downto 0) <= StatusRegister;
        end if;
        Stimulus <= StimulusArbitraryRead;
      else
        DQ <= (others => 'Z');
      end if;
      
      if (G = '1') and (E = '0') and (W = '0')
      then
        if (address_defined = '1') or (L = '0')
        then
          case DQ (7 downto 0) is
            when BlockLockConfirm  => Stimulus <= StimulusBlockLockConfirm;
            when SetConfRegConfirm => Stimulus <= StimulusSetConfRegConfirm;
            when AltProgramSetup   => Stimulus <= StimulusAltProgramSetup;
            when BlockEraseSetup   => Stimulus <= StimulusBlockEraseSetup;
            when LockDownConfirm   => Stimulus <= StimulusBlockLockConfirm;
            when ProgramSetup      => Stimulus <= StimulusProgramSetup;
            when ClearStatusReg    => Stimulus <= StimulusClearStatusReg;
            when BlockLockSetup    => Stimulus <= StimulusBlockLockSetup;
            when ReadStatusReg     => Stimulus <= StimulusReadStatusReg;
            when EnhancedSetup     => Stimulus <= StimulusEnhancedSetup;
            when ReadElecSignature => Stimulus <= StimulusReadElecSignature;
            when ReadCFIQuery      => Stimulus <= StimulusReadCFIQuery;
            when ProgEraseSuspend  => Stimulus <= StimulusProgEraseSuspend;
            when BlankCheckSetup   => Stimulus <= StimulusBlankCheckSetup;
            when ProtRegProgram    => Stimulus <= StimulusProtRegProgram;
            when BlankCheckConfirm => Stimulus <= StimulusBlankCheckConfirm;
            when ResumeConfirm     => Stimulus <= StimulusResumeConfirm;
            when BufferProgram     => Stimulus <= StimulusBufferProgram;
            when ReadArray         => Stimulus <= StimulusReadArray;
            when others            => Stimulus <= StimulusArbitraryWrite;
          end case;
        end if;
      end if;
    end if;
  end process;
    
  process (k) is
  begin
    case current_state is
      when Ready => 
        case Stimulus is
          when StimulusProgramSetup =>
            next_state <= WriteState0;
            ReadBackStatus <= ReadStatus;
          when StimulusReadElecSignature =>
            next_state <= ElectronicSignatureState0;
            DataRegister <= ActualElectronicSignature;
          when StimulusReadArray =>
            next_state <= ReadState0;
          when others =>
        end case;
      when WriteState0 =>             -- This state progression comes
        if arbitrary_write (Stimulus) -- the diagram on page 53, Figure 31
        then                          -- of the platform flash data sheet
          next_state <= ready;
   --       next_state <= WriteState1;
          report "Got to the first state"
          severity note;      
          if address_is_protected (A, BlockLocks)
          then
            StatusRegister (1) <= '1';
          else
            StatusRegister (1) <= '0';
            memory (actual_address) <= DQ;
          end if;
        end if;
      when ReadState0 => 
        report "Got to the first read state"
        severity note;
        DataRegister <= memory (actual_address);
        ReadBackStatus <= ReadData;
        next_State <= ready;

      when WriteState2 => 
      
      when ElectronicSignatureState0 =>
       next_state <= ready;
       
      when BlankCheck0 =>
        
      when others =>
        
    end case;
    if (K'event and K = '1')
    then
--    wait for CPLD_CLK_period/2;
      Current_State <= Next_State;
--    wait for CPLD_CLK_period/2;
    end if;
  end process;
end Behavioral;

