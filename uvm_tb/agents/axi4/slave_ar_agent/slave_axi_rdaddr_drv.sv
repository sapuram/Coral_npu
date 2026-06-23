class slave_axi_rdaddr_drv extends uvm_driver#(axi_xtn);
    `uvm_component_utils(slave_axi_rdaddr_drv);

            virtual axi_slave_if.S_DRV vif;
           slave_axi_rdaddr_config cfg;
            function new(string name="slave_axi_rdaddr_drv",uvm_component parent);
              super.new(name,parent);
            endfunction
            
            function void build_phase(uvm_phase phase);
                 if(!uvm_config_db#(slave_axi_rdaddr_config)::get(this,"","slave_axi_rdaddr_config",cfg))
                    `uvm_fatal("SLAVE_AXI_RDADDR_DRIVER","CONFIGURATION IS NOT GETTING IN DRIVER CLASS")
              super.build_phase(phase);
            endfunction

            function void connect_phase(uvm_phase phase);

              vif=cfg.vif;

            endfunction

            task run_phase(uvm_phase phase);
		@(vif.drv_cb_slave);
                    if(vif.drv_cb_slave.aresetn==0)
		    vif.drv_cb_slave.arready <= 0;
			wait(vif.drv_cb_slave.aresetn==1);
				@(vif.drv_cb_slave);
				vif.drv_cb_slave.arready <= 1;

              forever
                begin
		// if(req != null)
                  seq_item_port.get_next_item(req);
		vif.drv_cb_slave.arready <= 1;
                  driver_task(req);
		  $display("error at araddr drv");
                  rsp.set_id_info(req);
		  $display("error at araddr drv 2");
                  seq_item_port.item_done(rsp);
                end
            endtask

task driver_task(axi_xtn xtn);
  rsp = axi_xtn::type_id::create("rsp");
  //comment
  while(1)
  begin
  @(vif.drv_cb_slave);
  if(vif.drv_cb_slave.arvalid) break;
  end
  rsp.arid     = vif.drv_cb_slave.arid;
  rsp.araddr   = vif.drv_cb_slave.araddr;
  rsp.arlen    = vif.drv_cb_slave.arlen;
  rsp.arsize   = vif.drv_cb_slave.arsize;
  rsp.arburst = axi_burst_t'(vif.drv_cb_slave.arburst);
  rsp.arprot  =  axi_prot_t'(vif.drv_cb_slave.arprot);
  rsp.arlock=vif.drv_cb_slave.arlock;
  rsp.arcache= axi_cache_t'(vif.drv_cb_slave.arcache);
  rsp.arqos=axi_qos_t'(vif.drv_cb_slave.arqos);
  rsp.arregion=axi_region_t'(vif.drv_cb_slave.arregion);
//  @(vif.drv_cb_slave);
// vif.drv_cb_slave.arready <=0;
  `uvm_info("RDADDR DRIVER", $sformatf("packet generated in rdaddr DRV %0p", rsp.sprint()), UVM_LOW)
endtask

endclass  




/*
            task  driver_task(axi_xtn xtn);

              rsp=axi_xtn::type_id::create("rsp");

              forever

                begin

            //`uvm_info("RDADDR DRIVER","packet generated in rdaddr DRV ",UVM_LOW)



                  @(vif.drv_cb_slave);

                   if(vif.drv_cb_slave.arvalid)

                     begin

                       repeat(xtn.arready_delay)

                         @(vif.drv_cb_slave);

                       vif.drv_cb_slave.arready<=1;

                       rsp.arid=vif.drv_cb_slave.arid;
                       rsp.araddr=vif.drv_cb_slave.araddr;
                       rsp.arlen=vif.drv_cb_slave.arlen;
                       rsp.arsize=vif.drv_cb_slave.arsize;
                       rsp.arburst=vif.drv_cb_slave.arburst;
                       @(vif.drv_cb_slave);

                       vif.drv_cb_slave.arready<=0;

                          `uvm_info("RDADDR DRIVER",$sformatf("packet generated in rdaddr DRV %0p",rsp.sprint),UVM_LOW)

                       break;
                       //seq_item_port.item_done(xtn);
                    end
                end
             endtask   
          endclass:slave_axi_rdaddr_drv        
*/
            




