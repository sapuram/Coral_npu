class coralnpu_config extends uvm_object;
	`uvm_object_utils(coralnpu_config)
	
	virtual axi_master_if master_if; 
	virtual axi_slave_if slave_if;
	
	function new (string name="coralnpu_config");
		super.new (name);
	endfunction 
	
endclass 
