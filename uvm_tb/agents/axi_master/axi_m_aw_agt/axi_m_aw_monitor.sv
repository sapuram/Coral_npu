class axi_m_aw_monitor extends uvm_monitor;

`uvm_component_utils(axi_m_aw_monitor)
 //uvm_analysis_port#(axi_trans)an_port; 

 axi_master_trans tx;

 virtual axi_master_if mif;
 virtual axi_master_if.M_MON vif;

function new(string name="axi_m_aw_monitor",uvm_component parent=null);

   super.new(name,parent);

endfunction


virtual function void build_phase(uvm_phase phase);

 super.build_phase(phase); 

 //an_port=new("an_port",this);

 tx=axi_master_trans::type_id::create("tx");


if(!uvm_config_db #(virtual axi_master_if)::get(this,"","axi_master_if",mif))
          `uvm_error("Driver","check the aw config errorrrrr");
 vif=mif.M_MON;
endfunction



virtual task run_phase(uvm_phase phase);

  forever 

   begin

    sample_dut();

   end 

endtask 



task sample_dut();

     @(vif.mon_cb_master);
     if (vif.mon_cb_master.awvalid && vif.mon_cb_master.awready) 

       begin 

          `uvm_info("Monitor","Don't worry its just a trail n error",UVM_LOW);

          tx=axi_master_trans::type_id::create("tx");

          tx.awaddr = vif.mon_cb_master.awaddr;  

          tx.write =1'b1;

	  tx.awid=vif.mon_cb_master.awid;

          tx.awlen=vif.mon_cb_master.awlen;

	  tx.awburst=vif.mon_cb_master.awburst;

	  tx.awsize=vif.mon_cb_master.awsize;
          
	  tx.awlock=vif.mon_cb_master.awlock;       
  end

endtask

endclass

