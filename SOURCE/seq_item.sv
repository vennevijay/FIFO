/*
class seq_item extends uvm_sequence_item;

rand bit wn;
rand bit rn;
rand logic [7:0]data_in;
bit empty;
bit full;
bit reset;
logic[7:0]data_out;

//...........CONSTRUCTOR.........//
function new(string name="seq_item");
	super.new(name);
`uvm_info("SEQUENCE_ITEM",$sformatf("created seq_item %s",name),UVM_LOW)
endfunction

`uvm_object_utils_begin(seq_item)
`uvm_field_int(data_in,UVM_ALL_ON)
`uvm_field_int(wn,UVM_ALL_ON)
`uvm_field_int(rn,UVM_ALL_ON)
`uvm_field_int(full,UVM_ALL_ON)
`uvm_field_int(empty,UVM_ALL_ON)
`uvm_field_int(data_out,UVM_ALL_ON)
`uvm_object_utils_end
function string convert2string();
    return $sformatf("data_in=%0d wn=%0b rn=%0b full=%0d empty=%0d data_out=%0d", data_in, wn,rn,full,empty,data_out);
  endfunction


endclass
*/

class seq_item extends uvm_sequence_item;
 // `uvm_object_utils(seq_item)

  rand bit wn;
  rand bit rn;
  rand logic [7:0] data_in;

  bit empty;
  bit full;
  logic [7:0] data_out;

  function new(string name="seq_item");
    super.new(name);
    `uvm_info("SEQUENCE_ITEM", $sformatf("created seq_item %s", name), UVM_LOW)
  endfunction
	`uvm_object_utils_begin(seq_item)
  `uvm_field_int(data_in, UVM_ALL_ON)
  `uvm_field_int(wn, UVM_ALL_ON)
  `uvm_field_int(rn, UVM_ALL_ON)
  `uvm_field_int(full, UVM_ALL_ON)
  `uvm_field_int(empty, UVM_ALL_ON)
  `uvm_field_int(data_out, UVM_ALL_ON)
	`uvm_object_utils_end

  function string convert2string();
    return $sformatf("data_in=%0d wn=%0b rn=%0b full=%0d empty=%0d data_out=%0d",
                     data_in, wn, rn, full, empty, data_out);
  endfunction
endclass

