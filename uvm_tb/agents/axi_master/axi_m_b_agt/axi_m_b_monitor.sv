class axi_m_b_monitor extends uvm_monitor;

`uvm_component_utils(axi_m_b_monitor)
 //uvm_analysis_port#(axi_trans)an_port; 

 axi_master_trans tx;

 virtual axi_master_if mif;
 virtual axi_master_if.M_MON vif;

function new(string name="axi_m_b_monitor",uvm_component parent=null);

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
 if(vif.mon_cb_master.bvalid &&vif.mon_cb_master.bready) 

       begin

	     tx.bresp = vif.mon_cb_master.bresp;

	    // an_port.write(tx);    // writing after bresp 

       end
endtask

endclass

