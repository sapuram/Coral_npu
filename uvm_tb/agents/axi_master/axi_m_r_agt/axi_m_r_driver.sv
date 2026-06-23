class axi_m_r_driver extends uvm_driver#(axi_master_trans);
`uvm_component_utils(axi_m_r_driver)
  virtual axi_master_if vif;
  axi_master_trans tx;
 function new(string name="axi_m_r_driver",uvm_component parent=null);
		super.new(name,parent);
 endfunction
	
virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);	
  if(!uvm_config_db #(virtual axi_master_if)::get(this,"","axi_master_if",vif))
	  `uvm_error("Driver","check the aw config errorrrrr"); 
 endfunction
 
task initialize();
@(posedge vif.aclk);
vif.rready<=0;
endtask
virtual task run_phase(uvm_phase phase);
  @(posedge vif.aclk);
	forever begin	
	if(!vif.aresetn) begin
		     initialize();
	     @(posedge vif.aresetn);
     end
		seq_item_port.get_next_item(req);
  vif.rready <= 1; 
                req.print();
		drive_tx(req);
		seq_item_port.item_done();
	end
 endtask
 task drive_tx(axi_master_trans tx);
  if(tx.write == 0) begin	
	read_data_phase(tx);
  end
 endtask
/*task read_data_phase(axi_master_trans tx);
  
`uvm_info("R_DRIVER",$sformatf("the value of arlen is %b",tx.arlen),UVM_LOW);
for(int i=0;i <=tx.arlen;i++) begin
   while(vif.rvalid == 0 )begin
    	@(posedge vif.aclk);
   end
    	vif.rready  <= 1;
//           wait(vif.rlast==1) begin
           if(vif.rlast==1) begin
//  	    @(posedge vif.aclk);
	    vif.rready  <= 0;
	    `uvm_info("R_DRIVER","got the req//////////////////////////////////777777777777777",UVM_LOW);
           end       
	   @(posedge vif.aclk);
end
endtask*/
task read_data_phase(axi_master_trans tx);
  `uvm_info("R_DRIVER",
    $sformatf("the value of arlen is %0d", tx.arlen),
    UVM_LOW);
  // READY must be asserted BEFORE data comes
  //vif.rready <= 1;
  for (int i = 0; i <= tx.arlen; i++) begin
    // wait for VALID + READY handshake
    @(posedge vif.aclk);
    wait (vif.rvalid && vif.rready);
    `uvm_info("R_DRIVER",
      $sformatf("Read beat %0d data = %h last=%0b",
                 i, vif.rdata, vif.rlast),
      UVM_LOW);
    if (vif.rlast) begin
      // deassert AFTER handshake
      @(posedge vif.aclk); vif.rready <= 0;
      @(posedge vif.aclk); vif.rready <= 1;
    end
  end
endtask
endclass
