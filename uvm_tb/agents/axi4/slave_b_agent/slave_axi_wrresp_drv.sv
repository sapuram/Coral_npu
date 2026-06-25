class slave_axi_wrresp_drv extends uvm_driver#(axi_xtn);
	`uvm_component_utils(slave_axi_wrresp_drv);

	virtual axi_slave_if.S_DRV vif;
	axi_wrresp_config cfg;
	function new(string name="slave_axi_wrresp_drv",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(axi_wrresp_config)::get(this,"","axi_wrresp_config",cfg))
			`uvm_fatal("SLAVE_AXI_WRRESP_DRV","vif is not getting in wrresp drv")

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
task drive_bresp(axi_xtn xtn);
	@(vif.drv_cb_slave);
		 vif.drv_cb_slave.bresp <= xtn.bresp; 
		 vif.drv_cb_slave.bid <= xtn.bid;
		 `uvm_info("SLAVE_AXI_WRRESP_DRV", "bresp synching with interface", UVM_LOW)
		 vif.drv_cb_slave.bvalid <= 1;
		    
		 wait(vif.drv_cb_slave.bready);
		 `uvm_info("SLAVE_AXI_WRRESP_DRV", $sformatf("packet from wrresp drv:\n%0p", xtn.sprint()), UVM_LOW)
		    @(vif.drv_cb_slave);
		    vif.drv_cb_slave.bvalid <= 0;
	    endtask
	    endclass

