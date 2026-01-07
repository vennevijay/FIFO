
class sequencer extends uvm_sequencer #(seq_item);
	`uvm_component_utils(sequencer)

//......CONSTRUCTOR..../
function new(string name="sequencer",uvm_component parent);
	super.new(name,parent);
endfunction

task run_phase(uvm_phase phase);
  `uvm_info("SQR", "Sequencer started run_phase", UVM_LOW)
  super.run_phase(phase);
endtask



//.....BUILD PHASE ....../
function void build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction

endclass



