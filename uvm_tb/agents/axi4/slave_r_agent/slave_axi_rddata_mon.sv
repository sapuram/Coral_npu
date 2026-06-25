class slave_axi_rddata_mon extends uvm_monitor;
	`uvm_component_utils(slave_axi_rddata_mon)

	// virtual interface
	virtual axi_slave_if.S_MON vif;
	//config
	slave_axi_rddata_config cfg;
	axi_xtn xtn;

	uvm_analysis_port #(axi_xtn) mp;
	int indx =0 ;
	axi_slave_agent_top agent_top;
	function new(string name="slave_axi_rddata_mon",uvm_component parent);
		super.new(name,parent);
		mp=new("mp",this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(! uvm_config_db#(slave_axi_rddata_config)::get(this,"","slave_axi_rddata_config",cfg))
			`uvm_fatal("SLAVE_AXI_RDADDR_MONITOR","CONFIGURATION IS NOT GETTING IN MONITOR CLASS")

if(!uvm_config_db #(axi_slave_agent_top)::get(this,"","axi_slave_agent_top",agent_top)) 
`uvm_error("SLAVE_AXI_RDADDR_DRIVER","Unable to gethe agent top handle")
endfunction

	function void connect_phase(uvm_phase phase);
		vif=cfg.vif;
	endfunction


	task run_phase(uvm_phase phase);
	forever
		#100;
	endtask

task collect_rddata;
xtn=axi_xtn::type_id::create("xtn");
xtn.rdata=new[0];
xtn.rresp=new[0];
xtn.rlast=new[0];
do begin
         @(vif.mon_cb_slave);
         if(vif.mon_cb_slave.rvalid && vif.mon_cb_slave.rready)
         begin
		 xtn.rdata=new[xtn.rdata.size()+1](xtn.rdata);
		xtn.rresp=new[xtn.rresp.size()+1](xtn.rresp);
		xtn.rlast=new[xtn.rlast.size()+1](xtn.rlast);

                 xtn.rid=vif.mon_cb_slave.rid;
		 xtn.rdata[indx]=vif.mon_cb_slave.rdata;
                 xtn.rresp[indx]=axi_resp_t'(vif.mon_cb_slave.rresp);
                 xtn.rlast[indx]=vif.mon_cb_slave.rlast;
                 `uvm_info("RDDATA MONITOR", $sformatf("[%0t] Beat %0d : RID=%0d RDATA=%0h RRESP=%0d RLAST=%0b",$time, indx, xtn.rid, xtn.rdata[indx], xtn.rresp[indx], xtn.rlast[indx]),UVM_LOW)
indx++;
end
end while(!xtn.rlast[indx-1]);

 mp.write(xtn);
 `uvm_info("RDDATA MONITOR",$sformatf("[%0t] printingcompleted in rddata mon %0p",$time, xtn.sprint),UVM_LOW)
   endtask
endclass:slave_axi_rddata_mon
