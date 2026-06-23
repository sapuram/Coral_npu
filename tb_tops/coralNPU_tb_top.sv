module coralnpu_top_tb;

`include "uvm_macros.svh"
import uvm_pkg::*;
import coralnpu_pkg::*;

parameter int unsigned ADDR_WIDTH=32;
parameter int unsigned DATA_WIDTH=128;
parameter int unsigned ID_WIDTH=6;


logic clk, resetn; 


//clcok generation
initial begin 
	clk =0 ;
		forever begin 
			#5 clk =~clk;
		end 
end 

//AXI_Interafce instancations
axi_master_if #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH), .ID_WIDTH(ID_WIDTH)) master_if (.aclk(clk), .aresetn(resetn)); 
axi_slave_if #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH), .ID_WIDTH(ID_WIDTH)) slave_if (.aclk(clk), .aresetn(resetn));


//Top_Wrapper_Instance. 
RvvCoreMiniVerificationAxi DUT(
		.io_aclk(clk), 
		.io_aresetn(resetn),

    // AXI Slave Port (Driven by TB Master)
    .io_axi_slave_write_addr_valid     (master_if.awvalid),
    .io_axi_slave_write_addr_ready     (master_if.awready),
    .io_axi_slave_write_addr_bits_addr (master_if.awaddr),
    .io_axi_slave_write_addr_bits_prot (master_if.awprot),
    .io_axi_slave_write_addr_bits_id   (master_if.awid),
    .io_axi_slave_write_addr_bits_len  (master_if.awlen),
    .io_axi_slave_write_addr_bits_size (master_if.awsize),
    .io_axi_slave_write_addr_bits_burst(master_if.awburst),
    .io_axi_slave_write_addr_bits_lock (master_if.awlock),
    .io_axi_slave_write_addr_bits_cache(master_if.awcache),
    .io_axi_slave_write_addr_bits_qos  (master_if.awqos),
    .io_axi_slave_write_addr_bits_region(master_if.awregion),

    .io_axi_slave_write_data_valid     (master_if.wvalid),
    .io_axi_slave_write_data_ready     (master_if.wready),
    .io_axi_slave_write_data_bits_data (master_if.wdata),
    .io_axi_slave_write_data_bits_last (master_if.wlast),
    .io_axi_slave_write_data_bits_strb (master_if.wstrb),

    .io_axi_slave_write_resp_valid     (master_if.bvalid),
    .io_axi_slave_write_resp_ready     (master_if.bready),
    .io_axi_slave_write_resp_bits_id   (master_if.bid),
    .io_axi_slave_write_resp_bits_resp (master_if.bresp),

    .io_axi_slave_read_addr_valid      (master_if.arvalid),
    .io_axi_slave_read_addr_ready      (master_if.arready),
    .io_axi_slave_read_addr_bits_addr  (master_if.araddr),
    .io_axi_slave_read_addr_bits_prot  (master_if.arprot),
    .io_axi_slave_read_addr_bits_id    (master_if.arid),
    .io_axi_slave_read_addr_bits_len   (master_if.arlen),
    .io_axi_slave_read_addr_bits_size  (master_if.arsize),
    .io_axi_slave_read_addr_bits_burst (master_if.arburst),
    .io_axi_slave_read_addr_bits_lock  (master_if.arlock),
    .io_axi_slave_read_addr_bits_cache (master_if.arcache),
    .io_axi_slave_read_addr_bits_qos   (master_if.arqos),
    .io_axi_slave_read_addr_bits_region(master_if.arregion),

    .io_axi_slave_read_data_valid      (master_if.rvalid),
    .io_axi_slave_read_data_ready      (master_if.rready),
    .io_axi_slave_read_data_bits_data  (master_if.rdata),
    .io_axi_slave_read_data_bits_id    (master_if.rid),
    .io_axi_slave_read_data_bits_resp  (master_if.rresp),
    .io_axi_slave_read_data_bits_last  (master_if.rlast),


    // AXI Master Port (Drives TB Slave)
    .io_axi_master_write_addr_valid   (slave_if.awvalid),
    .io_axi_master_write_addr_ready   (slave_if.awready),
    .io_axi_master_write_addr_bits_addr(slave_if.awaddr),
    .io_axi_master_write_addr_bits_prot(slave_if.awprot),
    .io_axi_master_write_addr_bits_id (slave_if.awid),
    .io_axi_master_write_addr_bits_len(slave_if.awlen),
    .io_axi_master_write_addr_bits_size(slave_if.awsize),
    .io_axi_master_write_addr_bits_burst(slave_if.awburst),
    .io_axi_master_write_addr_bits_lock(slave_if.awlock),
    .io_axi_master_write_addr_bits_cache(slave_if.awcache),
    .io_axi_master_write_addr_bits_qos(slave_if.awqos),
    .io_axi_master_write_addr_bits_region(slave_if.awregion),

    .io_axi_master_write_data_valid   (slave_if.wvalid),
    .io_axi_master_write_data_ready   (slave_if.wready),
    .io_axi_master_write_data_bits_data(slave_if.wdata),
    .io_axi_master_write_data_bits_last(slave_if.wlast),
    .io_axi_master_write_data_bits_strb(slave_if.wstrb),

    .io_axi_master_write_resp_valid   (slave_if.bvalid),
    .io_axi_master_write_resp_ready   (slave_if.bready),
    .io_axi_master_write_resp_bits_id (slave_if.bid),
    .io_axi_master_write_resp_bits_resp(slave_if.bresp),

    .io_axi_master_read_addr_valid    (slave_if.arvalid),
    .io_axi_master_read_addr_ready    (slave_if.arready),
    .io_axi_master_read_addr_bits_addr(slave_if.araddr),
    .io_axi_master_read_addr_bits_prot(slave_if.arprot),
    .io_axi_master_read_addr_bits_id  (slave_if.arid),
    .io_axi_master_read_addr_bits_len (slave_if.arlen),
    .io_axi_master_read_addr_bits_size(slave_if.arsize),
    .io_axi_master_read_addr_bits_burst(slave_if.arburst),
    .io_axi_master_read_addr_bits_lock (slave_if.arlock),
    .io_axi_master_read_addr_bits_cache(slave_if.arcache),
    .io_axi_master_read_addr_bits_qos  (slave_if.arqos),
    .io_axi_master_read_addr_bits_region(slave_if.arregion),

    .io_axi_master_read_data_valid    (slave_if.rvalid),
    .io_axi_master_read_data_ready    (slave_if.rready),
    .io_axi_master_read_data_bits_data(slave_if.rdata),
    .io_axi_master_read_data_bits_id  (slave_if.rid),
    .io_axi_master_read_data_bits_resp(slave_if.rresp),
    .io_axi_master_read_data_bits_last(slave_if.rlast),

    //TODO: IRQ, Control, and Status Signals
    .io_irq(), 
    .io_te(),
    .io_halted(),
    .io_fault(),
    .io_wfi(),

    // TODO: Connect Debug and Logging ports if needed by TB
    .io_debug_en(),
    .io_debug_addr_0(),
    .io_debug_addr_1(),
    .io_debug_addr_2(),
    .io_debug_addr_3(),
    .io_debug_inst_0(),
    .io_debug_inst_1(),
    .io_debug_inst_2(),
    .io_debug_inst_3(),
    .io_debug_cycles()
);

task d; 
	@(posedge clk);
endtask

initial begin
	$display("RESET_DUT_start's");
	resetn=0;
	d;d;d;d;d;
	resetn=1;
	$display($time, "RESET_Completed");
	d;
	
end 

initial begin 
	uvm_config_db#(virtual axi_master_if)::set(null, "*", "master_if", master_if);
	uvm_config_db#(virtual axi_slave_if)::set(null, "*", "slave_if", slave_if);
	uvm_config_db#(virtual axi_master_if)::set(null, "*", "axi_master_if", master_if);
	uvm_config_db#(virtual axi_slave_if)::set(null, "*", "axi_slave_if", slave_if);
	run_test();
end 

 initial begin
    $fsdbDumpfile("inter.fsdb"); 
    $fsdbDumpvars(0, coralnpu_top_tb, "+all");
 end

endmodule
