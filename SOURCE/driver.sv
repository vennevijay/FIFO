

class driver extends uvm_driver #(seq_item);
  `uvm_component_utils(driver)
  virtual fifo_interface.DRIVER vif;

  // local item
  seq_item req;

  function new(string name="driver", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual fifo_interface.DRIVER)::get(this,"","vif",vif))
      `uvm_fatal(get_type_name(), "VIRTUAL INTERFACE NOT SET ON TOP LEVEL");
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      `uvm_info("DRV", $sformatf("Driving item: %s", req.convert2string()), UVM_MEDIUM)

      if (req.wn == 1) begin
        drive_write(req.data_in);
      end else if (req.rn == 1) begin
        drive_read();
      end
      seq_item_port.item_done();
    end
  endtask

  virtual task drive_write(bit [7:0] din);
	wait(!vif.driver_cb.full);
    // align to clock; drive via clocking block outputs (these assignments are sync'd at clk)
    @(posedge vif.driver_cb);
    vif.driver_cb.data_in <= din;
    vif.driver_cb.wn      <= 1;
    @(posedge vif.driver_cb); // hold for 1 clk cycle
    vif.driver_cb.wn <= 0;
    vif.driver_cb.data_in <= 'hz; // tri-state / release if desired
  endtask

  virtual task drive_read();
	wait(!vif.driver_cb.empty);
    @(posedge vif.driver_cb);
    vif.driver_cb.rn <= 1;
    @(posedge vif.driver_cb); // keep rn asserted for one cycle
    vif.driver_cb.rn <= 0;
  endtask

endclass

