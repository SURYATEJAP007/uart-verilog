module uart_testbench;
    reg clk, rst, tx_start;
    reg [7:0] data_in;
    wire [7:0] data_out;
    wire tx_done, rx_done;

  uaart_top uut(
        .clk      (clk),
        .rst      (rst),
        .tx_start (tx_start),
        .data_in  (data_in),
        .data_out (data_out),
        .tx_done  (tx_done),
        .rx_done  (rx_done)
    );
 initial clk = 0;
 always #10 clk = ~clk;
 initial begin
        rst      = 1;
        tx_start = 0;
        data_in  = 8'h00;
        #100;                    
        rst = 0;
        #100;                    
        data_in  = 8'hA5;
        tx_start = 1;
        #20;                     
        tx_start = 0;
        @(posedge rx_done);
        if (data_out == 8'hA5)
            $display("PASS ? received: %h", data_out);
        else
            $display("FAIL ? expected A5, got: %h", data_out);

        #100;
        $finish;
    end
    initial begin
        $dumpfile("uart_testbench.vcd");
        $dumpvars(0,uart_testbench);
    end

endmodule
