class slave_axi_wrdata_agent extends uvm_agent;
   
    `uvm_component_utils(slave_axi_wrdata_agent)
           
           slave_axi_wrdata_mon monh;
           slave_axi_wrdata_drv drvh;
           slave_axi_wrdata_seqr seqrh;
           axi_wrdata_config cfg;
           function new(string name ="slave_axi_wrdata_agent",uvm_component parent);
             super.new(name,parent);
           endfunction
           
           function void build_phase(uvm_phase phase);
           cfg=axi_wrdata_config::type_id::create("cfg");
                if(!uvm_config_db #(virtual axi_slave_if)::get(this,"","axi_slave_if",cfg.vif))
             `uvm_fatal("SLAVE_AXI_WRDATA_AGENT","interface not getting in wrdata agent")

             monh= slave_axi_wrdata_mon::type_id::create("monh",this);
             
             if(cfg.is_active==UVM_ACTIVE)
               begin
                 
                 drvh= slave_axi_wrdata_drv::type_id::create("drvh",this);
                 seqrh= slave_axi_wrdata_seqr::type_id::create("seqrh",this);
              uvm_config_db#(axi_wrdata_config)::set(this,"*","axi_wrdata_config",cfg);
               end
           endfunction
           
           function void connect_phase(uvm_phase phase);
              if(cfg.is_active==UVM_ACTIVE)
             drvh.seq_item_port.connect(seqrh.seq_item_export);
           endfunction
           
         endclass: slave_axi_wrdata_agent

