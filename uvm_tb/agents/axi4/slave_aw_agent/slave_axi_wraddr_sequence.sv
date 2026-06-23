//`include "axi_xtn.sv"
class slave_axi_wraddr_sequence  extends uvm_sequence#(axi_xtn);

	`uvm_object_utils(slave_axi_wraddr_sequence)

	axi_xtn wr_addrq[$],wr_addrq1[$];

	function new(string name="slave_axi_wraddr_sequence");

		super.new(name);

	endfunction
	task  body();
	begin
		req=axi_xtn::type_id::create("req");

		start_item(req);
		assert (req.randomize());
		finish_item(req);

		get_response(rsp);

		wr_addrq.push_back(rsp);

		wr_addrq1.push_back(rsp);

//		`uvm_info("WR_ADDR_SEQUENCE",$sformatf("printing packet from wr_addr_sequence %0p",rsp.sprint),UVM_LOW) 

	end
endtask
endclass:slave_axi_wraddr_sequence

