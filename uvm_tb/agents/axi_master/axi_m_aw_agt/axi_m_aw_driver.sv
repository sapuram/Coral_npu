class axi_m_aw_driver extends uvm_driver#(axi_master_trans);
`uvm_component_utils(axi_m_aw_driver)

  virtual axi_master_if vif;

  axi_master_trans tx;

 function new(string name="axi_m_aw_driver",uvm_component parent=null);
		super.new(name,parent);
 endfunction

virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);	
  	if(!uvm_config_db #(virtual axi_master_if)::get(this,"","axi_master_if",vif))
	  `uvm_fatal("Driver","check the aw config error"); 
 endfunction

task initialize();
@(posedge vif.aclk);
vif.awid<=0;
vif.awaddr<=0;
vif.awvalid<=0;
vif.awlen<=0;
vif.awsize<=0;
vif.awburst<=0;
vif.awlock<=0;
vif.awcache<=0;
vif.awprot<=0;
vif.awqos<=0;
vif.awregion<=0;
vif.awuser<=0;
endtask

virtual task run_phase(uvm_phase phase);
	forever begin
		seq_item_port.get_next_item(req);
	
		seq_item_port.item_done();

	end

 endtask

endclass

