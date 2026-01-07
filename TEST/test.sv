class test extends uvm_test;
  `uvm_component_utils(test)

  env e_h;

  // Constructor
  function new(string name = "test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e_h = env::type_id::create("e_h", this);
  endfunction


task run_phase(uvm_phase phase);
base_seq seq;

  `uvm_info("TEST", "Starting test run_phase", UVM_LOW)
	phase.raise_objection(this);
	 seq= base_seq::type_id::create("seq",this);
	seq.start(e_h.agt_h.sqr_h);
	wait(e_h.sb_h.exp_q.size()==0);
//	#1000; 
	phase.drop_objection(this);
endtask

//........................ End of elaboration (print topology).................//
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction


/*
task do_write(int n);
    seq_item tr;
    repeat(n) begin
      tr = seq_item::type_id::create("tr");
      start_item(tr);
      assert(tr.randomize() with {wn==1; rn==0;});
      finish_item(tr);
    end
  endtask


task do_read(int n);
    seq_item tr;
    repeat(n) begin
      tr = seq_item::type_id::create("tr");
      start_item(tr);
      assert(tr.randomize() with { rn==1; wn==0; });
      finish_item(tr);
    end
  endtask

 task do_random(int n);
    seq_item tr;
    repeat(n) begin
      tr = seq_item::type_id::create("tr");
      start_item(tr);
      assert(tr.randomize());
      finish_item(tr);
    end
  endtask

*/

endclass




