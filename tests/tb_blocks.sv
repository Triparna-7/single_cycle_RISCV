`timescale 1ns/1ps
module tb_blocks;
 logic [31:0] instruction;
 wire [4:0] rs1,rs2,rd;
 wire [6:0] opcode,imm11_5;
 wire [2:0] fn3;
 wire [11:0] imm;
 wire [19:0] imm_uj;
 wire fn7_5;
 decoder d(.*);
 logic [4:0] alu_control;
 logic [31:0] a,b;
 wire [31:0] y;
 wire z;
 alu u(.alu_control(alu_control),.rs1_data(a),.rs2_data(b),.alu_out(y),.zero(z));
 initial begin
 instruction=32'h00500093;alu_control=0;a=32'd5;b=32'd8;#1;
 if(rd!==1 || rs1!==0 || imm!==12'd5 || y!==13) $fatal(1,"decode/add failed");
 alu_control=5'd12;a=32'hffffffff;b=0;#1;
 if(z!==1 || y!==0) $fatal(1,"signed branch failed");
 alu_control=5'd7;a=32'hfffffff8;b=1;#1;
 if(y!==32'hfffffffc) $fatal(1,"arithmetic shift failed");
 $display("PASS: decoder and ALU checks");$finish;
 end
endmodule
