class axi_m_ar_driver extends uvm_driver#(axi_master_trans);



`uvm_component_utils(axi_m_ar_driver)

  virtual axi_master_if vif;

  axi_master_trans tx;



 function new(string name="axi_m_ar_driver",uvm_component parent=null);

		super.new(name,parent);

 endfunction

	

virtual function void build_phase(uvm_phase phase);

	super.build_phase(phase);	

  if(!uvm_config_db #(virtual axi_master_if)::get(this,"","axi_master_if",vif))
	  `uvm_error("Driver","check the aw config errorrrrr"); 

 endfunction

task initialize();
@(posedge vif.aclk);
vif.arid<=0;
vif.araddr<=0;
vif.arvalid<=0;
vif.arlen<=0;
vif.arsize<=0;
vif.arburst<=0;
vif.arlock<=0;
vif.arcache<=0;
vif.arprot<=0;
vif.arqos<=0;
vif.arregion<=0;
vif.aruser<=0;
endtask


virtual task run_phase(uvm_phase phase);

	forever begin	
	if(!vif.aresetn) begin
		     initialize();
	     @(posedge vif.aresetn);
     end

		seq_item_port.get_next_item(req);

                req.print();
		drive_tx(req);

		seq_item_port.item_done();

	end

 endtask



 task drive_tx(axi_master_trans tx);
  if(tx.write == 0) begin	

	read_addr_phase(tx);

  end

 endtask



task read_addr_phase(axi_master_trans tx);



   @(posedge vif.aclk);

  vif.araddr <=tx.araddr;

  vif.arid <=tx.arid;

  vif.arlen <=tx.arlen;

  vif.arsize <=tx.arsize;

  vif.arburst <=tx.arburst;

  vif.arlock <= tx.arlock;

  vif.arvalid <=1;



  wait (vif.arready == 1);

  @(posedge vif.aclk);
`uvm_info("DRIVER","got the req//////////////////////////////////6666666666666666",UVM_LOW);
//wait (vif.rlast==1) begin
  vif.araddr <=0;

  vif.arid <=0;

  vif.arlen <=0;

  vif.arsize <=0;

  vif.arburst <=0;

  vif.arvalid <=0;
//end


endtask

endclass

