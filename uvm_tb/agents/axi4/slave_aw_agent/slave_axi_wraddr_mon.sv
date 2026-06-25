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
			#100;
		end
	end
	endtask
	
endclass:slave_axi_wraddr_mon
