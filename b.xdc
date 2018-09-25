## This file is a general .xdc for the Nexys4 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
##Bank = 35, Pin name = IO_L12P_T1_MRCC_35,					Sch name = CLK100MHZ
set_property PACKAGE_PIN E3 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
   set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ten_IBUF] 
    

# Switches
#Bank = 34, Pin name = IO_L21P_T3_DQS_34,					Sch name = SW0
set_property PACKAGE_PIN U9 [get_ports {reset}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {reset}]

#Bank = 34, Pin name = IO_25_34,							Sch name = SW1
set_property PACKAGE_PIN U8 [get_ports {signal}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {signal}]
#Bank = 34, Pin name = IO_L23P_T3_34,						Sch name = SW2
    #set_property PACKAGE_PIN R7 [get_ports {ten}]                    
        #set_property IOSTANDARD LVCMOS33 [get_ports {ten}]
# LEDs
#Bank = 34, Pin name = IO_L24N_T3_34,						Sch name = LED0
set_property PACKAGE_PIN T8 [get_ports {work}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {work}]
#Bank = 34, Pin name = IO_L21N_T3_DQS_34,					Sch name = LED1
set_property PACKAGE_PIN V9 [get_ports {hold_in}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {hold_in}]
#Bank = 34, Pin name = IO_L24P_T3_34,						Sch name = LED2
set_property PACKAGE_PIN R8 [get_ports {mode[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {mode[0]}]
#Bank = 34, Pin name = IO_L23N_T3_34,						Sch name = LED3
set_property PACKAGE_PIN T6 [get_ports {mode[1]}]                    
    set_property IOSTANDARD LVCMOS33 [get_ports {mode[1]}]
#Bank = 34, Pin name = IO_L12P_T1_MRCC_34,					Sch name = LED4
set_property PACKAGE_PIN T5 [get_ports {fin}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {fin}]
#Bank = 34, Pin name = IO_L12N_T1_MRCC_34,					Sch	name = LED5
        set_property PACKAGE_PIN T4 [get_ports {overflow}]                    
            set_property IOSTANDARD LVCMOS33 [get_ports {overflow}]
#Bank = 34, Pin name = IO_L8N_T1_34,						Sch name = LED9
set_property PACKAGE_PIN U3 [get_ports {charge[0]}]                    
      set_property IOSTANDARD LVCMOS33 [get_ports {charge[0]}]
#Bank = 34, Pin name = IO_L7N_T1_34,                        Sch name = LED10
set_property PACKAGE_PIN V1 [get_ports {charge[1]}]                    
      set_property IOSTANDARD LVCMOS33 [get_ports {charge[1]}]
#Bank = 34, Pin name = IO_L17P_T2_34,                        Sch name = LED11
set_property PACKAGE_PIN R1 [get_ports {charge[2]}]                    
      set_property IOSTANDARD LVCMOS33 [get_ports {charge[2]}]
#Bank = 34, Pin name = IO_L13N_T2_MRCC_34,                    Sch name = LED12
set_property PACKAGE_PIN P5 [get_ports {charge[3]}]                    
      set_property IOSTANDARD LVCMOS33 [get_ports {charge[3]}]
#Bank = 34, Pin name = IO_L7P_T1_34,						Sch name = LED13
    set_property PACKAGE_PIN U1 [get_ports {state[0]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {state[0]}]
#Bank = 34, Pin name = IO_L15N_T2_DQS_34,                    Sch name = LED14
    set_property PACKAGE_PIN R2 [get_ports {state[1]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {state[1]}]
#Bank = 34, Pin name = IO_L15P_T2_DQS_34,                    Sch name = LED15
    set_property PACKAGE_PIN P2 [get_ports {state[2]}]                    
        set_property IOSTANDARD LVCMOS33 [get_ports {state[2]}]


#7 showment display
#Bank = 34, Pin name = IO_L2N_T0_34,						Sch name = CA
set_property PACKAGE_PIN L3 [get_ports {show[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {show[0]}]
#Bank = 34, Pin name = IO_L3N_T0_DQS_34,					Sch name = CB
set_property PACKAGE_PIN N1 [get_ports {show[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {show[1]}]
#Bank = 34, Pin name = IO_L6N_T0_VREF_34,					Sch name = CC
set_property PACKAGE_PIN L5 [get_ports {show[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {show[2]}]
#Bank = 34, Pin name = IO_L5N_T0_34,						Sch name = CD
set_property PACKAGE_PIN L4 [get_ports {show[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {show[3]}]
#Bank = 34, Pin name = IO_L2P_T0_34,						Sch name = CE
set_property PACKAGE_PIN K3 [get_ports {show[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {show[4]}]
#Bank = 34, Pin name = IO_L4N_T0_34,						Sch name = CF
set_property PACKAGE_PIN M2 [get_ports {show[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {show[5]}]
#Bank = 34, Pin name = IO_L6P_T0_34,						Sch name = CG
set_property PACKAGE_PIN L6 [get_ports {show[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {show[6]}]

#Bank = 34, Pin name = IO_L16P_T2_34,						Sch name = DP
set_property PACKAGE_PIN M4 [get_ports show[7]]							
	set_property IOSTANDARD LVCMOS33 [get_ports show[7]]

#Bank = 34, Pin name = IO_L18N_T2_34,						Sch name = AN0
set_property PACKAGE_PIN N6 [get_ports {en[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {en[0]}]
#Bank = 34, Pin name = IO_L18P_T2_34,						Sch name = AN1
set_property PACKAGE_PIN M6 [get_ports {en[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {en[1]}]
#Bank = 34, Pin name = IO_L4P_T0_34,						Sch name = AN2
set_property PACKAGE_PIN M3 [get_ports {en[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {en[2]}]
#Bank = 34, Pin name = IO_L13_T2_MRCC_34,					Sch name = AN3
set_property PACKAGE_PIN N5 [get_ports {en[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {en[3]}]
#Bank = 34, Pin name = IO_L3P_T0_DQS_34,					Sch name = AN4
set_property PACKAGE_PIN N2 [get_ports {en[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {en[4]}]
#Bank = 34, Pin name = IO_L16N_T2_34,						Sch name = AN5
set_property PACKAGE_PIN N4 [get_ports {en[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {en[5]}]
#Bank = 34, Pin name = IO_L1P_T0_34,						Sch name = AN6
set_property PACKAGE_PIN L1 [get_ports {en[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {en[6]}]
#Bank = 34, Pin name = IO_L1N_T034,							Sch name = AN7
set_property PACKAGE_PIN M1 [get_ports {en[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {en[7]}]



##Buttons
##Bank = 15, Pin name = IO_L3P_T0_DQS_AD1P_15,				Sch name = CPU_RESET
#set_property PACKAGE_PIN C12 [get_ports btnCpuReset]				
	#set_property IOSTANDARD LVCMOS33 [get_ports btnCpuReset]
##Bank = 15, Pin name = IO_L11N_T1_SRCC_15,					Sch name = BTNC
set_property PACKAGE_PIN E16 [get_ports cancel_flag]						
	set_property IOSTANDARD LVCMOS33 [get_ports cancel_flag]
##Bank = 15, Pin name = IO_L14P_T2_SRCC_15,					Sch name = BTNU
set_property PACKAGE_PIN F15 [get_ports one]						
	set_property IOSTANDARD LVCMOS33 [get_ports one]
##Bank = CONFIG, Pin name = IO_L15N_T2_DQS_DOUT_CSO_B_14,	Sch name = BTNL
set_property PACKAGE_PIN T16 [get_ports high]						
	set_property IOSTANDARD LVCMOS33 [get_ports high]
##Bank = 14, Pin name = IO_25_14,							Sch name = BTNR
set_property PACKAGE_PIN R10 [get_ports low]						
	set_property IOSTANDARD LVCMOS33 [get_ports low]
##Bank = 14, Pin name = IO_L21P_T3_DQS_14,					Sch name = BTND
set_property PACKAGE_PIN V10 [get_ports ten]						
	set_property IOSTANDARD LVCMOS33 [get_ports ten]
 


