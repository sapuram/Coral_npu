class slave_axi_wrdata_sequence  extends uvm_sequence #(axi_xtn);
	`uvm_object_utils(slave_axi_wrdata_sequence)

	//int burst_len;
	axi_xtn wr_dataq[$],wr_respq[$];

	function new(string name="slave_axi_wrdata_sequence");
		super.new(name);
	endfunction

	task  body();
	begin
		req=axi_xtn::type_id::create("req");

		start_item(req);
		assert (req.randomize() ); /*with {WDATA.size==burst_len; 

		WLAST.size==burst_len;}); */
	       //`uvm_info("SLAVE_AXI_WRDATA_SEQ",$sformatf("printing in wrdata seq after randomizing %0p",req.sprint),UVM_LOW)
	       finish_item(req);

	       get_response(rsp);
	      wr_respq.push_back(rsp);
//	      foreach (wr_respq[i]) 
  //  `uvm_info("WDATA_SEQ",$sformatf("wr_respq[%0d]: %s", i, wr_respq[i].sprint()), UVM_LOW)
	       wr_dataq.push_back(rsp);

       end
       endtask
       endclass
