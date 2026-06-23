class axi_slave_agent_top extends uvm_env;
	`uvm_component_utils(axi_slave_agent_top) 

	bit[7:0] memory [int]; //This is a dynamic associative array indexed by long int(fexiable) /int

	slave_axi_wraddr_agent wr_addr_agth;
	slave_axi_wrdata_agent wr_data_agth;
	slave_axi_wrresp_agent wr_resp_agth;
	slave_axi_rdaddr_agent rd_addr_agth;
	slave_axi_rddata_agent rd_data_agth;

	int start_addr;
	int ADDR[];

	function new(string name="axi_slave_agent_top", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		wr_addr_agth=slave_axi_wraddr_agent::type_id::create("wr_addr_agth",this);
		wr_data_agth=slave_axi_wrdata_agent::type_id::create("wr_data_agth",this);
		wr_resp_agth=slave_axi_wrresp_agent::type_id::create("wr_resp_agth",this);
		rd_addr_agth=slave_axi_rdaddr_agent::type_id::create("rd_addr_agth",this);
		rd_data_agth=slave_axi_rddata_agent::type_id::create("rd_data_agth",this);
	endfunction

	/*function void addr_cal(input int ADDRS, bit[2:0]SIZE, bit[7:0]LEN, bit[1:0]BURST);
		start_addr=ADDRS;
		number_of_bytes=2**SIZE;
		burst_length=LEN+1;
		transfer_size = burst_length * number_of_bytes;
		aligned_addr=(int'(start_addr/number_of_bytes))*number_of_bytes;
		ADDR=new[burst_length];
		wrap_boundary=(int'(start_addr/(number_of_bytes*burst_length)))*(number_of_bytes*burst_length);
		ADDR[0]=start_addr;

		for(int i=1;i<=LEN;i++)
			//foreach(ADDR[i])
	begin
		if(BURST==0)
			ADDR[i]=ADDRS;

		else if(BURST==1)
			ADDR[i]=aligned_addr+(i*number_of_bytes);

		else if(BURST==2)
		begin
			if(!k)
			begin
				ADDR[i]=aligned_addr+(i*number_of_bytes);
				if(ADDR[i]==wrap_boundary+(number_of_bytes*burst_length))  //UPPER BOUNDARY
				begin
					ADDR[i]=wrap_boundary;
					k++;
				end
			end

			else
				ADDR[i]=start_addr+(i*number_of_bytes)-(number_of_bytes*burst_length);
		end
	end
endfunction*/
function void addr_cal( input int       ADDRS, bit [2:0] SIZE, bit [7:0] LEN, bit [1:0] BURST);
 
  int beat_bytes;
  int burst_len;
  int wrap_size;
  int wrap_boundary;
  int aligned_addr;
 
  start_addr      = ADDRS;
  beat_bytes      = 1 << SIZE;
  burst_len       = LEN + 1;
  wrap_size       = beat_bytes * burst_len;
  aligned_addr    = (ADDRS / beat_bytes) * beat_bytes;
  wrap_boundary   = (ADDRS / wrap_size) * wrap_size;
 
  ADDR = new[burst_len];
 
  for (int i = 0; i < burst_len; i++) begin
    case (BURST)
 
      2'b00: begin // FIXED
        ADDR[i] = ADDRS;
      end
 
      2'b01: begin // INCR
        ADDR[i] = aligned_addr + i * beat_bytes;
      end
 
      2'b10: begin // WRAP
        ADDR[i] = wrap_boundary +
                  ((ADDRS + i * beat_bytes - wrap_boundary) % wrap_size);
      end
 
      default: ADDR[i] = '0;
 
    endcase
  end
 
endfunction

function bit [31:0] read_word(bit [31:0] start_addr);
	return {memory[start_addr+3], memory[start_addr+2], memory[start_addr+1], memory[start_addr]};
endfunction

task automatic write_word(bit [31:0] start_addr, bit [63:0] data, bit [7:0] strb);
foreach (strb[i]) begin
        if (strb[i]==1) 
            memory[start_addr + i] = data[8*i +: 8];
     `uvm_info("MEM_WRITE",$sformatf("WRITE  addr_loc=%0d  byte_lane=%0d  data=0x%02h  (WSTRB=1)",start_addr + i, i,data[8*i +: 8]),UVM_LOW)
    end
endtask 

endclass
