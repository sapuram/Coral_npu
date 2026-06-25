class slave_axi_wrdata_drv extends uvm_driver#(axi_xtn);
	`uvm_component_utils(slave_axi_wrdata_drv);
	int indx;
	int burst_len;
	virtual axi_slave_if.S_DRV vif;
	axi_xtn xtn;
	axi_wrdata_config cfg;
	axi_slave_agent_top agent_top;
	function new(string name="slave_axi_wrdata_drv",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(axi_wrdata_config)::get(this,"","axi_wrdata_config",cfg))
			`uvm_fatal("SLAVE_AXI_WRDATA_DRV","config not getting in slave_axi_wrdata_drv")
	endfunction

	function void connect_phase(uvm_phase phase);
		vif=cfg.vif;
	endfunction

task run_phase(uvm_phase phase);
 
  forever
  begin
    seq_item_port.get_next_item(req);

    seq_item_port.item_done();
  end
endtask

endclass
