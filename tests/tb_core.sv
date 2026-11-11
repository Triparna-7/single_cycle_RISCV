`timescale 1ns/1ps
module tb_core;
 logic clk=0,reset=0,stall=0;
 logic [31:0] instruction=32'h00000013,mem_out=0;
 wire [31:0] rs2_data,alu_out,address;
 wire mem_write,mem_read;
 wire [2:0] fn3;
 wire [6:0] opcode;
 single_cycle_riscv dut(.*);
 always #5 clk=~clk;
 task automatic step(input logic [31:0] instr);
 begin @(negedge clk);instruction=instr;@(posedge clk);#1;end
 endtask
 initial begin
 #1;reset=1;#1;
 if(address!==32'h80000000) $fatal(1,"PC reset failed");
 @(negedge clk);reset=0;
 step(32'h00500093); // addi x1,x0,5
 if(address!==32'h80000004) $fatal(1,"PC advance failed");
 step(32'h00308113); // addi x2,x1,3
 step(32'h002081b3); // add x3,x1,x2
 @(negedge clk);instruction=32'h00018233; // add x4,x3,x0
 #1;if(alu_out!==32'd13) $fatal(1,"ALU add failed: %d",alu_out);
 stall=1;@(posedge clk);#1;
 if(address!==32'h8000000c) $fatal(1,"stall PC failed");
 @(negedge clk);stall=0;
 $display("PASS: basic reset, arithmetic and PC stall checks");$finish;
 end
endmodule
