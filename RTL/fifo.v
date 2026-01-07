module fifo(
  input clk,reset,wn,rn,
  input [7:0]data_in,
  output reg [7:0]data_out,
  output full,empty);
  
  reg[4:0]wptr,rptr;
  reg[15:0]mem[7:0];

  integer i;
  
  always@(posedge clk)
    begin
      if(reset)
        begin
          for(i=0;i<8;i=i+1)
            mem[i]<=0;
          	data_out<=0;
          	wptr<=0;
          rptr<=0;
        end
      else
        begin
          if(wn && !full)
          begin
            mem[wptr]<=data_in;
            wptr<=wptr+1;
          end
      
        if(rn && !empty)
          begin
            data_out<=mem[rptr];
            rptr<=rptr+1;
          end
        end
    end

   assign full=((wptr+1'b1)== rptr);
  assign empty=(wptr==rptr);
  endmodule

