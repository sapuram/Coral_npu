class axi_config extends uvm_object; 
  `uvm_object_utils(axi_config)

virtual virtual_interface dma_vif;
 function new(string name ="axi_config");
    super.new(name);
  endfunction 
  
endclass

