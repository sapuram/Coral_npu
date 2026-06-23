package coralnpu_pkg;
	
	`include "uvm_macros.svh"
	import uvm_pkg::*;
	
	typedef class axi_slave_agent_top;
	typedef class axi_m_agt_top;          // Good practice to add the master too
	typedef class slave_axi_wraddr_agent;
	
	typedef enum logic [1:0] { FIXED = 2'b00, INCR  = 2'b01, WRAP  = 2'b10 } axi_burst_t;
    	typedef enum logic [3:0] { DEVICE_NON_BUFFERABLE = 4'b0000, DEVICE_BUFFERABLE     = 4'b0001, NORMAL_NON_CACHEABLE  = 4'b0010, WRITE_THROUGH_NO_ALLOC= 4'b1010, WRITE_BACK_ALLOCATE   = 4'b1111  } axi_cache_t;
    	typedef enum logic [2:0] { UNPRIVILEGED_SECURE_DATA = 3'b000, PRIVILEGED_SECURE_DATA   = 3'b001, UNPRIVILEGED_NONSECURE_DATA = 3'b010, PRIVILEGED_NONSECURE_DATA   = 3'b011, UNPRIVILEGED_SECURE_INSTR   = 3'b100,
        			   PRIVILEGED_SECURE_INSTR     = 3'b101  } axi_prot_t;
    	typedef enum logic [3:0] { QOS_LOW    = 4'b0000,QOS_MEDIUM = 4'b0100, QOS_HIGH   = 4'b1000, QOS_HIGHEST= 4'b1111 } axi_qos_t;
    	typedef enum logic [3:0] { REGION_0 = 4'b0000, REGION_1 = 4'b0001, REGION_2 = 4'b0010, REGION_3 = 4'b0011 } axi_region_t;
    	typedef enum logic [1:0] { AXI_OKAY   = 2'b00, AXI_EXOKAY = 2'b01, AXI_SLVERR = 2'b10, AXI_DECERR = 2'b11 } axi_resp_t;
	
	//includeing the config files 
	`include "coralnpu_config.sv"
	`include "axi_config.sv"
	`include "axi_wraddr_config.sv"
	`include "axi_wrdata_config.sv"
	`include "axi_wrresp_config.sv"
	`include "slave_axi_rdaddr_config.sv"
	`include "slave_axi_rddata_config.sv"
	
	//AXI_slave and master trans. 
	`include "axi_master_trans.sv"
	`include "axi_xtn.sv"
	
	//AXi_master&slave sequence 
	`include "axi_master_seq.sv"
	`include "slave_axi_wraddr_sequence.sv"
	`include "slave_axi_wrdata_sequence.sv"
	`include "slave_axi_wrresp_sequence.sv"
	`include "slave_axi_rdaddr_sequence.sv"
	`include "slave_axi_rddata_sequence.sv"
	
	
	//axi_m_aw_agents 
	`include "axi_m_aw_seqr.sv"
	`include "axi_m_aw_driver.sv"
	`include "axi_m_aw_monitor.sv"
	`include "axi_m_aw_agent.sv"
	
	//axi_m_w_agent
	`include "axi_m_w_seqr.sv"
	`include "axi_m_w_driver.sv"
	`include "axi_m_w_monitor.sv"
	`include "axi_m_w_agent.sv"
	
	//axi_m_b_agent
	`include "axi_m_b_seqr.sv"
	`include "axi_m_b_driver.sv"
	`include "axi_m_b_monitor.sv"
	`include "axi_m_b_agent.sv"
	
	//axi_m_ar_agent
	`include "axi_m_ar_seqr.sv"
	`include "axi_m_ar_driver.sv"
	`include "axi_m_ar_monitor.sv"
	`include "axi_m_ar_agent.sv"
	
	//axi_m_r_agent
	`include "axi_m_r_seqr.sv"
	`include "axi_m_r_driver.sv"
	`include "axi_m_r_monitor.sv"
	`include "axi_m_r_agent.sv"
	
	
	//axi_slave_wa_agent
	`include "slave_axi_wraddr_seqr.sv"
	`include "slave_axi_wraddr_drv.sv"
	`include "slave_axi_wraddr_mon.sv"
	`include "slave_axi_wraddr_agent.sv"
	
	//axi_salve_w_agent
	`include "slave_axi_wrdata_seqr.sv"
	`include "slave_axi_wrdata_drv.sv"
	`include "slave_axi_wrdata_mon.sv"
	`include "slave_axi_wrdata_agent.sv"
	
	//axi_slave_b_agent
	`include "slave_axi_wrresp_seqr.sv"
	`include "slave_axi_wrresp_drv.sv"
	`include "slave_axi_wrresp_mon.sv"
	`include "slave_axi_wrresp_agent.sv"
	
	//axi_slave_ar_agent
	`include "slave_axi_rdaddr_seqr.sv"
	`include "slave_axi_rdaddr_drv.sv"
	`include "slave_axi_rdaddr_mon.sv"
	`include "slave_axi_rdaddr_agent.sv"
	
	
	//axi_slave_r_agent
	`include "slave_axi_rddata_seqr.sv"
	`include "slave_axi_rddata_drv.sv"
	`include "slave_axi_rddata_mon.sv"
	`include "slave_axi_rddata_agent.sv"
	
	//axi_master_agent_top
	`include "axi_m_agt_top.sv"
	`include "axi_slave_agent_top.sv"
	
	
	
	//coralnpu_files
	`include "coralnpu_env_base.sv"
	`include "coralnpu_test_base.sv"
	
endpackage 
