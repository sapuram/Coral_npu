class slave_axi_rddata_sequence  extends uvm_sequence #(axi_xtn);

	`uvm_object_utils(slave_axi_rddata_sequence)
	axi_xtn rd_dataq[$];


	function new(string name="slave_axi_rddata_sequence");
		super.new(name);
	endfunction
	task  body();
	begin

	if (rd_dataq.size() != 0) begin
		req = rd_dataq.pop_front();

		start_item(req);
//		`uvm_info("RDDATA SEQUENCE",$sformatf("printing packet in rddata SEQ %0p",req.sprint),UVM_LOW)
		finish_item(req);
//		`uvm_info("RDDATA SEQUENCE",$sformatf("printing array in rddata SEQ %0p",rd_dataq),UVM_LOW)
//		`uvm_info("RDDATA SEQUENCE",$sformatf("printing packet in rddata SEQ %0p",req.sprint),UVM_LOW)
	end
	end
	endtask
endclass

/*
task  body();
begin
	req=axi_xtn::type_id::create("req");

	start_item(req);
	req=rd_dataq.pop_front;

	assert (req.randomize()); //with {foreach(RDATA[i])
	{
	RDATA[i]==10;
	RRESP[i]==1;
	RLAST[i]==1;
}});
`uvm_info("RDDATA SEQUENCE",$sformatf("printing packet in rddata SEQ %0p",req.sprint),UVM_LOW)

finish_item(req);

//get_response(req);


end
endtask   
endclass:slave_axi_rddata_sequence*/

