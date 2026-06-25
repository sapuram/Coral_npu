 class slave_axi_wraddr_drv extends uvm_driver#(axi_xtn);
            `uvm_component_utils(slave_axi_wraddr_drv);
            virtual axi_slave_if.S_DRV vif;
            axi_xtn xtn;
            axi_wraddr_config cfg;
	    
	    function new(string name="slave_axi_wraddr_drv",uvm_component parent);
              super.new(name,parent);
            endfunction
           virtual function void build_phase(uvm_phase phase);
              super.build_phase(phase);
		if(!uvm_config_db #(axi_wraddr_config)::get(this,"","axi_wraddr_config",cfg))
 		   `uvm_fatal("SLAVE_DRIVER","CONFIGURATION IS NOT GETTING IN MONITOR CLASS")
            endfunction

            virtual function void connect_phase(uvm_phase phase);
		    super.connect_phase(phase);
                    vif=cfg.vif;
            endfunction

            task run_phase(uvm_phase phase);
              forever
                begin
                  seq_item_port.get_next_item(req);


                  seq_item_port.item_done();
                end
            endtask

            task driver_wraddr(axi_xtn xtn1);
              rsp=axi_xtn::type_id::create("rsp");
              while(1)
      		begin  
	      @(vif.drv_cb_slave);
                if(vif.drv_cb_slave.awvalid) break;
		end

                    rsp.awid=vif.drv_cb_slave.awid;
                    rsp.awaddr=vif.drv_cb_slave.awaddr;
                    rsp.awlen=vif.drv_cb_slave.awlen;
                    rsp.awsize=vif.drv_cb_slave.awsize;
		    rsp.awburst=axi_burst_t'(vif.drv_cb_slave.awburst);
		    rsp.awlock=vif.drv_cb_slave.awlock;
		    rsp.awcache= axi_cache_t'(vif.drv_cb_slave.awcache);
		    rsp.awprot= axi_prot_t'(vif.drv_cb_slave.awprot);
		    rsp.awqos=axi_qos_t'(vif.drv_cb_slave.awqos);
		    rsp.awregion=axi_region_t'(vif.drv_cb_slave.awregion);
                   // @(vif.drv_cb_slave);
                   // vif.drv_cb_slave.awready<=0;
                    `uvm_info("WRADDR_DRIVER",$sformatf("printing from wr_addr_driver %0p ",rsp.sprint),UVM_NONE)
        endtask
endclass:slave_axi_wraddr_drv        
