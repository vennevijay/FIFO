/*
`timescale 1ns/1ps


interface fifo_interface(input logic clk,reset);
//logic reset;
logic wn;
logic rn;
logic [7:0]data_in;
logic [7:0]data_out;
logic full;
logic empty;

//..........................DRIVER CLOCKING BLOCK........//
clocking driver_cb @(posedge clk);
	default input #1 output #1;
output wn;
output rn;
output data_in;
output reset;
input full;
input empty;
input data_out;
endclocking

//........................MONITOR CLOKING BLOCK.......//
clocking monitor_cb @(posedge clk);
	default input #1 output #1;
input wn;
input rn;
input data_in;
input data_out;
input full;
input empty;
input reset;
endclocking

modport DRIVER(clocking driver_cb,input clk,reset);
modport MONITOR(clocking monitor_cb,input clk,reset);
endinterface
*/
`timescale 1ns/1ps

interface fifo_interface(input logic clk, reset);

  // Signals
  logic wn;
  logic rn;
  logic [7:0] data_in;
  logic [7:0] data_out;
  logic full;
  logic empty;

  // ------------------ DRIVER CLOCKING BLOCK ------------------ //
  clocking driver_cb @(posedge clk);
    default input #1 output #1;
    output wn;
    output rn;
    output data_in;
    output reset;
    input full;
    input empty;
    input data_out;
  endclocking

  // ------------------ MONITOR CLOCKING BLOCK ------------------ //
  clocking monitor_cb @(posedge clk);
    default input #1 output #1;
    input wn;
    input rn;
    input data_in;
    input data_out;
    input full;
    input empty;
    input reset;
  endclocking

  // ------------------ MODPORTS ------------------ //
  modport DRIVER(
    clocking driver_cb,
    input clk, reset
  );

  modport MONITOR(
    clocking monitor_cb,
    input clk, reset,
    input wn, rn, full, empty, data_in, data_out
  );

  // ------------------ FUNCTIONAL COVERAGE ------------------ //
  covergroup fifo_cg @(posedge monitor_cb);
    option.per_instance = 1;

    // Data written into the FIFO
    DATA_IN : coverpoint data_in iff(wn) {
      bins data_range[] = {[0:255]};
    }

    // FIFO status at the moment of write
    STATE_ON_WRITE : coverpoint {full, empty} iff(wn) {
      bins write_when_not_full = {2'b00, 2'b01};
      bins write_when_full     = {2'b10};
    }

    // FIFO status at the moment of read
    STATE_ON_READ : coverpoint {full, empty} iff(rn) {
      bins read_when_not_empty = {2'b00, 2'b01};
      bins read_when_empty     = {2'b10};
    }

    // Cross coverage for read/write combinations
    CROSS_READ_WRITE : cross STATE_ON_WRITE, STATE_ON_READ;
  endgroup

  // Create an instance of the covergroup
  fifo_cg cg_h = new();

endinterface

