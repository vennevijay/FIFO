
class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)

  uvm_analysis_port #(seq_item) mon_ap;
  virtual fifo_interface vif;
  seq_item tr;

  
  // Constructor
  function new(string name="monitor", uvm_component parent);
    super.new(name,parent);
    mon_ap = new("mon_ap",this);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual fifo_interface.MONITOR)::get(this,"","vif",vif))
      `uvm_fatal(get_type_name(),"virtual interface not set for monitor")
  endfunction

  // Run phase
  virtual task run_phase(uvm_phase phase);
	tr = seq_item::type_id::create("tr",this);

    forever begin
     	@(posedge vif.monitor_cb);
	//while(vif.monitor_cb.reset!==1)
		if(!vif.reset)
	//@(posedge vif.monitor_cb);
	vif.cg_h.sample();
      // Handle write transactions immediately
      if (vif.monitor_cb.wn==1) begin
	 
        tr.data_in = vif.monitor_cb.data_in;
        tr.wn      = 1;
        tr.rn      = 0;
        tr.full    = vif.monitor_cb.full;
      //  tr.empty   = vif.monitor_cb.empty;
       // tr.data_out= 'hx;  // not valid for write
	`uvm_info("MON", $sformatf("Sampled WRITE: data_in=%0d wn=%0d rn=%0d", tr.data_in, tr.wn, tr.rn, tr.full, tr.empty, tr.data_out), UVM_LOW)
        tr.print();
        mon_ap.write(tr);
      end

     else if (vif.monitor_cb.rn==1) begin
	@(posedge vif.monitor_cb);
	
	tr = seq_item::type_id::create("tr",this);
	tr.data_out = vif.monitor_cb.data_out;
//	tr.data_in = 'hx;
	tr.wn 	    =0;
        tr.rn      = 1;
     //   tr.full    = vif.monitor_cb.full;
        tr.empty   = vif.monitor_cb.empty;
	`uvm_info("MON", $sformatf("Sampled WRITE: data_in=%0d wn=%0d rn=%0d full=%0d empty=%0d data_out=%0d",tr.data_in, tr.wn, tr.rn, tr.full, tr.empty, tr.data_out), UVM_LOW)
        tr.print();
        mon_ap.write(tr);
      end
    end
  endtask
endclass


