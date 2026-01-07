/*
class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  // Analysis export to receive transactions from monitor
  uvm_analysis_imp #(seq_item, scoreboard) sb_export;

  // Expected data queue (stores only written data)
  bit [7:0] exp_q[$];

  // Constructor
  function new(string name = "scoreboard", uvm_component parent = null);
    super.new(name, parent);
    sb_export = new("sb_export", this);
  endfunction
  function void write(seq_item tr);
    // Store write data only if actually accepted by DUT
    if (tr.wn) begin
      exp_q.push_back(tr.data_in);
      `uvm_info("SB", $sformatf("Pushed data_in=%0d", tr.data_in), UVM_LOW)
    end

    // On read, compare against expected queue only if FIFO not empty
    if (tr.rn) begin
      if (exp_q.size() == 0) begin
        `uvm_error("SB", "Read occurred but no expected data available!")
      end
      else begin
        bit [7:0] exp = exp_q.pop_front();
        if (exp != tr.data_out) begin
          `uvm_error("SB", $sformatf("Mismatch: exp=%0d got=%0d", exp, tr.data_out))
        end
        else begin
          `uvm_info("SB", $sformatf("Match: exp=%0d got=%0d", exp, tr.data_out), UVM_LOW)
        end
      end
    end
  endfunction

endclass
*/

/*
class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  // Analysis export to receive transactions
  uvm_analysis_imp #(seq_item, scoreboard) sb_export;

  // Queue to hold expected data
  bit [7:0] exp_q[$];

  // Constructor
  function new(string name = "scoreboard", uvm_component parent = null);
    super.new(name, parent);
    sb_export = new("sb_export", this);
  endfunction

  // Main comparison logic
  function void write(seq_item tr);
    // Handle writes
    if (tr.wn) begin
      exp_q.push_back(tr.data_in);
      `uvm_info("SB", $sformatf("Pushed data_in=%0d", tr.data_in), UVM_LOW)
    end

    // Handle reads
    if (tr.rn) begin
      if (exp_q.size() == 0) begin
        `uvm_warning("SB", "Read occurred but no expected data available! This often indicates monitor timing or reset sample issue.")
      end
      else begin
        bit [7:0] exp = exp_q.pop_front();
        if (exp != tr.data_out) begin
          `uvm_error("SB", $sformatf("Mismatch: exp=%0d got=%0d", exp, tr.data_out))
        end
        else begin
          `uvm_info("SB", $sformatf("Match: exp=%0d got=%0d", exp, tr.data_out), UVM_LOW)
        end
      end
    end
  endfunction

endclass
*/

class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  uvm_analysis_imp #(seq_item, scoreboard) sb_export;
  bit [7:0] exp_q[$];

  function new(string name = "scoreboard", uvm_component parent = null);
    super.new(name, parent);
    sb_export = new("sb_export", this);
  endfunction

  // This write is called by the analysis imp when monitor publishes a tr
  function void write(seq_item tr);
    // writes: push expected value
    if (tr.wn) begin
      exp_q.push_back(tr.data_in);
      `uvm_info("SB", $sformatf("Pushed data_in=%0d", tr.data_in), UVM_LOW)
      return;
    end

    // reads: compare against queue front (if available)
    if (tr.rn) begin
      if (exp_q.size() == 0) begin
        `uvm_error("SB", $sformatf("Read observed but expected queue empty! got data_out=%0d", tr.data_out));
      end else begin
        bit [7:0] exp = exp_q.pop_front();
        if (exp !== tr.data_out) begin
          `uvm_error("SB", $sformatf("Mismatch: exp=%0d got=%0d", exp, tr.data_out));
        end else begin
          `uvm_info("SB", $sformatf("Match: exp=%0d got=%0d", exp, tr.data_out), UVM_LOW);
        end
      end
    end
  endfunction
endclass

