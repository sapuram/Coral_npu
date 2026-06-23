class slave_axi_wraddr_mon extends uvm_monitor;
	`uvm_component_utils(slave_axi_wraddr_mon)
	// virtual interface
	virtual axi_slave_if.S_MON vif;
	//config
	axi_wraddr_config cfg;
	axi_xtn xtn;
	//  axi_xtn q1[$],q2[$];
	uvm_analysis_port #(axi_xtn) mp;

	function new(string name="slave_axi_wraddr_mon",uvm_component parent);
		super.new(name,parent);
		mp=new("mp",this);
	endfunction

        virtual	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db #(axi_wraddr_config)::get(this,"","axi_wraddr_config",cfg))
			`uvm_fatal("SLAVE_MONITOR","CONFIGURATION IS NOT GETTING IN MONITOR CLASS")
	endfunction
        virtual	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vif=cfg.vif;
	endfunction
        virtual	task run_phase(uvm_phase phase);
		forever begin
		@(vif.mon_cb_slave);
		if(vif.mon_cb_slave.awvalid && vif.mon_cb_slave.awready)
		begin
			xtn=axi_xtn::type_id::create("xtn");
			`uvm_info("AWADDR MONITOR","both awvalid and awready is high",UVM_LOW)
			xtn.awid=vif.mon_cb_slave.awid;
			xtn.awaddr=vif.mon_cb_slave.awaddr;
			xtn.awlen=vif.mon_cb_slave.awlen;
			xtn.awsize  = vif.mon_cb_slave.awsize;
			xtn.awburst = axi_burst_t'(vif.mon_cb_slave.awburst);
			xtn.awlock= vif.mon_cb_slave.awlock;
			xtn.awprot = axi_prot_t'(vif.mon_cb_slave.awprot); 
			xtn.awcache= axi_cache_t'(vif.mon_cb_slave.awcache);
			xtn.awqos=axi_qos_t'(vif.mon_cb_slave.awqos);
			xtn.awregion=axi_region_t'(vif.mon_cb_slave.awregion);
			`uvm_info("WRADDR_MONITOR",$sformatf("printing from wr_addr_monitor %0p ",xtn.sprint),UVM_LOW)
			mp.write(xtn);
		end
	end
	endtask
endclass:slave_axi_wraddr_mon
