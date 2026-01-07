
`timescale 1ns/1ps
`include "uvm_macros.svh"
import uvm_pkg::*;
import test_pkg::*;

module top;
  bit clk;
  bit reset;


//.............. INTERAFACE.........//
	fifo_interface vif(clk,reset);

	fifo DUT(
		.data_out(vif.data_out),
		.full(vif.full),
		.empty(vif.empty),
		.clk(vif.clk),
		.reset(vif.reset),
		.wn(vif.wn),
		.rn(vif.rn),
		.data_in(vif.data_in));

 
//............CLOCK GENERATOR.......// 
  initial 
	begin
	clk=1'b0;
  	  forever #5 clk = ~clk;
	end

//...........RESET GENERATOR........//
   initial
	begin
	reset=1'b1;
	#20 reset=1'b0;
	//#1000 $stop;
	end

//.......PASS INTERFACE TO TB......//

  initial
	 begin
		uvm_config_db#(virtual fifo_interface.DRIVER)::set(null,"*","vif",vif);
		uvm_config_db#(virtual fifo_interface.MONITOR)::set(null,"*","vif",vif);
         	run_test();
		#1000; 
		$stop;
 	 end
endmodule

