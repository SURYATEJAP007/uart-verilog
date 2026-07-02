module uart_tx(
    input clk, rst, tx_start, baud_tick,
    input [7:0] data_in,
    output reg tx, tx_done
);
    parameter IDLE  = 2'b00;
    parameter START = 2'b01;
    parameter DATA  = 2'b10;
    parameter STOP  = 2'b11;

    // internal registers
    reg [1:0] state;
    reg [3:0] tick_cnt;
    reg [2:0] bit_cnt;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state    <= IDLE;
            tx       <= 1'b1;   // what is tx on reset?
            tx_done  <= 1'b0;   // what is tx_done on reset?
            tick_cnt <= 4'b0;   // what is tick_cnt on reset?
            bit_cnt  <= 3'b0;  
        end
        else begin
            case (state)

                IDLE: begin
                    tx      <= 1;   
                    tx_done <= 0;   
                    if (tx_start)          
                        state <= START;
                end

                START: begin
                    tx <= 0;        
                    if (baud_tick) begin
                        if (tick_cnt == 15) begin  
                            tick_cnt <= 0;         
                            state    <= DATA;
                        end
                        else
                            tick_cnt <= tick_cnt+1;        
                    end
                end

                DATA: begin
                    tx <= data_in[bit_cnt[2:0]];      
                    if (baud_tick) begin
                        if (tick_cnt == 15) begin  
                            tick_cnt <= 0;         
                            if (bit_cnt == 7) begin 
                                bit_cnt <= 0;       
                                state   <= STOP;
                            end
                            else
                                bit_cnt <= bit_cnt+1;      
                        end
                        else
                            tick_cnt <= tick_cnt+1;        
                    end
                end

                STOP: begin
                    tx <= 1'b1;        
                    if (baud_tick) begin
                        if (tick_cnt == 15) begin  
                            tick_cnt <= 0;        
                            tx_done  <= 1'b1;         
                            state    <= IDLE;
                        end
                        else
                            tick_cnt <= tick_cnt+1;         
                    end
                end

            endcase
        end
    end

endmodule


