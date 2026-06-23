class axi_wraddr_config extends uvm_object;



	`uvm_object_utils(axi_wraddr_config)



	virtual axi_slave_if vif;  //virtual interface

	uvm_active_passive_enum is_active=UVM_ACTIVE;

	bit has_wr_agent;

	//int addr_mon_collected_xtn_count;

	//int addr_drv_data_sent_count;



	//int data_mon_collected_xtn_count;

	//int data_drv_data_sent_count;



	//int rsp_mon_collected_xtn_count;

	//int rsp_drv_data_sent_count;



	function new(string name ="axi_wraddr_config");

		super.new(name);

	endfunction 



endclass


