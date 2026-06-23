class axi_base_seq extends uvm_sequence #(axi_master_trans);

parameter int ADDR_WIDTH = 32;
parameter int DATA_WIDTH = 64;
parameter int ID_WIDTH = 4;
parameter int USER_WIDTH = 1;


localparam int STRB_WIDTH = (DATA_WIDTH/8);
localparam int SIZE_WIDTH = $clog2(STRB_WIDTH);

  rand bit awrite;
  rand bit [ID_WIDTH - 1 : 0]       aawid;
  rand bit [ADDR_WIDTH-1 : 0 ]      aawaddr;
  rand bit [7:0]                    aawlen;
  rand bit [SIZE_WIDTH-1 : 0]       aawsize;
  rand axi_burst_t                    aawburst;
  rand bit                          aawlock;
  rand axi_cache_t                    aawcache;
  rand axi_prot_t                     aawprot;
  rand axi_qos_t                      aawqos;
  rand axi_region_t                   aawregion;
  rand bit [USER_WIDTH - 1 : 0]     aawuser;
  bit                          aawvalid;

  rand bit [DATA_WIDTH-1 : 0]       awdata[$];
  rand bit [STRB_WIDTH-1 : 0]       awstrb[$];
  rand bit                          awlast[$];
  rand bit [USER_WIDTH - 1 : 0]     awuser;
  bit                          awvalid;
  bit              bbready;
  rand bit [ID_WIDTH - 1 : 0]       aarid;
  rand bit [ADDR_WIDTH-1 : 0 ]      aaraddr;
  rand bit [7:0]                    aarlen;
  rand bit [SIZE_WIDTH-1 : 0]       aarsize;
  rand axi_burst_t                    aarburst;
  rand bit                          aarlock;
  rand axi_cache_t                    aarcache;
  rand axi_prot_t                     aarprot;
  rand axi_qos_t                      aarqos;
  rand axi_region_t                   aarregion;
  rand bit [USER_WIDTH - 1 : 0]     aaruser;
  bit                            aarvalid;
  bit                          arready;
  bit                          aawready;
  bit                          awready;
  bit [ID_WIDTH - 1 : 0]      bbid;
  axi_resp_t                    bbresp;
  bit [USER_WIDTH - 1 : 0]    bbuser;
  bit                         bbvalid;
  bit                         aarready;
  bit [ID_WIDTH - 1 : 0]      arid;
  bit [DATA_WIDTH-1 : 0]      ardata[$];
  axi_resp_t                  araresp[$];
  bit                         arlast;
  bit [USER_WIDTH - 1 : 0]    aruser;
  bit                         arvalid;


   `uvm_object_utils_begin(axi_base_seq)
    `uvm_field_int(awrite, UVM_ALL_ON)
    `uvm_field_int(aawid, UVM_ALL_ON)
    `uvm_field_int(aawaddr, UVM_ALL_ON)
    `uvm_field_int(aawlen, UVM_ALL_ON)
    `uvm_field_int(aawsize, UVM_ALL_ON)
    `uvm_field_enum(axi_burst_t, aawburst, UVM_ALL_ON)
    `uvm_field_int(aawlock, UVM_ALL_ON)
    `uvm_field_enum(axi_cache_t, aawcache, UVM_ALL_ON)
    `uvm_field_enum(axi_prot_t, aawprot, UVM_ALL_ON)
    `uvm_field_enum(axi_qos_t, aawqos, UVM_ALL_ON)
    `uvm_field_enum(axi_region_t, aawregion, UVM_ALL_ON)
    `uvm_field_int(aawuser, UVM_ALL_ON)
    `uvm_field_int(aawvalid, UVM_ALL_ON)
     `uvm_field_int(aawready, UVM_ALL_ON)

    `uvm_field_int(awuser, UVM_ALL_ON)
    `uvm_field_int(awvalid, UVM_ALL_ON)
    `uvm_field_int(awready, UVM_ALL_ON)

    `uvm_field_int(aarid, UVM_ALL_ON)
    `uvm_field_int(aaraddr, UVM_ALL_ON)
    `uvm_field_int(aarlen, UVM_ALL_ON)
    `uvm_field_int(aarsize, UVM_ALL_ON)
    `uvm_field_enum(axi_burst_t, aarburst, UVM_ALL_ON)
    `uvm_field_int(aarlock, UVM_ALL_ON)
    `uvm_field_enum(axi_cache_t, aarcache, UVM_ALL_ON)
    `uvm_field_enum(axi_prot_t, aarprot, UVM_ALL_ON)
    `uvm_field_enum(axi_qos_t, aarqos, UVM_ALL_ON)
    `uvm_field_enum(axi_region_t,aarregion, UVM_ALL_ON)
    `uvm_field_int(aaruser, UVM_ALL_ON)
    `uvm_field_int(aarvalid, UVM_ALL_ON)
    `uvm_field_int(aarready, UVM_ALL_ON)

    `uvm_field_int(arready, UVM_ALL_ON)
    `uvm_field_int(arid, UVM_ALL_ON)
    `uvm_field_int(arlast, UVM_ALL_ON)
    `uvm_field_int(aruser, UVM_ALL_ON)
    `uvm_field_int(arvalid, UVM_ALL_ON)

    `uvm_field_int(bbid, UVM_ALL_ON)
    `uvm_field_enum(axi_resp_t, bbresp, UVM_ALL_ON)
    `uvm_field_int(bbuser, UVM_ALL_ON)
    `uvm_field_int(bbvalid, UVM_ALL_ON)
    `uvm_field_int(bbready, UVM_ALL_ON)
  `uvm_object_utils_end


function new (string name="axi_base_seq");
    super.new(name);
endfunction

task body();
`uvm_info("BASE SEQ","Body staarted",UVM_LOW);
endtask

endclass


class axi_aw_seq extends axi_base_seq;

`uvm_object_utils(axi_aw_seq)

// axi_master_trans tx;

function new (string name="axi_aw_seq");
    super.new(name);
endfunction

task body();
	req=axi_master_trans::type_id::create("req");
	start_item(req);
		req.randomize() with{req.awvalid==1; req.awburst==INCR;};
	finish_item(req);
endtask

endclass

///////////////////////////////////
class axi_w_seq extends axi_base_seq;

`uvm_object_utils(axi_w_seq)

 axi_master_trans tx;

function new (string name="axi_w_seq");
    super.new(name);
endfunction

task body();
	req=axi_master_trans::type_id::create("req");
	start_item(req);
		req.randomize() with{req.wvalid==1;};
	finish_item(req);
endtask

endclass
//////////////////////

class axi_b_seq extends axi_base_seq;// #(axi_master_trans);

`uvm_object_utils(axi_b_seq)



function new (string name="axi_b_seq");
    super.new(name);
endfunction

task body();
	req=axi_master_trans::type_id::create("req");
	start_item(req);
		req.randomize() with {req.bready==1;};
	finish_item(req);
  
endtask

endclass
////////////////////////

class axi_ar_seq extends axi_base_seq;// #(axi_master_trans);

`uvm_object_utils(axi_ar_seq)


function new (string name="axi_ar_seq");
    super.new(name);
endfunction

task body();
	req=axi_master_trans::type_id::create("req");
	start_item(req);
		req.randomize() with{req.arvalid==1;};
	finish_item(req);
endtask

endclass

/////////////////////////

class axi_r_seq extends axi_base_seq;// #(axi_master_trans);

`uvm_object_utils(axi_r_seq)

// axi_master_trans tx;

function new (string name="axi_r_seq");
    super.new(name);
endfunction

task body();
	req=axi_master_trans::type_id::create("req");
	start_item(req);
		req.randomize() with {req.rready==1;};
	finish_item(req);
endtask

endclass

