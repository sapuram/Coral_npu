class slave_axi_rdaddr_config extends uvm_object;

  

  `uvm_object_utils(slave_axi_rdaddr_config)



virtual axi_slave_if vif;



bit has_sagent = 1;

bit has_virtual_sequencer = 1;

uvm_active_passive_enum is_active=UVM_ACTIVE;



 function new(string name ="slave_axi_rdaddr_config");

    super.new(name);

  endfunction 

  

endclass


