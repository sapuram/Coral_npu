class slave_axi_wrdata_seqr extends uvm_sequencer #(axi_xtn);

	`uvm_component_utils(slave_axi_wrdata_seqr)



	function new(string name="slave_axi_wrdata_seqr",uvm_component parent);
		super.new(name,parent);
	endfunction

endclass:slave_axi_wrdata_seqr

