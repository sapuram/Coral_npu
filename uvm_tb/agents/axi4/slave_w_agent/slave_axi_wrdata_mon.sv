class slave_axi_wrdata_mon extends uvm_monitor;
  `uvm_component_utils(slave_axi_wrdata_mon)
 int burst_len;
  // virtual interface
  virtual axi_slave_if.S_MON vif;
  //config
  axi_wrdata_config cfg;
  uvm_analysis_port #(axi_xtn) mp;
   int indx=0;
   int i=0;
   int j = 0;


   bit [31:0] wdata_queue [$];
   bit [3:0] wstrb_queue [$];
   bit wlast_queue [$];
   axi_slave_agent_top agent_top; 

  function new(string name="slave_axi_wrdata_mon",uvm_component parent);
    super.new(name,parent);
    mp=new("mp",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(axi_wrdata_config)::get(this,"","axi_wrdata_config",cfg))
                     `uvm_fatal("SLAVE_AXI_WRDATA_MON","config not getting in slave_axi_wrdata_mon")
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    vif=cfg.vif;
  endfunction
  
  
  task run_phase(uvm_phase phase);
    forever
     collect_wrdata;
     
  endtask
  task collect_wrdata;
  axi_xtn xtn;

  xtn = axi_xtn::type_id::create("xtn");
  xtn.wdata = new[0];
  xtn.wstrb = new[0];
  xtn.wlast = new[0];

  do begin
    @(vif.mon_cb_slave);
    if (vif.mon_cb_slave.wvalid && vif.mon_cb_slave.wready) begin
      xtn.wdata = new[xtn.wdata.size()+1](xtn.wdata);
      xtn.wstrb = new[xtn.wstrb.size()+1](xtn.wstrb);
      xtn.wlast = new[xtn.wlast.size()+1](xtn.wlast);

      xtn.wdata[j] = vif.mon_cb_slave.wdata;
      xtn.wstrb[j] = vif.mon_cb_slave.wstrb;
      xtn.wlast[j] = vif.mon_cb_slave.wlast;

      `uvm_info("SLAVE_AXI_WRDATA_MON", $sformatf("[%0t] Captured Beat %0d : WDATA=0x%0h WSTRB=0x%0h WLAST=%0b",$time, j, xtn.wdata[j], xtn.wstrb[j], xtn.wlast[j]),UVM_LOW)
      j++;
    end
  end while (!xtn.wlast[j-1]);
  `uvm_info("SLAVE_AXI_WRDATA_MON",$sformatf("[%0t] Printing Write Data Transaction:\n%0p", $time, xtn.sprint()),    UVM_LOW)
 mp.write(xtn);

endtask
endclass: slave_axi_wrdata_mon

  /*
  task collect_wrdata;
        axi_xtn xtn;
	xtn=axi_xtn::type_id::create("xtn");
	burst_len = agent_top.burst_length;
	`uvm_info("SLAVE_AXI_WRDATA_MON", $sformatf("[%t] agent_top.burst_length=%0d", $time, burst_len), UVM_LOW);
   xtn.wdata=new[1];
    xtn.wstrb=new[1];
    xtn.wlast=new[1];
    indx=0;
        forever
          begin
             @(vif.mon_cb_slave);  
          if(vif.mon_cb_slave.wvalid && vif.mon_cb_slave.wready)
                begin
                  xtn.wdata[indx]=vif.mon_cb_slave.wdata;
                  xtn.wstrb[indx]=vif.mon_cb_slave.wstrb;
                  xtn.wlast[indx]=vif.mon_cb_slave.wlast;
		`uvm_info("SLAVE_AXI_WRDATA_MON",$sformatf("[%0t] Captured beat %0d : wvalid= %0d WREADY =%0d WDATA=0x%0h WSTRB=0x%0h WLAST=%0b",$time, xtn.wvalid, xtn.wready, indx, xtn.wdata[indx], xtn.wstrb[indx], xtn.wlast[indx]), UVM_LOW)
  //                if(xtn.wlast[indx])
	              //   @(vif.mon_cb_slave);

			  if(vif.mon_cb_slave.wlast)
                         begin
			    `uvm_info("SLAVE_AXI_WRDATA_MON", $sformatf("[%0t] printing in wrdata mon %0p", $time, xtn.sprint), UVM_LOW)
			    //mp.write(xtn);
			    indx=0;
                            // xtn.wdata=new[burst_len];
                             //xtn.wstrb=new[burst_len];
                            // xtn.wlast=new[burst_len];
			     break;
                         end
			 else
			 begin
			@(vif.mon_cb_slave);
			 indx++;
			 end
				 
                end
                                   
           end
	   mp.write(xtn);

endtask
endclass:slave_axi_wrdata_mon*/
