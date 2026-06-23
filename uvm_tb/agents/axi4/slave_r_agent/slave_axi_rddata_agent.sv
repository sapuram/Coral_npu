class slave_axi_rddata_agent extends uvm_agent;

   

    `uvm_component_utils(slave_axi_rddata_agent)

           

           slave_axi_rddata_mon monh;

           slave_axi_rddata_drv drvh;

            slave_axi_rddata_seqr seqrh;

            slave_axi_rddata_config cfg;

           function new(string name ="slave_axi_rddata_agent",uvm_component parent);

             super.new(name,parent);

           endfunction

           

           function void build_phase(uvm_phase phase);

             cfg=slave_axi_rddata_config::type_id::create("cfg");
		     if(!uvm_config_db #(virtual axi_slave_if)::get(this,"","axi_slave_if",cfg.vif))
              `uvm_fatal("SLAVE_AXI_RDDATA_AGENT","interface not getting in radata agent")

             monh= slave_axi_rddata_mon::type_id::create("monh",this);
             if(cfg.is_active==UVM_ACTIVE)

               begin

                 

                 drvh= slave_axi_rddata_drv::type_id::create("drvh",this);

                 seqrh= slave_axi_rddata_seqr::type_id::create("seqrh",this);

               end

        uvm_config_db#(slave_axi_rddata_config)::set(this,"*","slave_axi_rddata_config",cfg);

            

           endfunction

           

           function void connect_phase(uvm_phase phase);

              if(cfg.is_active==UVM_ACTIVE)

             drvh.seq_item_port.connect(seqrh.seq_item_export);

           endfunction

          

endclass: slave_axi_rddata_agent


