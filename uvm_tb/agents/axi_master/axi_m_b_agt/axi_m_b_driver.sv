class axi_m_b_driver extends uvm_driver#(axi_master_trans);



`uvm_component_utils(axi_m_b_driver)

  virtual axi_master_if vif;

  axi_master_trans tx;



 function new(string name="axi_m_b_driver",uvm_component parent=null);

		super.new(name,parent);

 endfunction

	

virtual function void build_phase(uvm_phase phase);

	super.build_phase(phase);	

  if(!uvm_config_db #(virtual axi_master_if)::get(this,"","axi_master_if",vif))
	  `uvm_error("Driver","check the aw config errorrrrr"); 

 endfunction

task initialize();
@(posedge vif.aclk);
vif.bready<=0;
endtask


virtual task run_phase(uvm_phase phase);
@(posedge vif.aclk);
	forever begin	
	if(!vif.aresetn) begin
		     initialize();
	     @(posedge vif.aresetn);
     end

		seq_item_port.get_next_item(req);
               //vif.bready  <= 1;

        req.print();
		drive_tx(req);

		seq_item_port.item_done();

	end

 endtask



 task drive_tx(axi_master_trans tx);
  if(req.write == 1) begin	

	write_resp_phase(req);

  end

 endtask

task write_resp_phase(axi_master_trans tx); 

 

 while(vif.bvalid === 0 || vif.bvalid === 'bx )begin

	@(posedge vif.aclk);

 end 
`uvm_info("DRIVER",$sformatf("Bdriver valid is %b",vif.bvalid),UVM_LOW);
       @(posedge vif.aclk);
        vif.bready  <= 1;
      wait(vif.bvalid==1) begin
	@(posedge vif.aclk);
	vif.bready  <= 0;
      end
endtask

endclass

