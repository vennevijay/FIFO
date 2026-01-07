class env extends uvm_env;
	`uvm_component_utils(env)
agent agt_h;
scoreboard sb_h;

//........CONSTRUCTOR.....//
function new(string name="env",uvm_component parent);
	super.new(name,parent);
 `uvm_info("ENV", "Environment build_phase done", UVM_LOW)
endfunction

//.......BUILD PHASE......//
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
agt_h=agent::type_id::create("agt_h",this);
sb_h=scoreboard::type_id::create("sb_h",this);
endfunction

//...........CONNECT PHASE.....//
function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
agt_h.mntr_h.mon_ap.connect(sb_h.sb_export);
endfunction


endclass



