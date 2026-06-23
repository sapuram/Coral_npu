class slave_axi_rddata_config extends uvm_object; 
	`uvm_object_utils(slave_axi_rddata_config)
	//axi_slave_agent_top
	axi_slave_agent_top agent_top;
	//bit agent_top=1;

//	virtual virtual_interface dma_if;
	virtual axi_slave_if vif;
	bit has_sagent = 1;
	bit has_virtual_sequencer = 1;
	uvm_active_passive_enum is_active=UVM_ACTIVE;

	function new(string name ="slave_axi_rddata_config");
		super.new(name);
	endfunction 

endclass
