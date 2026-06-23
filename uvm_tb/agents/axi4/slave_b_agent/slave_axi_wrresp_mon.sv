class slave_axi_wrresp_mon extends uvm_monitor;
  `uvm_component_utils(slave_axi_wrresp_mon)
  
  // virtual interface
  virtual axi_slave_if.S_MON vif;
  //config
  axi_wrresp_config cfg;
  axi_xtn xtn;
  uvm_analysis_port #(axi_xtn) mp;
  
  function new(string name="slave_axi_wrresp_mon",uvm_component parent);
    super.new(name,parent);
    mp=new("mp",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     if(!uvm_config_db#(axi_wrresp_config)::get(this,"","axi_wrresp_config",cfg))
                  
      `uvm_fatal("SLAVE_MONITOR","CONFIGURATION IS NOT GETTING IN MONITOR CLASS")
  endfunction
  
  function void connect_phase(uvm_phase phase);
    vif=cfg.vif;
  endfunction
  
  
  task run_phase(uvm_phase phase);
    
    forever
    begin
	    @(vif.mon_cb_slave);
	    if(vif.mon_cb_slave.bvalid && vif.mon_cb_slave.bready)
	    begin
         xtn=axi_xtn::type_id::create("xtn");
		`uvm_info ("SLAVE--WRREP---MON","AT THE RISING EDGE AT RESP MONITOR ",UVM_LOW)
                xtn.bid=vif.mon_cb_slave.bid;
                xtn.bresp=axi_resp_t'(vif.mon_cb_slave.bresp);
                `uvm_info("SLAVE_AXI_WRRESP_MON",$sformatf("packet from wrresp mon %0p",xtn.sprint),UVM_LOW)
                 mp.write(xtn);
          end
  end 
     endtask
  
     
 
endclass:slave_axi_wrresp_mon

