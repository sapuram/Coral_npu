class slave_axi_rdaddr_mon extends uvm_monitor;
	`uvm_component_utils(slave_axi_rdaddr_mon)

	// virtual interface
	virtual axi_slave_if.S_MON vif;

	//config
	slave_axi_rdaddr_config cfg;

	axi_xtn xtn;
	uvm_analysis_port #(axi_xtn) mp;

	function new(string name="slave_axi_rdaddr_mon",uvm_component parent);
		super.new(name,parent);
		mp=new("mp",this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(slave_axi_rdaddr_config)::get(this,"","slave_axi_rdaddr_config",cfg))
			`uvm_fatal("SLAVE_AXI_RDADDR_MONITOR","CONFIGURATION IS NOT GETTING IN MONITOR CLASS")
	endfunction

        virtual	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vif=cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		forever
			collect_rddata;
	endtask

	task collect_rddata;
		@(vif.mon_cb_slave);
		if(vif.mon_cb_slave.arvalid && vif.mon_cb_slave.arready)
		begin
			xtn=axi_xtn::type_id::create("xtn");
			`uvm_info("RDADDR MONITOR","both arvalid and arready is high",UVM_LOW)    
			xtn.arid=vif.mon_cb_slave.arid;
			xtn.araddr=vif.mon_cb_slave.araddr;
			xtn.arlen=vif.mon_cb_slave.arlen;
			xtn.arsize = vif.mon_cb_slave.arsize;
			xtn.arburst= axi_burst_t'(vif.mon_cb_slave.arburst);
			xtn.arprot= axi_prot_t'(vif.mon_cb_slave.arprot);
			xtn.arlock=vif.mon_cb_slave.arlock;
			xtn.arcache= axi_cache_t'(vif.mon_cb_slave.arcache);
			xtn.arqos=axi_qos_t'(vif.mon_cb_slave.arqos);
			xtn.arregion=axi_region_t'(vif.mon_cb_slave.arregion);
			`uvm_info("RDADDR MONITOR",$sformatf("packet generated in rdaddr mon %0p",xtn.sprint),UVM_LOW)

			mp.write(xtn);

		end

	endtask
endclass:slave_axi_rdaddr_mon
