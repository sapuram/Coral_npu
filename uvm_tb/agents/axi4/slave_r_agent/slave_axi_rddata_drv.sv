/////////////////////////////////////////working code updated///////////////////////
class slave_axi_rddata_drv extends uvm_driver#(axi_xtn);
         `uvm_component_utils(slave_axi_rddata_drv);
        int burst_len;
        int bytes_per_beat;
        int total_bytes;
        int beat;
        int lane;
        int addr,base;
       bit last_beat;
        axi_xtn xtn;
        axi_xtn q_read[$];
        typedef struct {
         logic [3:0] rid;
         logic [63:0] data;
         bit last;
	 logic [1:0] resp;
         } r_read;
//
	r_read assoc_arr[int][$];
	r_read item;
	int enable;
//
        r_read read_que[$];
         axi_slave_agent_top agent_top;
		 int q_var;   /// q_var used to control the sequnece flow 
		 int trans_count;  //to count the transactions
		 int rid_q[$]; //to store the rids when rlast become true
         r_read en_beat;  //used to drive randomized data from the rid_index_asso_array
         virtual axi_slave_if.S_DRV vif;
         slave_axi_rddata_config cfg;
         function new(string name="slave_axi_rddata_drv",uvm_component parent);
                 super.new(name,parent);
         endfunction
         function void build_phase(uvm_phase phase);
           super.build_phase(phase);
                 if(! uvm_config_db#(slave_axi_rddata_config)::get(this,"","slave_axi_rddata_config",cfg))
                         `uvm_fatal("SLAVE_AXI_RDDATA_DRIVER","CONFIGURATION IS NOT GETTING IN DRIVER CLASS")
                if(! uvm_config_db #(axi_slave_agent_top)::get(this,"","axi_slave_agent_top",agent_top))
                        `uvm_fatal("SLAVE_AXI_RDDATA_DRIVER","CONFIGURATION IS NOT GETTING IN DRIVER CLASS")
                endfunction
                
                //FUNCTION CONNECT_PHASE 
                
                virtual function void connect_phase(uvm_phase phase);
                  super.connect_phase(phase);
                        vif=cfg.vif;
                endfunction
                
                // TASK RUN_PHASE 
                
                
                virtual task run_phase(uvm_phase phase);
                  $display("akashraj run_phase start");
                        @(vif.drv_cb_slave);
                        if(vif.drv_cb_slave.aresetn==0)//changed
                begin
                        vif.drv_cb_slave.rvalid <=0;
                        vif.drv_cb_slave.rid    <= 0;
                         vif.drv_cb_slave.rdata  <= '0;
                         vif.drv_cb_slave.rresp  <= AXI_OKAY;
                         vif.drv_cb_slave.rlast  <= 0;
                end
                wait(vif.drv_cb_slave.aresetn==1);
//              @(vif.drv_cb_slave);
                forever   //// beats should run or drive irespective of recving trans or not .using main_drive()
                        begin
                                   $display("akashraj forever start");
                                   
                               // seq_item_port.get_next_item(req);
								seq_item_port.try_next_item(req);
								if(req==null) begin                      /// if we are not reciveing any trans conti with the beat .
								 #1;
								 
								 $display("akashraj 2");
								
								    main_drive();  end 
								else begin
								$display("akashraj 3 else try_item");  // if we recive trans 
								
								drive_rdata(req);
                                                                trans_count++;
                                                                seq_item_port.item_done(); 
								end
							//	else
                        end
                endtask
                
////////////////////////       TASK DRIVE_RDATA /////////////////////////////                
task drive_rdata(axi_xtn xtn);
burst_len      = xtn.arlen + 1;
  bytes_per_beat = 1 << xtn.arsize;
  total_bytes    = burst_len * bytes_per_beat;
  xtn.rdata = new[burst_len];
  xtn.rlast = new[burst_len];
////////////////////////////   LOGIC FOR THE BYTE AND BEAT  ///////////////
  `uvm_info("RDDATA_DBG",    $sformatf("ARADDR=%0d ARSIZE=%0d BYTES/BEAT=%0d ARLEN=%0d BURST_LEN=%0d", xtn.araddr, xtn.arsize, bytes_per_beat, xtn.arlen, burst_len), UVM_MEDIUM)
  for (int i = 0; i < burst_len; i++) begin // this is for the beat increament 
    base = agent_top.ADDR[i];
    for (int j = 0; j < bytes_per_beat; j++) begin
      lane = j; //  IT IS FOR BYTE INCREMENT 
      addr = base + lane; // WE ARE  INCR BYTE ADDR ONE BY ONE 
      if (agent_top.memory.exists(addr)) begin
        xtn.rdata[i][8*lane +: 8] = agent_top.memory[addr];
        `uvm_info("RDDATA_BYTE", $sformatf("READ  addr=%0d lane=%0d data=0x%02h",
            addr, lane, agent_top.memory[addr]),UVM_LOW)
      end
      else begin
        agent_top.memory[addr] = $urandom_range(0,255);
        xtn.rdata[i][8*lane +: 8] = agent_top.memory[addr];
        `uvm_info("RDDATA_BYTE",$sformatf("INIT  addr=%0d lane=%0d data=0x%02h",
            addr, lane, agent_top.memory[addr]),UVM_LOW)
      end
   end
end
//r_read read_duo[$];
 //////////////////////   LOGIC FOR COMMOM QUEUE ////////////
for (int b = 0; b < burst_len; b++) begin
  last_beat = (b == burst_len-1);
  read_que.push_back('{xtn.rid, xtn.rdata[b], last_beat,xtn.rresp[b]});
  if (last_beat) rid_q.push_back(xtn.rid);  //rid_q is working fine
end
//interleave();
////////WORKING CODE for common queue to pass to the bus/////////
/*for(int k=q_var; k< read_que.size; k++) begin
   drive_beat(read_que[k]);
   `uvm_info("akashraj",$sformatf("K : %0d reqd_que=%0p ",k,read_que[k]),UVM_LOW)
   q_var++;
end*/
 
////////////    ASSOC ARRAY (WORKING)    /////////
 
while(read_que.size>0) begin   /// THIS WILL BE DONE WITHIN ONE TIME ONLY .  
  //count = read_que  
  //assoc_arr[count] = read_que.pop_front;
  assoc_arr[read_que[0].rid].push_back(read_que.pop_front);  
end
   `uvm_info("semaitech",$sformatf("assoc_arr:%0p",read_que),UVM_LOW)   //  this show s that no need of the commom  queue .
   `uvm_info("TEST_DE",$sformatf("assoc_arr:%0p",assoc_arr),UVM_LOW)
   `uvm_info("TEST_DE",$sformatf("rid_q:%0p",rid_q),UVM_LOW)
   `uvm_info("TEST_DE",$sformatf("trans_count:%0d",trans_count),UVM_LOW)
main_drive();
endtask
 
 
 /////////////  TASK MAIN_DRIVE  ///////////////////////
 
task main_drive();
if (assoc_arr.num>0) begin 
	if(trans_count>0)    begin 
	$display("TEST_DE trans >0 %0d",trans_count);
	drive_1_task() ;
                             end 
	else            begin 
	
       drive_2_task();  
       $display("TEST_DE trans =0 %0d",trans_count); end 
end
 
endtask 

 //////////////////// TASK DRIVE_1_TASK ///////////////////
 
task drive_1_task();
 
int en;  
en=$urandom_range(0,rid_q.size-1);
//en=$urandom_range(0,3);
if(assoc_arr.exists(rid_q[en])) begin
en_beat=assoc_arr[rid_q[en]].pop_front();
   `uvm_info("mukesh",$sformatf("en:%0d, en_beat:%0p, remain item in queu:%0p",en, en_beat,assoc_arr[rid_q[en]]),UVM_LOW)
end
 
if(en_beat.last) begin rid_q.delete(en);  trans_count--; end
drive_beat(en_beat);
 
//while(!en_beat.last) begin trans_count--; end
 $display("TEST_DEBUG the drive_task_1 completed");
 
endtask   
 
 //task 1 is for the first trans , till no other trans is recived works like an in-order format .
 
 //////////////////  TASK DRIVE_2_TASK   //////////////////////
 
 
task drive_2_task();
if(assoc_arr.exists(rid_q[0])) begin  // it is waiting for only the first trans .
    en_beat=assoc_arr[rid_q[0]].pop_front() ;
    drive_beat(en_beat);
    end 
  $display("TEST_DE driver_task_2 en_beat : %0p",en_beat);
    
  endtask 

 
 
task drive_beat(r_read beat);
     $display("TEST_DE driver beat task ");
     
   @(vif.drv_cb_slave);
    vif.drv_cb_slave.rid    <= beat.rid;
    vif.drv_cb_slave.rdata  <= beat.data;
    vif.drv_cb_slave.rresp  <= beat.resp;
    vif.drv_cb_slave.rlast  <= beat.last;
    vif.drv_cb_slave.rvalid <= 1'b1;
   //wait(vif.drv_cb_slave.rready);
   while(!vif.drv_cb_slave.rready)
   @(vif.drv_cb_slave);
  //vif.drv_cb_slave.rvalid <= 1'b0;
  endtask
endclass
