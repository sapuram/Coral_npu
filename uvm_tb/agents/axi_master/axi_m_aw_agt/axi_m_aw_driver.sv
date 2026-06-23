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
	  `uvm_error("Driver","check the aw config errorrrrr"); 
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
	if(!vif.aresetn) begin
		     initialize();
	     @(posedge vif.aresetn);
     end

		seq_item_port.get_next_item(req);

`uvm_info("AW_DRIVER",$sformatf("got the req from sqr %0p",req.sprint()),UVM_LOW);
		drive_tx(req);

		seq_item_port.item_done();

	end

 endtask



 task drive_tx(axi_master_trans tx);
  if(tx.write == 1) begin	
`uvm_info("AW_DRIVER","entered drive_tx//////////////////////////////////",UVM_LOW);
	write_addr_phase(tx);

  end

 endtask



 task write_addr_phase(axi_master_trans tx);



  @(posedge vif.aclk);
`uvm_info("AW_DRIVER","write_address_phase//////////////////////////////////222222",UVM_LOW);
  vif.awvalid <=1;

  vif.awaddr <=tx.awaddr;

  vif.awid <=tx.awid;

  vif.awlen <=tx.awlen;

  vif.awsize <=tx.awsize;

  vif.awburst <=tx.awburst;
  
  vif.awlock <= tx.awlock;
  
  wait(vif.awready==1);
  `uvm_info("AW_DRIVER",$sformatf("WRITE BASE ADDR = %0d", vif.awaddr), UVM_MEDIUM)


`uvm_info("AW_DRIVER","got the req//////////////////////////////////3333333",UVM_LOW);
  @(posedge vif.aclk);
  `uvm_info("AW_DRIVER","awvalid is droped, hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhuiiiiiiiiiiiiiiiiiiiiiiii",UVM_LOW);

  vif.awvalid <=0; // i will drive it with some delay



 endtask

endclass

