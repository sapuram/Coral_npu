class axi_m_w_agent extends uvm_agent;
   
    `uvm_component_utils(axi_m_w_agent)
           
           axi_m_w_monitor monh;
           axi_m_w_driver drvh;
           axi_m_w_seqr seqrh;

           function new(string name ="axi_m_w_agent",uvm_component parent);
             super.new(name,parent);
           endfunction
           
           function void build_phase(uvm_phase phase);
           
           //  if(!uvm_config_db#(virtual axi_slave_if)::get(this,"","axi_slave_if3",cfg.vif))
           //         `uvm_fatal("SLAVE_AXI_WRRESP_AGENT","interface not getting in wresp agent")

             monh= axi_m_w_monitor::type_id::create("monh",this);
             
            // if(cfg.is_active==UVM_ACTIVE)
            //   begin
                 
                 drvh= axi_m_w_driver::type_id::create("drvh",this);
                 seqrh=axi_m_w_seqr::type_id::create("seqrh",this);
            //   end
           // uvm_config_db#(axi_wrresp_config)::set(this,"*","axi_wrresp_config",cfg);
           endfunction
           
           function void connect_phase(uvm_phase phase);
             // if(cfg.is_active==UVM_ACTIVE)
             drvh.seq_item_port.connect(seqrh.seq_item_export);
           endfunction
           
endclass

