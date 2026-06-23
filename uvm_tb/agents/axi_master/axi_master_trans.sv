class axi_master_trans extends uvm_sequence_item;
	
parameter int ADDR_WIDTH = 32;
parameter int DATA_WIDTH = 64;
parameter int ID_WIDTH = 4;
parameter int USER_WIDTH = 1;


localparam int STRB_WIDTH = (DATA_WIDTH/8);
localparam int SIZE_WIDTH = $clog2(STRB_WIDTH);

  rand bit write;
        // Write Address Channel Signal  
  rand bit [ID_WIDTH - 1 : 0]       awid;
  rand bit [ADDR_WIDTH-1 : 0 ]      awaddr;
  rand bit [7:0]                    awlen;
  rand bit [SIZE_WIDTH-1 : 0]       awsize;
  rand axi_burst_t                    awburst;
  rand bit                          awlock;
  rand axi_cache_t                    awcache;
  rand axi_prot_t                     awprot;
  rand axi_qos_t                      awqos;
  rand axi_region_t                   awregion;
  rand bit [USER_WIDTH - 1 : 0]     awuser;
  rand bit                          awvalid;

  // Write Data channel
  rand bit [DATA_WIDTH-1 : 0]       wdata[$];
  rand bit [STRB_WIDTH-1 : 0]       wstrb;
  rand bit                          wlast[$];
  rand bit [USER_WIDTH - 1 : 0]     wuser;
  rand bit                          wvalid;
  // Write Response channel
  rand bit              bready;
  // Read Address channel
  rand bit [ID_WIDTH - 1 : 0]       arid;
  rand bit [ADDR_WIDTH-1 : 0 ]      araddr;
  rand bit [7:0]                    arlen;
  rand bit [SIZE_WIDTH-1 : 0]       arsize;
  rand axi_burst_t                    arburst;
  rand bit                          arlock;
  rand axi_cache_t                    arcache;
  rand axi_prot_t                     arprot;
  rand axi_qos_t                      arqos;
  rand axi_region_t                   arregion;
  rand bit [USER_WIDTH - 1 : 0]     aruser;
  rand bit                            arvalid;
// Read Data channel
  rand bit                          rready;
  // AXI Interface - MISO
  // Write Addr channel
  bit                          awready;
  // Write Data channel
  bit                          wready;
  // Write Response channel
  bit [ID_WIDTH - 1 : 0]      bid;
  axi_resp_t                    bresp;
  bit [USER_WIDTH - 1 : 0]    buser;
  bit                         bvalid;
  // Read addr channel
  bit                         arready;
  // Read data channel
  bit [ID_WIDTH - 1 : 0]      rid;
  bit [DATA_WIDTH-1 : 0]      rdata[$];
  axi_resp_t                  rresp[$];
  bit                         rlast;
  bit [USER_WIDTH - 1 : 0]    ruser;
  bit                         rvalid;


   `uvm_object_utils_begin(axi_master_trans)
    `uvm_field_int(write, UVM_ALL_ON)
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

//    `uvm_field_queue_int(wlast, UVM_ALL_ON)
//    `uvm_field_array_int(wdata, UVM_ALL_ON)
//   `uvm_field_int(wstrb, UVM_ALL_ON)
  //  `uvm_field_array_int(wlast, UVM_ALL_ON)
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
   // `uvm_field_array_int(rdata, UVM_ALL_ON)
    `uvm_field_int(rlast, UVM_ALL_ON)
    `uvm_field_int(ruser, UVM_ALL_ON)
    `uvm_field_int(rvalid, UVM_ALL_ON)

    `uvm_field_int(bid, UVM_ALL_ON)
    `uvm_field_enum(axi_resp_t, bresp, UVM_ALL_ON)
    `uvm_field_int(buser, UVM_ALL_ON)
    `uvm_field_int(bvalid, UVM_ALL_ON)
    `uvm_field_int(bready, UVM_ALL_ON)
  `uvm_object_utils_end


//  constraint aw_addr{awaddr % (2**awsize)==0;}
//  constraint ar_addr{araddr % (2**arsize)==0;}
  //constraint id{arid==rid;}
//constraint str1 {wstrb.size() == awlen+1;}
//constraint strb2 {foreach()}
function new (string name ="");
    super.new(name);
  endfunction

  endclass
