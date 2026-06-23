class axi_m_w_driver extends uvm_driver#(axi_master_trans);



`uvm_component_utils(axi_m_w_driver)

  virtual axi_master_if vif;

  axi_master_trans tx;



 function new(string name="axi_m_w_driver",uvm_component parent=null);

		super.new(name,parent);

 endfunction

	

virtual function void build_phase(uvm_phase phase);

	super.build_phase(phase);	

  if(!uvm_config_db #(virtual axi_master_if)::get(this,"","axi_master_if",vif))
	  `uvm_error("Driver","check the aw config errorrrrr"); 

 endfunction

task initialize();
@(posedge vif.aclk);
vif.wdata<=0;
vif.wstrb<=0;
vif.wvalid<=0;
vif.wlast<=0;
vif.wuser<=0;
endtask

virtual task run_phase(uvm_phase phase);

	forever begin	
	if(!vif.aresetn) begin
		     initialize();
	     @(posedge vif.aresetn);
     end
		seq_item_port.get_next_item(req);
                req.print();
		drive_tx(req);

		seq_item_port.item_done();

	end

 endtask

bit [2:0] count,cnt_var,unaln;
bit [7:0] strb_tmp;

 task drive_tx(axi_master_trans tx);
  if(req.write == 1) begin	

	write_data_phase(req);

  end

 endtask


/*task write_data_phase(axi_master_trans tx);
 cnt_var = 2**(tx.awsize);  //1,2,4,8
  unaln=tx.awaddr%cnt_var;
	
  if(tx.awaddr== 0) 
    count=0;
  else if(tx.awaddr%8==0)
    count=0;
  else if(tx.awaddr%7==0)
    count=7;
  else if(tx.awaddr%6==0)
    count=6;
  else if(tx.awaddr%5==0)
    count=5;
  else if(tx.awaddr%4==0)
    count=4;
  else if(tx.awaddr%3==0)
    count=3;
  else if(tx.awaddr%2==0)
    count=2;
  else if(tx.awaddr%1==0)
    count=1;
 for(int i=0;i <=tx.awlen;i++) begin

  @(posedge vif.aclk)

  vif.wdata <=tx.wdata.pop_front();
  strb_tmp=0;
  if(i==0)begin
   for(int j=count;j<(count+cnt_var-unaln);j++) 
    strb_tmp[j]=1;
    count=count+cnt_var-unaln;
    end
  else begin
   for(int k=0;k<cnt_var;k++)
    strb_tmp[count+k]=1;
    count = count+cnt_var;
   end
   $display("The value if wstrobe is %b, count is %b, cnt var is %b,awaddr = %h,awsize = %h",strb_tmp,count,cnt_var,tx.awaddr,tx.awsize);
  vif.wstrb <=strb_tmp;
$display("The value if wstrobe is %b",vif.wstrb);
  vif.wvalid <=1;
vif.wstrb<=tx.wstrb;
  if(i==tx.awlen) begin

    vif.wlast <=1;

  end

  wait(vif.wready==1);
`uvm_info("DRIVER","got the req//////////////////////////////////44444444444",UVM_LOW);
  end

   @(posedge vif.aclk)
  vif.wlast <=0;
  vif.wvalid <=0;
  vif.wstrb<=0; 
endtask*/
task write_data_phase(axi_master_trans tx);



  int bytes_per_beat;

  int lane_offset;

  int valid_bytes;



  bytes_per_beat = 1 << tx.awsize;  // 1,2,4,8



  for (int i = 0; i <= tx.awlen; i++) begin

    @(posedge vif.aclk);



    // DATA per beat

    vif.wdata <= tx.wdata.pop_front();



    // ---- WSTRB generation (FIXED) ----

    strb_tmp = '0;


    if (i == 0)

      lane_offset = tx.awaddr % 8;

    else

      lane_offset = 0;


    valid_bytes = bytes_per_beat;

    if ((lane_offset + valid_bytes) > 8)

      valid_bytes = 8 - lane_offset;



    for (int b = 0; b < valid_bytes; b++)

      strb_tmp[lane_offset + b] = 1'b1;



    vif.wstrb  <= strb_tmp;

    vif.wvalid <= 1;

    vif.wlast  <= (i == tx.awlen);



    wait (vif.wready == 1);



    `uvm_info("DRIVER",

      $sformatf("WRITE beat=%0d addr=%0d WDATA=%h WSTRB=%b",

        i,

        tx.awaddr + i*bytes_per_beat,

        vif.wdata,

        vif.wstrb),

      UVM_LOW);

  end



  @(posedge vif.aclk);

  vif.wvalid <= 0;

  vif.wlast  <= 0;

  vif.wstrb  <= 0;



endtask

/*task write_data_phase(axi_master_trans tx);

  int bus_bytes;

  bit [7:0] strb_tmp;

  bus_bytes = 8;

  for (int i = 0; i <= tx.awlen; i++) begin

    @(posedge vif.aclk);

    vif.wdata <= tx.wdata.pop_front();

    if ((1 << tx.awsize) == bus_bytes)

      strb_tmp = 8'hFF;

    else

      strb_tmp = ((1 << (1 << tx.awsize)) - 1) << tx.awaddr[2:0];

    vif.wstrb  <= strb_tmp;

    vif.wvalid <= 1;

    vif.wlast  <= (i == tx.awlen);

    wait (vif.wready == 1);

    `uvm_info("W_DRIVER",

      $sformatf("Beat=%0d WDATA=%h WSTRB=%b AWADDR=%h AWSIZE=%0d",

                i, vif.wdata, vif.wstrb, tx.awaddr, tx.awsize),

      UVM_LOW);

  end

  @(posedge vif.aclk);

  vif.wvalid <= 0;

  vif.wlast  <= 0;

  vif.wstrb  <= 0;

endtask*/


endclass

