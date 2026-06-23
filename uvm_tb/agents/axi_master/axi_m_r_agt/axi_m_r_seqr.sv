class axi_m_r_seqr extends uvm_sequencer#(axi_master_trans);

`uvm_component_utils(axi_m_r_seqr)

function new (string name="axi_m_r_seqr",uvm_component parent=null);

    super.new(name,parent);

endfunction

endclass

