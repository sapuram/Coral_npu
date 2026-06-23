class axi_config extends uvm_object;
  
  `uvm_object_utils(axi_config)

//virtual virtual_interface dma_vif;
bit has_sagent = 1;
bit has_virtual_sequencer = 1;
uvm_active_passive_enum is_active=UVM_ACTIVE;

//for out of order transaction 1 = out-of-order, 0 = in-order
bit b_enable_ooo;
bit r_enable_ooo;

 function new(string name ="axi_config");
    super.new(name);
  endfunction 
  
endclass

