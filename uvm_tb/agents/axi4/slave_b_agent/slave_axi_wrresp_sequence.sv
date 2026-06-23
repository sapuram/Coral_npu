class slave_axi_wrresp_sequence  extends uvm_sequence #(axi_xtn);

        `uvm_object_utils(slave_axi_wrresp_sequence)

       int ID_VALUE=10;
       axi_xtn wr_resp[$]; 

function new(string name="slave_axi_wrresp_sequence");
        super.new(name);
endfunction

task body();
	$display("bresp");
req=wr_resp.pop_front();
//`uvm_info("WRRESP_SEQ", $sformatf("%p", wr_resp),UVM_LOW)
start_item(req);
//`uvm_info("WRRESP_SEQ", $sformatf("Entered sequence body %p", req.sprint),UVM_LOW)
finish_item(req);
 $display("bresp finished");

endtask



/*task  body();
begin
req=axi_xtn::type_id::create("req");
 `uvm_info("WRRESP_SEQ", "Entered WRRESP sequence body", UVM_LOW)
  start_item(req);
  assert (req.randomize());// with {bid == ID_VALUE;});
`uvm_info("WRRESP_SEQ", $sformatf("Entered sequence body %p", req.sprint),UVM_LOW)
  finish_item(req);
end
endtask */
          
endclass:slave_axi_wrresp_sequence

