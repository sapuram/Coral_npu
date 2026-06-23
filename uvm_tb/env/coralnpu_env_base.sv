class coralnpu_env_base extends uvm_env;
	`uvm_component_utils(coralnpu_env_base)
	
	coralnpu_config cfg;
	
	//AXI_slave_config_instance
	axi_config s_main_cfg; 
	axi_wraddr_config aw_cfg;
	axi_wrdata_config w_cfg;
	axi_wrresp_config b_cfg;
	slave_axi_rdaddr_config ar_cfg;
	slave_axi_rddata_config r_cfg;
	
	//AXI_agent_top_instance
	axi_m_agt_top axi_m_agt_h;
	axi_slave_agent_top axi_s_agt_h;
	
	function new(string name="coralnpu_env_base", uvm_component parent);
		super.new(name, parent);
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		//coralnpu_config
		cfg=coralnpu_config::type_id::create("cfg");
		
		//AXI_slave_config
		s_main_cfg= axi_config::type_id::create("s_main_cfg");
		/*aw_cfg=axi_wraddr_config::type_id::create("aw_cfg");
		//w_cfg=axi_wrdata_config::type_id::create("w_cfg");
		//b_cfg=axi_wrresp_config::type_id::create("b_cfg");
		//ar_cfg=slave_axi_rdaddr_config::type_id::create("ar_cfg");
		//r_cfg=slave_axi_rddata_cinfig::type_id::create("r_cfg");*/
		
		//set the config_db
		
		
		//AXI_agent_tops
		axi_m_agt_h=axi_m_agt_top::type_id::create("axi_m_agt_h", this);
		axi_s_agt_h=axi_slave_agent_top::type_id::create("axi_s_agt_h", this);
		
		//slave_agent_top assign to lower components
		//r_cfg.agent_top=axi_s_agt_h;
		uvm_config_db#(axi_slave_agent_top)::set(this, "*", "axi_slave_agent_top", axi_s_agt_h);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
	endfunction 	
endclass 
