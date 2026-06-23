class axi_m_agt_top extends uvm_env;
  `uvm_component_utils(axi_m_agt_top)

   axi_m_aw_agent m_aw_agth;
   axi_m_w_agent m_w_agth;
   axi_m_b_agent m_b_agth;
   axi_m_ar_agent m_ar_agth;
   axi_m_r_agent m_r_agth;

   function new (string name ="", uvm_component parent);
	  super.new(name,parent);
   endfunction


   virtual function void build_phase(uvm_phase phase);
       super.build_phase(phase);
       m_aw_agth = axi_m_aw_agent::type_id::create("m_aw_agth",this);
       m_w_agth = axi_m_w_agent::type_id::create("m_w_agth",this);
       m_b_agth = axi_m_b_agent::type_id::create("m_b_agth",this);
       m_ar_agth = axi_m_ar_agent::type_id::create("m_ar_agth",this);
       m_r_agth = axi_m_r_agent::type_id::create("m_r_agth",this);

   endfunction
endclass
