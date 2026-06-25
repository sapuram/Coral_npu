class axi_m_w_driver extends uvm_driver#(axi_master_trans);
`uvm_component_utils(axi_m_w_driver)

  virtual axi_master_if vif;

  axi_master_trans tx;

 function new(string name="axi_m_w_driver",uvm_component parent=null);
		super.new(name,parent);
 endfunction
 
virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);	
  if(!uvm_config_db #(virtual axi_master_if)::get(this,"","axi_master_if",vif))
	  `uvm_error("Driver","check the aw config errorrrrr"); 
 endfunction

task initialize();
@(posedge vif.aclk);
vif.wdata<=0;
vif.wstrb<=0;
vif.wvalid<=0;
vif.wlast<=0;
vif.wuser<=0;
endtask

virtual task run_phase(uvm_phase phase);

	forever begin	
		seq_item_port.get_next_item(req);

		seq_item_port.item_done();
	end
endtask

task write_data_phase(axi_master_trans tx);

endtask

endclass

