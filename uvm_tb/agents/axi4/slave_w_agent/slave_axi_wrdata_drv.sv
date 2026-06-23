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
  @(vif.drv_cb_slave);
  if(vif.drv_cb_slave.aresetn == 0)
	  vif.drv_cb_slave.wready <= 0;

	wait(vif.drv_cb_slave.aresetn == 1);
		 @(vif.drv_cb_slave);
	 vif.drv_cb_slave.wready <= 1;

  forever
  begin
    seq_item_port.get_next_item(req);
    wr_data(req);
    rsp.set_id_info(req);
    seq_item_port.item_done();
    seq_item_port.put(rsp);
  end
endtask

task wr_data(axi_xtn xtn1);
  int i = 0;
  rsp = axi_xtn::type_id::create("rsp");
  rsp.copy(xtn1); // deepcopy

  // initialize empty arrays
  rsp.wdata = new[0];
  rsp.wstrb = new[0];
  rsp.wlast = new[0];

  while (1) begin
    @(vif.drv_cb_slave);
    if(vif.drv_cb_slave.wvalid ) begin
      rsp.wdata = new[rsp.wdata.size()+1](rsp.wdata);
      rsp.wstrb = new[rsp.wstrb.size()+1](rsp.wstrb);
      rsp.wlast = new[rsp.wlast.size()+1](rsp.wlast);

      rsp.wdata[i] = vif.drv_cb_slave.wdata;
      rsp.wstrb[i] = vif.drv_cb_slave.wstrb;
      rsp.wlast[i] = vif.drv_cb_slave.wlast;

      `uvm_info("SLAVE_AXI_WRDATA_DRV",$sformatf(" Beat %0d : WDATA=%0h WSTRB=%0h WLAST=%0b",i, rsp.wdata[i], rsp.wstrb[i], rsp.wlast[i]), UVM_LOW)
      if(vif.drv_cb_slave.wlast)
        break;

      i++;
  end
  end
  `uvm_info("SLAVE_AXI_WRDATA_DRV", $sformatf("Collected Write Data:\n%s", rsp.sprint()), UVM_LOW)

endtask
endclass
