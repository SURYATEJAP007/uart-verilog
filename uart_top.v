module uart_top(
input clk, rst, tx_start,
input [7:0] data_in,
output [7:0]data_out, 
output tx_done, rx_done);
wire baud_tick;
wire serial_line;
baud_gen u_baud(
    .clk      (clk),
    .rst      (rst),
    .baud_tick(baud_tick)
);
uart_tx u_tx(
    .clk      (clk),
    .rst      (rst),
    .tx_start (tx_start),
    .baud_tick(baud_tick),
    .data_in  (data_in),
    .tx       (serial_line),  
    .tx_done  (tx_done)
);
uart_rx u_rx(
    .clk      (clk),
    .rst      (rst),
    .rx       (serial_line),   
    .baud_tick(baud_tick),
    .data_out (data_out),
    .rx_done  (rx_done)
);
endmodule
