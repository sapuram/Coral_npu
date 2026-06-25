class coralnpu_test_base extends uvm_test;
	`uvm_component_utils(coralnpu_test_base)

	coralnpu_env_base env_h; 
	
	//axi_sequence
	axi_aw_seq aw_seqch; 
	axi_w_seq w_seqch;
	axi_b_seq b_seqch;
	axi_ar_seq ar_seqch;
	axi_r_seq r_seqch; 
		
	function new (string name="coralnpu_test_base", uvm_component parent=null);
		super.new(name, parent);
	endfunction 
	
	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		env_h=coralnpu_env_base::type_id::create("env_h", this);
		uvm_top.set_timeout(500, 0);
	endfunction 
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		$display("================================================================================");
		
		//coral_config_virtual_if_get
		if(!uvm_config_db#(virtual axi_master_if)::get(this, "", "master_if", env_h.cfg.master_if))
			`uvm_fatal(get_type_name(), "Config_fatal_master");
		if(!uvm_config_db#(virtual axi_slave_if)::get(this, "", "slave_if", env_h.cfg.slave_if))
			`uvm_fatal(get_type_name(), "Config_fatal_slave")
			
		/*axi_slave_config_virtual_if_get
		if(!uvm_config_db#(virtual axi_slave_if)::get(this, "", "slave_if", env_h.aw_cfg.vif)))
			`uvm_fatal(get_type_name(), "Config_fatal_slave")
		if(!uvm_config_db#(virtual axi_slave_if)::get(this, "", "slave_if", env_h.w_cfg.vif)))
			`uvm_fatal(get_type_name(), "Config_fatal_slave")
		if(!uvm_config_db#(virtual axi_slave_if)::get(this, "", "slave_if", env_h.b_cfg.vif)))
			`uvm_fatal(get_type_name(), "Config_fatal_slave")
		if(!uvm_config_db#(virtual axi_slave_if)::get(this, "", "slave_if", env_h.ar_cfg.vif)))
			`uvm_fatal(get_type_name(), "Config_fatal_slave")
		if(!uvm_config_db#(virtual axi_slave_if)::get(this, "", "slave_if", env_h.r_cfg.vif)))
			`uvm_fatal(get_type_name(), "Config_fatal_slave")*/
		
		//slave b&r_enable_set 
		uvm_config_db#(bit)::set(this, "*", "b_enable_ooo", 0);
		uvm_config_db#(bit)::set(this, "*", "r_enable_ooo", 0); 
		`uvm_info(get_type_name(), "connection of the virtual interface is set", UVM_LOW)	
		$display("================================================================================");
	endfunction 
	
	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology;
	endfunction 
	
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		$display("================================================================================");
		`uvm_info(get_type_name(), "Entring into RUN_Phase", UVM_LOW)
		
		//sequence_creations. 
		aw_seqch= axi_aw_seq::type_id::create("aw_seqch");
		w_seqch=axi_w_seq::type_id::create("w_seqch");
		b_seqch=axi_b_seq::type_id::create("b_seqch");
		ar_seqch=axi_ar_seq::type_id::create("ar_seqch");
		r_seqch=axi_r_seq::type_id::create("r_seqch");
		
		//starting the master_sequence parallely. 
		fork 
			aw_seqch.start (env_h.axi_m_agt_h.m_aw_agth.seqrh);
			w_seqch.start  (env_h.axi_m_agt_h.m_w_agth.seqrh);
			b_seqch.start  (env_h.axi_m_agt_h.m_b_agth.seqrh);
			ar_seqch.start (env_h.axi_m_agt_h.m_ar_agth.seqrh);
			r_seqch.start  (env_h.axi_m_agt_h.m_r_agth.seqrh);
		join_none
		#10000;
		`uvm_info(get_type_name(), "Run_Phase_Completed", UVM_LOW)
		$display("================================================================================");
		phase.drop_objection(this);
	endtask 
endclass
