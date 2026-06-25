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

                
                virtual task run_phase(uvm_phase phase);
                forever   //// beats should run or drive irespective of recving trans or not .using main_drive()
                        begin

								seq_item_port.try_next_item(req);

                                                                seq_item_port.item_done(); 
                        end
                endtask

endclass
