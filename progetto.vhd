----------------------------------------------------------------------------------
-- Prova finale di Reti Logiche
-- a.a. 2022/23
-- Prof. Fabio Salice

-- studenti:
--      Irene Lo Presti
--      Matteo Lussana
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity project_reti_logiche is
port (
    i_clk : in std_logic;
    i_rst : in std_logic;
    i_start : in std_logic;
    i_w : in std_logic;
    o_z0 : out std_logic_vector(7 downto 0);
    o_z1 : out std_logic_vector(7 downto 0);
    o_z2 : out std_logic_vector(7 downto 0);
    o_z3 : out std_logic_vector(7 downto 0);
    o_done : out std_logic;
    o_mem_addr : out std_logic_vector(15 downto 0);
    i_mem_data : in std_logic_vector(7 downto 0);
    o_mem_we : out std_logic;
    o_mem_en : out std_logic
);
end project_reti_logiche;


architecture Behavioral of project_reti_logiche is
component datapath is
    Port(
          i_clk : in std_logic;
          i_rst : in std_logic;
          i_start : in std_logic;
          i_w : in std_logic;
          o_z0 : out std_logic_vector(7 downto 0);
          o_z1 : out std_logic_vector(7 downto 0);
          o_z2 : out std_logic_vector(7 downto 0);
          o_z3 : out std_logic_vector(7 downto 0);
          o_done : out std_logic;
          o_mem_addr : out std_logic_vector(15 downto 0);
          i_mem_data : in std_logic_vector(7 downto 0);
          o_mem_we : out std_logic;
          o_mem_en : out std_logic;
          
          --segnali di enable
          e_d0 : in std_logic ;
          e_3 : in std_logic ;
          i_mem_en : in std_logic ;
          
          --selettori
          d0_sel : in std_logic ;
          r1_sel : in std_logic ;
          r2_sel : in std_logic ;
          
          --segnali di load
          r1_load : in std_logic ;
          r2_load : in std_logic ;
          rz0_load : in std_logic;
          rz1_load : in std_logic;
          rz2_load : in std_logic;
          rz3_load : in std_logic; 
          
           i_end : in std_logic);
end component;

signal e_d0 : std_logic ;
signal e_3 : std_logic ;
signal i_mem_en : std_logic;

signal d0_sel : std_logic ;
signal r1_sel : std_logic ;
signal r2_sel : std_logic ;

signal r1_load : std_logic ;
signal r2_load : std_logic ;
signal rz0_load : std_logic;
signal rz1_load : std_logic;
signal rz2_load : std_logic;
signal rz3_load : std_logic;

signal i_end : std_logic;


type S is (S0, S1, S2, S3, S4, S5, S6, S7a, S7b, S7c, S7d, S8a, S8b, S8c, S8d, 
        S9a, S9b, S9c, S9d, S10a, S10b, S10c, S10d, S11a, S11b, S11c, S11d) ;
signal cur_state, next_state : S ;

begin
    DATAPATH0: datapath port map(
          i_clk,
          i_rst,
          i_start,
          i_w,
          o_z0,
          o_z1,
          o_z2,
          o_z3,
          o_done,
          o_mem_addr,
          i_mem_data,
          o_mem_we,
          o_mem_en,
          
          e_d0,
          e_3 ,
          i_mem_en,
          
          d0_sel,
          r1_sel,
          r2_sel,
          
          r1_load,
          r2_load,
          rz0_load,
          rz1_load,
          rz2_load,
          rz3_load,
          
          i_end
     );
     
    process(i_clk, i_rst)
    begin
        if(i_rst = '1') then
            cur_state <= S0;
        elsif i_clk'event and i_clk = '1' then
            cur_state <= next_state;
        end if;
    end process;
    
    process(cur_state, i_start, i_w)
    begin
        next_state <= cur_state;
        case cur_state is
            when S0 =>
                if i_start = '1' and i_w = '0' then
                    next_state <= S1;
                 elsif i_start = '1' and i_w = '1' then
                    next_state <= S2;
                end if;
            when S1 =>
                if i_start = '1' and i_w = '0' then
                    next_state <= S3;
                elsif i_start = '1' and i_w = '1' then
                    next_state <= S4;    
                end if;
            when S2 =>
                if i_start = '1' and i_w = '0' then    
                    next_state <= S5;
                elsif i_start = '1' and i_w = '1' then
                    next_state <= S6;
                end if;
            when S3 =>
                if i_start = '0' then    
                    next_state <= S8a;
                elsif i_start = '1' then
                    next_state <= S7a;
                end if;
            when S4 =>
                if i_start = '0' then    
                    next_state <= S8b;
                elsif i_start = '1' then
                    next_state <= S7b;
                end if;
            when S5 =>
                if i_start = '0' then    
                    next_state <= S8c;
                elsif i_start = '1' then
                    next_state <= S7c;
                end if;
            when S6 =>
                if i_start = '0' then    
                    next_state <= S8d;
                elsif i_start = '1' then
                    next_state <= S7d;
                end if;
            when S7a =>
                if i_start = '0' then    
                    next_state <= S8a;
                elsif i_start = '1' then
                    next_state <= S7a;
                end if;
            when S7b =>
                if i_start = '0' then    
                    next_state <= S8b;
                elsif i_start = '1' then
                    next_state <= S7b;
                end if;
            when S7c =>
                if i_start = '0' then    
                    next_state <= S8c;
                elsif i_start = '1' then
                    next_state <= S7c;
                end if;
            when S7d =>
                if i_start = '0' then    
                    next_state <= S8d;
                elsif i_start = '1' then
                    next_state <= S7d;
                end if;
            when S8a =>
                if i_start = '0' then
                    next_state <= S9a;
                end if;
            when S8b =>
                if i_start = '0' then
                    next_state <= S9b;
                end if;
            when S8c =>
                if i_start = '0' then
                    next_state <= S9c;
                end if;
            when S8d =>
                if i_start = '0' then
                    next_state <= S9d;
                end if;
            when S9a =>
              if i_start = '0' then    
                next_state <= S10a;
               end if; 
            when S9b =>
             if i_start = '0' then    
               next_state <= S10b;
              end if;
            when S9c =>
                if i_start = '0' then    
                  next_state <= S10c;
                 end if;
            when S9d =>
               if i_start = '0' then    
                 next_state <= S10d;
                end if;
            when S10a =>
                if i_start = '0' then    
                    next_state <= S11a;
                end if;
            when S10b =>
                if i_start = '0' then    
                    next_state <= S11b;
                end if;
            when S10c =>
                if i_start = '0' then    
                    next_state <= S11c;
                end if;
            when S10d =>
                if i_start = '0' then    
                    next_state <= S11d;
                end if;
            when S11a =>
                if i_start = '0' then    
                    next_state <= S0;
                end if;
            when S11b =>
                if i_start = '0' then    
                    next_state <= S0;
                end if;
            when S11c =>
                if i_start = '0' then    
                    next_state <= S0;
                end if;
            when S11d =>
                if i_start = '0' then    
                    next_state <= S0;
                end if;
        end case;
    end process;
    
    process(cur_state)
    begin
        --inizializzazione segnali
        e_d0 <= '1';
        e_3 <= '0';
        i_mem_en <= '0';
        
        d0_sel <= '0';
        r1_sel <= '0';
        r2_sel <= '0';
        
        r1_load <= '1';
        r2_load <= '0';
        rz0_load <= '0';
        rz1_load <= '0';
        rz2_load <= '0';
        rz3_load <= '0';
        
        i_end <= '0';
        
        case cur_state is
            when S0 =>
                e_d0 <= '1';
                e_3 <= '0';
                i_mem_en <= '0';
                
                d0_sel <= '0';
                r1_sel <= '0';
                r2_sel <= '0';
                
                r1_load <= '1';
                r2_load <= '0';
                rz0_load <= '0';
                rz1_load <= '0';
                rz2_load <= '0';
                rz3_load <= '0';
                
                i_end <= '0';
                
            when S1 => 
                e_d0 <= '1';
                e_3 <= '0';
                i_mem_en <= '0';
                
                d0_sel <= '0';
                r1_sel <= '1';
                r2_sel <= '0';
                
                r1_load <= '1';
                r2_load <= '0';
                rz0_load <= '0';
                rz1_load <= '0';
                rz2_load <= '0';
                rz3_load <= '0';
                
                i_end <= '0';
                
            when S2 => 
                e_d0 <= '1';
                e_3 <= '0';
                i_mem_en <= '0';
                
                d0_sel <= '0';
                r1_sel <= '1';
                r2_sel <= '0';
                
                r1_load <= '1';
                r2_load <= '0';
                rz0_load <= '0';
                rz1_load <= '0';
                rz2_load <= '0';
                rz3_load <= '0';
                
                i_end <= '0';
                
            when S3 => 
                e_d0 <= '1';
                e_3 <= '0';
                i_mem_en <= '0';
                
                d0_sel <= '1';
                r1_sel <= '1';
                r2_sel <= '0';
                
                r1_load <= '1';
                r2_load <= '1';
                rz0_load <= '1';
                rz1_load <= '0';
                rz2_load <= '0';
                rz3_load <= '0';
                
                i_end <= '0';
                
            when S4 => 
                e_d0 <= '1';
                e_3 <= '0';
                i_mem_en <= '0';
                
                d0_sel <= '1';
                r1_sel <= '1';
                r2_sel <= '0';
                
                r1_load <= '1';
                r2_load <= '1';
                rz0_load <= '0';
                rz1_load <= '1';
                rz2_load <= '0';
                rz3_load <= '0';
                
                i_end <= '0';
            when S5 => 
                e_d0 <= '1';
                e_3 <= '0';
                i_mem_en <= '0';
                
                d0_sel <= '1';
                r1_sel <= '1';
                r2_sel <= '0';
                
                r1_load <= '1';
                r2_load <= '1';
                rz0_load <= '0';
                rz1_load <= '0';
                rz2_load <= '1';
                rz3_load <= '0';
                
                i_end <= '0';
                
            when S6 => 
                e_d0 <= '1';
                e_3 <= '0';
                i_mem_en <= '0';
                
                d0_sel <= '1';
                r1_sel <= '1';
                r2_sel <= '0';
                
                r1_load <= '1';
                r2_load <= '1';
                rz0_load <= '0';
                rz1_load <= '0';
                rz2_load <= '0';
                rz3_load <= '1'; 
                
                i_end <= '0';
   
            when S7d =>
                e_d0 <= '1';
                e_3 <= '0';
                i_mem_en <= '0';
                
                d0_sel <= '1';
                r1_sel <= '0';
                r2_sel <= '1';
                
                r1_load <= '0';
                r2_load <= '1';
                rz0_load <= '0';
                rz1_load <= '0';
                rz2_load <= '0';
                rz3_load <= '1';
                
                i_end <= '0';  
                             
            when S7a =>
                e_d0 <= '1';
                e_3 <= '0';
                i_mem_en <= '0';
                    
                d0_sel <= '1';
                r1_sel <= '0';
                r2_sel <= '1';
                
                r1_load <= '0';
                r2_load <= '1';
                rz0_load <= '1';
                rz1_load <= '0';
                rz2_load <= '0';
                rz3_load <= '0';
                
                i_end <= '0';
  
            when S7b =>
                e_d0 <= '1';
                e_3 <= '0';
                i_mem_en <= '0';
                        
                d0_sel <= '1';
                r1_sel <= '0';
                r2_sel <= '1';
                
                r1_load <= '0';
                r2_load <= '1';
                rz0_load <= '0';
                rz1_load <= '1';
                rz2_load <= '0';
                rz3_load <= '0';
                
                i_end <= '0';
                        
            when S7c =>
                e_d0 <= '1';
                e_3 <= '0';
                i_mem_en <= '0';
                            
                d0_sel <= '1';
                r1_sel <= '0';
                r2_sel <= '1';
                r1_load <= '0';
                r2_load <= '1';
                rz0_load <= '0';
                rz1_load <= '0';
                rz2_load <= '1';
                rz3_load <= '0';
                
                i_end <= '0';
            when S8a =>
                e_d0 <= '0';
                e_3 <= '0';
                i_mem_en <= '1';
                                    
                d0_sel <= '1';
                r1_sel <= '0';
                r2_sel <= '1';
                
                r1_load <= '0';
                r2_load <= '0';
                rz0_load <= '1';
                rz1_load <= '0';
                rz2_load <= '0';
                rz3_load <= '0';
                
                i_end <= '0';
                
            when S8b =>
                e_d0 <= '0';
                e_3 <= '0';
                i_mem_en <= '1';
                                    
                d0_sel <= '1';
                r1_sel <= '0';
                r2_sel <= '1';
                
                r1_load <= '0';
                r2_load <= '0';
                rz0_load <= '0';
                rz1_load <= '1';
                rz2_load <= '0';
                rz3_load <= '0';
                
                i_end <= '0';                 

            when S8c =>  
                e_d0 <= '0';
                e_3 <= '0';
                i_mem_en <= '1';  
                   
                d0_sel <= '1';
                r1_sel <= '0';
                r2_sel <= '1';
                
                r1_load <= '0';
                r2_load <= '0';
                rz0_load <= '0';
                rz1_load <= '0';
                rz2_load <= '1';
                rz3_load <= '0'; 
                
                i_end <= '0';
                
            when S8d =>
                e_d0 <= '0';
                e_3 <= '0';
                i_mem_en <= '1';
                                
                d0_sel <= '1';
                r1_sel <= '0';
                r2_sel <= '1';
                r1_load <= '0';
                r2_load <= '0';
                rz0_load <= '0';
                rz1_load <= '0';
                rz2_load <= '0';
                rz3_load <= '1';  
                
                i_end <= '0';                            
                
            when S9a => 
                e_d0 <= '0';
                e_3 <= '1';
                i_mem_en <= '1';
                
                d0_sel <= '1';
                r1_sel <= '0';
                r2_sel <= '1';
                r1_load <= '0';
                r2_load <= '0';
                rz0_load <= '1';
                rz1_load <= '0';
                rz2_load <= '0';
                rz3_load <= '0';
                
                i_end <= '0';
                
            when S9b => 
                e_d0 <= '0';
                e_3 <= '1';
                i_mem_en <= '1';
                            
                d0_sel <= '1';
                r1_sel <= '0';
                r2_sel <= '1';
                
                r1_load <= '0';
                r2_load <= '0';                
                rz0_load <= '0';
                rz1_load <= '1';
                rz2_load <= '0';
                rz3_load <= '0';
                
                i_end <= '0';
                
            when S9c => 
                e_d0 <= '0';
                e_3 <= '1';
                i_mem_en <= '1';
                            
                d0_sel <= '1';
                r1_sel <= '0';
                r2_sel <= '1';
                
                r1_load <= '0';
                r2_load <= '0';
                rz0_load <= '0';
                rz1_load <= '0';
                rz2_load <= '1';
                rz3_load <= '0';
                
                i_end <= '0';

            when S9d => 
                e_d0 <= '0';
                e_3 <= '1';
                i_mem_en <= '1';
                            
                d0_sel <= '1';
                r1_sel <= '0';
                r2_sel <= '1';
                
                r1_load <= '0';
                r2_load <= '0';
                rz0_load <= '0';
                rz1_load <= '0';
                rz2_load <= '0';
                rz3_load <= '1';  
                
                i_end <= '0';             
                
            when S10a =>
                e_d0 <= '0';
                e_3 <= '1';
                i_mem_en <= '1';
                            
                d0_sel <= '1';
                r1_sel <= '0';
                r2_sel <= '1';
                r1_load <= '0';
                r2_load <= '0';
                rz0_load <= '1';
                rz1_load <= '0';
                rz2_load <= '0';
                rz3_load <= '0';
                
                i_end <= '0';
                
            when S10b =>
                e_d0 <= '0';
                e_3 <= '1';
                i_mem_en <= '1';
                            
                d0_sel <= '1';
                r1_sel <= '0';
                r2_sel <= '1';
                
                r1_load <= '0';
                r2_load <= '0';
                rz0_load <= '0';
                rz1_load <= '1';
                rz2_load <= '0';
                rz3_load <= '0';
                
                i_end <= '0';

            when S10c =>
                e_d0 <= '0';
                e_3 <= '1';
                i_mem_en <= '1';
                            
                d0_sel <= '1';
                r1_sel <= '0';
                r2_sel <= '1';
                
                r1_load <= '0';
                r2_load <= '0';
                rz0_load <= '0';
                rz1_load <= '0';
                rz2_load <= '1';
                rz3_load <= '0';
                
                i_end <= '0';
                
            when S10d =>
                e_d0 <= '0';
                e_3 <= '1';
                i_mem_en <= '1';
                
                d0_sel <= '1';
                r1_sel <= '0';
                r2_sel <= '1';
                
                r1_load <= '0';
                r2_load <= '0';
                rz0_load <= '0';
                rz1_load <= '0';
                rz2_load <= '0';
                rz3_load <= '1';
                
                i_end <= '0';
                
            when S11a => 
                e_d0 <= '0';
                e_3 <= '1';
                i_mem_en <= '1'; 
                              
                d0_sel <= '1';
                r1_sel <= '0';
                r2_sel <= '1';
                
                r1_load <= '0';
                r2_load <= '0';
                rz0_load <= '1';
                rz1_load <= '0';
                rz2_load <= '0';
                rz3_load <= '0';
                
                i_end <= '1';
                
            when S11b =>   
                e_d0 <= '0';
                e_3 <= '1';
                i_mem_en <= '1';
                                         
                d0_sel <= '1';
                r1_sel <= '0';
                r2_sel <= '1';
                
                r1_load <= '0';
                r2_load <= '0';
                rz0_load <= '0';
                rz1_load <= '1';
                rz2_load <= '0';
                rz3_load <= '0';
                
                i_end <= '1';
                
            when S11c =>    
                e_d0 <= '0';
                e_3 <= '1';
                i_mem_en <= '1';  
                          
                d0_sel <= '1';
                r1_sel <= '0';
                r2_sel <= '1';
                
                r1_load <= '0';
                r2_load <= '0';
                rz0_load <= '0';
                rz1_load <= '0';
                rz2_load <= '1';
                rz3_load <= '0';
                
                i_end <= '1';

            when S11d =>
                e_d0 <= '0';
                e_3 <= '1';
                i_mem_en <= '1';
                                            
                d0_sel <= '1';
                r1_sel <= '0';
                r2_sel <= '1';
                
                r1_load <= '0';
                r2_load <= '0';
                rz0_load <= '0';
                rz1_load <= '0';
                rz2_load <= '0';
                rz3_load <= '1';
                
                i_end <= '1';
        end case;
    end process;           
             
end Behavioral;



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity datapath is
    Port( i_clk : in std_logic;
          i_rst : in std_logic;
          i_start : in std_logic;
          i_w : in std_logic;
          o_z0 : out std_logic_vector(7 downto 0);
          o_z1 : out std_logic_vector(7 downto 0);
          o_z2 : out std_logic_vector(7 downto 0);
          o_z3 : out std_logic_vector(7 downto 0);
          o_done : out std_logic;
          o_mem_addr : out std_logic_vector(15 downto 0);
          i_mem_data : in std_logic_vector(7 downto 0);
          o_mem_we : out std_logic;
          o_mem_en : out std_logic;
          
          --segnali di enable
            e_d0 : in std_logic ;
            e_3 : in std_logic ;
            i_mem_en : in std_logic ;
            
            --selettori
            d0_sel : in std_logic ;
            r1_sel : in std_logic ;
            r2_sel : in std_logic ;
            
            --segnali di load
            r1_load : in std_logic ;
            r2_load : in std_logic ;
            rz0_load : in std_logic;
            rz1_load : in std_logic;
            rz2_load : in std_logic;
            rz3_load : in std_logic; 
            
            i_end : in std_logic);
       
    
end datapath;

architecture Behavioral of datapath is
signal mux0_dmx0 : std_logic ;
signal dmx0_sum1 : std_logic ;
signal dmx0_sum2 : std_logic ;

signal mux1_r1 : std_logic_vector (1 downto 0);
signal o_r1 : std_logic_vector (1 downto 0);
signal mult1_sum1 : std_logic_vector (3 downto 0);
signal sum1_mux1 : std_logic_vector (1 downto 0);

signal mux2_r2 : std_logic_vector (15 downto 0);
signal o_r2: std_logic_vector (15 downto 0);
signal mult2_sum2 : std_logic_vector (17 downto 0);
signal sum2_mux2 : std_logic_vector (15 downto 0);

signal r1_dmx3 : std_logic_vector (1 downto 0);
signal mem_dmx3 : std_logic_vector (7 downto 0);
signal dmx3_rz0 : std_logic_vector (7 downto 0);
signal rz0_muxz0 : std_logic_vector (7 downto 0);
signal dmx3_rz1 : std_logic_vector (7 downto 0);
signal rz1_muxz1 : std_logic_vector (7 downto 0);
signal dmx3_rz2 : std_logic_vector (7 downto 0);
signal rz2_muxz2 : std_logic_vector (7 downto 0);
signal dmx3_rz3 : std_logic_vector (7 downto 0);
signal rz3_muxz3 : std_logic_vector (7 downto 0);

begin
    
    --mux 0
   with i_start select
   mux0_dmx0 <= '0' when '0',
                i_w when '1',
                'X' when others;
   
   --demultiplexer 0               
   process(i_clk, e_d0, d0_sel, mux0_dmx0)
   begin
    if i_clk'event and i_clk = '1' then
      if(e_d0 = '1') then
           if(d0_sel='0') then
               dmx0_sum1 <= mux0_dmx0;
               dmx0_sum2 <= '0';
           else
               dmx0_sum1 <= '0';
               dmx0_sum2 <= mux0_dmx0;
           end if;
       else
           dmx0_sum1 <= '0';
           dmx0_sum2 <= '0';
      end if;
    end if;
   end process;
    
    -------------------------------------------------------------------------------------------
    
    --mux 1
        with r1_sel select
        mux1_r1 <= "00" when '0',
                    sum1_mux1 when '1',
                    "XX" when others;
                
    --reg 1
        process(i_clk, i_rst)
        begin
            if(i_rst='1') then
                o_r1 <= "00";
           elsif i_clk'event and i_clk = '0' then
                if(r1_load = '1') then
                    o_r1 <= mux1_r1;
               end if;
            end if;
        end process;
    
    --mult 1 
        mult1_sum1 <= o_r1 * "10";
    
    --sum 1
        sum1_mux1 <= mult1_sum1(1 downto 0) + dmx0_sum1;
    
    --------------------------------------------------------------------------------------------
    
    --mux 2
        with r2_sel select
        mux2_r2 <= "0000000000000000" when '0',
                    sum2_mux2 when '1',
                    "XXXXXXXXXXXXXXXX" when others ;
    --reg 2
    process(i_clk, i_rst, r2_load)
    begin
        if(i_rst='1') then
            o_r2 <= "0000000000000000";
       elsif i_clk'event and i_clk = '0' then
            if(r2_load = '1') then
                o_r2 <= mux2_r2;
           end if;
        end if;
    end process;
    
    --mult 2 
    mult2_sum2 <= o_r2 * "10";
    
    --sum 2
    sum2_mux2 <= mult2_sum2(15 downto 0) + dmx0_sum2;
    
    ---------------------------------------------------------------------------------------------------
        
        --indirizzo mem
            process(i_clk, i_start, i_mem_en, o_r2)
            begin
                if (i_clk'event and i_clk = '0' ) then
                    if(i_start = '0' and i_mem_en = '1') then
                        o_mem_addr <= o_r2;
                    else
                        o_mem_addr <= "0000000000000000";
                    end if;
                end if;
            end process;
            
            with i_mem_en select
            o_mem_en <= '1' when '1',
                        '0' when '0',
                        'X' when others;
        
        
        --demultiplexer 3
        process(mem_dmx3, o_r1, e_3, i_rst, i_clk, i_mem_en, i_mem_data)
        begin
            if(i_rst = '1') then
                    dmx3_rz0 <= "00000000";
                    dmx3_rz1 <= "00000000";
                    dmx3_rz2 <= "00000000";
                    dmx3_rz3 <= "00000000";
            elsif (i_clk'event and i_clk = '0') then
                if(e_3 = '1' and i_mem_en = '1') then
                    if(o_r1="00") then
                        dmx3_rz0 <= i_mem_data;
                        dmx3_rz1 <= "00000000";
                        dmx3_rz2 <= "00000000";
                        dmx3_rz3 <= "00000000";
                    elsif o_r1="01" then
                        dmx3_rz1 <= i_mem_data;
                        dmx3_rz0 <= "00000000";
                        dmx3_rz2 <= "00000000";
                        dmx3_rz3 <= "00000000";
                    elsif o_r1="10" then
                        dmx3_rz2 <= i_mem_data;
                        dmx3_rz1 <= "00000000";
                        dmx3_rz0 <= "00000000";
                        dmx3_rz3 <= "00000000";
                    else
                        dmx3_rz3 <= i_mem_data;
                        dmx3_rz1 <= "00000000";
                        dmx3_rz2 <= "00000000";
                        dmx3_rz0 <= "00000000";
                    end if;
                else
                    dmx3_rz0 <= "00000000";
                    dmx3_rz1 <= "00000000";
                    dmx3_rz2 <= "00000000";
                    dmx3_rz3 <= "00000000";                    
               end if;  
            end if;
        end process;
        
        o_mem_we <= '0';
        
        --registri delle uscite
        process(i_clk, i_rst, rz0_load, dmx3_rz0)
            begin
                if(i_rst='1') then
                    rz0_muxz0 <= "00000000";
                elsif (i_clk'event and i_clk = '0') then
                    if(rz0_load = '1') then
                        rz0_muxz0 <= dmx3_rz0;
                    end if;
                end if;
            end process;
        process(i_clk, i_rst, rz1_load, dmx3_rz1)
            begin
                if(i_rst='1') then
                    rz1_muxz1 <= "00000000";
                elsif (i_clk'event and i_clk = '0') then
                    if(rz1_load = '1') then
                        rz1_muxz1 <= dmx3_rz1;
                    end if;
                end if;
            end process;
        process(i_clk, i_rst, rz2_load, dmx3_rz2)
            begin
                if(i_rst='1') then
                    rz2_muxz2 <= "00000000";
                elsif i_clk'event and i_clk = '0' then
                    if(rz2_load = '1') then
                        rz2_muxz2 <= dmx3_rz2;
                    end if;
                end if;
            end process;
        process(i_clk, i_rst, rz3_load, dmx3_rz3)
            begin
                if(i_rst='1') then
                    rz3_muxz3 <= "00000000";
                elsif i_clk'event and i_clk = '0' then
                    if(rz3_load = '1') then
                        rz3_muxz3 <= dmx3_rz3;
                    end if;
                end if;
            end process;
                
        --multiplexer uscite
        process(i_clk, i_rst, i_end,rz0_muxz0, rz1_muxz1, rz2_muxz2, rz3_muxz3)
            begin
                if(i_rst = '1') then
                    o_done <= '0';
                    o_z0 <= "00000000";
                    o_z1 <= "00000000";
                    o_z2 <= "00000000";
                    o_z3 <= "00000000";
                elsif(i_end = '0') then
                    o_z0 <= "00000000";
                    o_z1 <= "00000000";
                    o_z2 <= "00000000";
                    o_z3 <= "00000000";
                    o_done <= '0';
                else
                   o_z0 <= rz0_muxz0;
                   o_z1 <= rz1_muxz1;
                   o_z2 <= rz2_muxz2;
                   o_z3 <= rz3_muxz3;
                   o_done <= '1';
                end if;
            end process;
                       
                           
end Behavioral;
