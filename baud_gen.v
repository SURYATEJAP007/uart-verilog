module baud_gen(
input clk,rst,
output baud_tick);
reg [8:0] counter;
always @(posedge clk or posedge rst) begin
if (rst)
counter<=0;
else if (counter == 325) 
counter<=0;
else 
counter<=counter+1;
end
assign baud_tick= (counter == 325);
endmodule
