class axi_xtn extends uvm_sequence_item;
  
parameter int ADDR_WIDTH = 32;
parameter int DATA_WIDTH = 64;
parameter int ID_WIDTH = 4;
parameter int USER_WIDTH = 1;

localparam int STRB_WIDTH = (DATA_WIDTH/8);
localparam int SIZE_WIDTH = $clog2(STRB_WIDTH);


        // Write Address Channel Signal  
  bit [ID_WIDTH - 1 : 0]       awid;
  bit [ADDR_WIDTH-1 : 0 ]      awaddr;
  bit [7:0]                    awlen;
  bit [SIZE_WIDTH-1 : 0]       awsize;
  axi_burst_t                    awburst;
  bit                          awlock;
  axi_cache_t                    awcache;
  axi_prot_t                     awprot;
  axi_qos_t                      awqos;
  axi_region_t                   awregion;
  bit [USER_WIDTH - 1 : 0]     awuser;
  bit                          awvalid;

  // Write Data channel
  bit [DATA_WIDTH-1 : 0]       wdata[];
  bit [STRB_WIDTH-1 : 0]       wstrb[];
  bit                          wlast[];
  bit [USER_WIDTH - 1 : 0]     wuser;
  bit                          wvalid;
  // Write Response channel
  bit              bready;
  // Read Address channel
  bit [ID_WIDTH - 1 : 0]       arid;
  bit [ADDR_WIDTH-1 : 0 ]      araddr;
  bit [7:0]                    arlen;
  bit [SIZE_WIDTH-1 : 0]       arsize;
  axi_burst_t                    arburst;
  bit                          arlock;
  axi_cache_t                    arcache;
  axi_prot_t                     arprot;
  axi_qos_t                      arqos;
  axi_region_t                   arregion;
  bit [USER_WIDTH - 1 : 0]     aruser;
  bit                          arvalid;
  // Read Data channel
  bit                          rready;
  // AXI Interface - MISO
  // Write Addr channel
  bit                          awready;
  // Write Data channel
  bit                          wready;
  // Write Response channel
  bit [ID_WIDTH - 1 : 0]      bid;
 rand   axi_resp_t                    bresp;
  bit [USER_WIDTH - 1 : 0]    buser;
  bit                         bvalid;
  // Read addr channel
  bit                         arready;
  // Read data channel
  bit [ID_WIDTH - 1 : 0]      rid;
  bit [DATA_WIDTH-1 : 0]      rdata[];
  axi_resp_t                    rresp[];
  bit                         rlast[];
  bit [USER_WIDTH - 1 : 0]    ruser;
  bit                         rvalid;
   
   //DELAY 
  rand bit[4:0] arready_delay;
  rand bit[4:0] awready_delay;
  rand bit[4:0] wready_delay;

   ///////////////-----------CONSTRAINTS-----------///////////////////////////

//constraint rr_const{rdata.size()== (arlen+1)*4;}
  
  constraint ready_delay{soft arready_delay==1;
                         soft awready_delay==1;
                         soft wready_delay==1;}
  constraint bresponse{ soft bresp==0;}
  constraint rresponse{ soft foreach(rresp[i])
				rresp[i]==0;}

  `uvm_object_utils_begin(axi_xtn)

    `uvm_field_int(awid, UVM_ALL_ON)
    `uvm_field_int(awaddr, UVM_ALL_ON)
    `uvm_field_int(awlen, UVM_ALL_ON)
    `uvm_field_int(awsize, UVM_ALL_ON)
    `uvm_field_enum(axi_burst_t, awburst, UVM_ALL_ON)
    `uvm_field_int(awlock, UVM_ALL_ON)
    `uvm_field_enum(axi_cache_t, awcache, UVM_ALL_ON)
    `uvm_field_enum(axi_prot_t, awprot, UVM_ALL_ON)
    `uvm_field_enum(axi_qos_t, awqos, UVM_ALL_ON)
    `uvm_field_enum(axi_region_t, awregion, UVM_ALL_ON)
    `uvm_field_int(awuser, UVM_ALL_ON)
    `uvm_field_int(awvalid, UVM_ALL_ON)
     `uvm_field_int(awready, UVM_ALL_ON)


  //  `uvm_field_queue_int(wdata, UVM_ALL_ON)
    //`uvm_field_queue_int(wstrb, UVM_ALL_ON)
    //`uvm_field_queue_int(wlast, UVM_ALL_ON)
    `uvm_field_array_int(wdata, UVM_ALL_ON)
    `uvm_field_array_int(wstrb, UVM_ALL_ON)
    `uvm_field_array_int(wlast, UVM_ALL_ON)
    `uvm_field_int(wuser, UVM_ALL_ON)
    `uvm_field_int(wvalid, UVM_ALL_ON)
    `uvm_field_int(wready, UVM_ALL_ON)

    `uvm_field_int(arid, UVM_ALL_ON)
    `uvm_field_int(araddr, UVM_ALL_ON)
    `uvm_field_int(arlen, UVM_ALL_ON)
    `uvm_field_int(arsize, UVM_ALL_ON)
    `uvm_field_enum(axi_burst_t, arburst, UVM_ALL_ON)
    `uvm_field_int(arlock, UVM_ALL_ON)
    `uvm_field_enum(axi_cache_t, arcache, UVM_ALL_ON)
    `uvm_field_enum(axi_prot_t, arprot, UVM_ALL_ON)
    `uvm_field_enum(axi_qos_t, arqos, UVM_ALL_ON)
    `uvm_field_enum(axi_region_t,arregion, UVM_ALL_ON)
    `uvm_field_int(aruser, UVM_ALL_ON)
    `uvm_field_int(arvalid, UVM_ALL_ON)
    `uvm_field_int(arready, UVM_ALL_ON)

    `uvm_field_int(rready, UVM_ALL_ON)
    `uvm_field_int(rid, UVM_ALL_ON)
  //  `uvm_field_queue_int(rdata, UVM_ALL_ON)
//    `uvm_field_queue_int(rresp, UVM_ALL_ON)
  //  `uvm_field_queue_int(rlast, UVM_ALL_ON)
    `uvm_field_array_int(rdata, UVM_ALL_ON)
//   `uvm_field_array_int(rresp, UVM_ALL_ON)
    `uvm_field_array_int(rlast, UVM_ALL_ON)
    `uvm_field_int(ruser, UVM_ALL_ON)
    `uvm_field_int(rvalid, UVM_ALL_ON)

    `uvm_field_int(bid, UVM_ALL_ON)
    `uvm_field_enum(axi_resp_t, bresp, UVM_ALL_ON)
    `uvm_field_int(buser, UVM_ALL_ON)
    `uvm_field_int(bvalid, UVM_ALL_ON)
    `uvm_field_int(bready, UVM_ALL_ON)
  `uvm_object_utils_end
  function new(string name = "axi_xtn");
    super.new(name);
  endfunction
endclass
