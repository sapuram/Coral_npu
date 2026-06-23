//`include "coralnpu_pkg.sv"
import coralnpu_pkg::*;
interface axi_master_if #(
parameter int ADDR_WIDTH = 32,
parameter int DATA_WIDTH = 64,
parameter int ID_WIDTH = 4,
parameter int USER_WIDTH = 1

)(input bit aclk, input bit  aresetn);



//import coralnpu_pkg::*;

localparam int STRB_WIDTH = (DATA_WIDTH/8);
localparam int SIZE_WIDTH = $clog2(STRB_WIDTH);

        // Write Address Channel Signal  
  logic [ID_WIDTH - 1 : 0]       awid;
  logic [ADDR_WIDTH-1 : 0 ]      awaddr;
  logic [7:0]                    awlen;
  logic [SIZE_WIDTH-1 : 0]       awsize;
  axi_burst_t                    awburst;
  logic                          awlock;
  axi_cache_t                    awcache;
  axi_prot_t                     awprot;
  axi_qos_t                      awqos;
  axi_region_t                   awregion;
  logic [USER_WIDTH - 1 : 0]     awuser;
  logic                          awvalid;

  // Write Data channel
  logic [DATA_WIDTH-1 : 0]       wdata;
  logic [STRB_WIDTH-1 : 0]       wstrb;
  logic                          wlast;
  logic [USER_WIDTH - 1 : 0]     wuser;
  logic                          wvalid;
  // Write Response channel
  logic              bready;
  // Read Address channel
  logic [ID_WIDTH - 1 : 0]       arid;
  logic [ADDR_WIDTH-1 : 0 ]      araddr;
  logic [7:0]                    arlen;
  logic [SIZE_WIDTH-1 : 0]       arsize;
  axi_burst_t                    arburst;
  logic                          arlock;
  axi_cache_t                    arcache;
  axi_prot_t                     arprot;
  axi_qos_t                      arqos;
  axi_region_t                   arregion;
  logic [USER_WIDTH - 1 : 0]     aruser;
logic             		 arvalid;
  // Read Data channel
  logic             		 rready;
  // AXI Interface - MISO
  // Write Addr channel
  logic         		 awready;
  // Write Data channel
  logic               		 wready;
  // Write Response channel
  logic [ID_WIDTH - 1 : 0]      bid;
  axi_resp_t          		bresp;
  logic [USER_WIDTH - 1 : 0]    buser;
  logic  	                bvalid;
  // Read addr channel
  logic               		arready;
  // Read data channel
  logic [ID_WIDTH - 1 : 0]      rid;
  logic [DATA_WIDTH-1 : 0]      rdata;
  axi_resp_t       	        rresp;
  logic                         rlast;
  logic [USER_WIDTH - 1 : 0] 	ruser;
  logic              		rvalid;

  clocking drv_cb_master @(posedge aclk);
    default input #1 output #0;
    input aresetn;
        output awid,awvalid, awaddr,  awlen, awsize, awburst, awlock, awcache,  awprot, awqos,  awregion, awuser;
        input awready;

        output wdata,  wstrb, wlast,  wuser,  wvalid;
        input wready;

        input bid,bresp,buser,bvalid;
        output bready;

        output arid,araddr,arlen,arsize,arburst,arlock,arcache,arprot,arqos,arregion,aruser,arvalid;
        input arready;

        input rid, rdata,rresp, rlast,ruser, rvalid;
        output rready;
    endclocking

    clocking mon_cb_master @(posedge aclk);
  default input #1 output #0;
  input awid, awvalid, awaddr, awlen, awsize, awburst,
        awlock, awcache, awprot, awqos, awregion, awuser;
    input    awready;

  input wdata, wstrb, wlast, wuser, wvalid;
  input wready;

  input bid, bresp, buser, bvalid; 
	  input bready;
  input arid, araddr, arlen, arsize, arburst,
        arlock, arcache, arprot, arqos, arregion,
        aruser, arvalid;
  input arready;
  input rid, rdata, rresp, rlast, ruser, rvalid;
  input rready;
endclocking

  modport M_DRV(clocking drv_cb_master);
  modport M_MON(clocking mon_cb_master);

endinterface
