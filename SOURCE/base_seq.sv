

class base_seq extends uvm_sequence#(seq_item);
  `uvm_object_utils(base_seq)
  seq_item req;

  function new(string name="base_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), $sformatf("generate 5 write req"), UVM_LOW)
    repeat (8) begin
      req = seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with { wn == 1'b1; rn == 1'b0; });
      finish_item(req);
    end

    `uvm_info(get_type_name(), $sformatf("generate 5 read rq"), UVM_LOW)
    repeat (8) begin
      req = seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with { rn == 1'b1; wn == 1'b0; });
      finish_item(req);
    end
  endtask
endclass



