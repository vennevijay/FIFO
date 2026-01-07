class agent extends uvm_agent;
	`uvm_component_utils(agent)

driver drv_h;
monitor mntr_h;
sequencer sqr_h;


//........CUNSTRUCTOR.......//
function  new(string name="agent",uvm_component parent);
	super.new(name,parent);
endfunction

//.......BUILD_PHASE....//
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
drv_h=driver::type_id::create("drv_h",this);
mntr_h=monitor::type_id::create("mntr_h",this);
sqr_h=sequencer::type_id::create("sqr_h",this);
endfunction

//.....CONNECT PHASE....//
function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
drv_h.seq_item_port.connect(sqr_h.seq_item_export);
endfunction

endclass


