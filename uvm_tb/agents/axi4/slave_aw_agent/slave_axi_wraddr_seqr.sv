class slave_axi_wraddr_seqr extends uvm_sequencer #(axi_xtn);

  `uvm_component_utils(slave_axi_wraddr_seqr)
  function new(string name="slave_axi_wraddr_seqr",uvm_component parent);
        super.new(name,parent);
  endfunction
endclass


