class slave_axi_rdaddr_sequence  extends uvm_sequence #(axi_xtn);

	`uvm_object_utils(slave_axi_rdaddr_sequence)
	axi_xtn rd_addrq[$];

	function new(string name="slave_axi_rdaddr_sequence");
		super.new(name);
	endfunction

	task  body();
	begin
		req=axi_xtn::type_id::create("req");
		start_item(req);
		assert (req.randomize());
		`uvm_info("RDADDR SEQUENCE","packet generated in rdaddr seq ",UVM_LOW)
		finish_item(req);
		get_response(rsp);
		rd_addrq.push_back(rsp);
//		`uvm_info("RDADDR SEQUENCE",$sformatf("packet generated in rdaddr seq %0p",rsp.sprint),UVM_LOW)
	end

endtask
endclass:slave_axi_rdaddr_sequence
