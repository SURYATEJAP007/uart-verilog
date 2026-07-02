# UART Transceiver — Verilog Implementation

## Overview
A complete UART transceiver implemented in Verilog, 
supporting 9600 baud rate at 50MHz system clock with 
16x oversampling for reliable serial communication.

## Project Structure
uart-verilog/
  baud_gen.v        — Baud rate generator (326 cycle tick),
  uart_tx.v         — UART Transmitter FSM,
  uart_rx.v         — UART Receiver FSM,
  uart_top.v        — Top level structural module,
  uart_testbench.v  — Self-checking testbench,

## Specifications
| Parameter       | Value        |
|----------------|--------------|
| Baud Rate       | 9600         |
| System Clock    | 50 MHz       |
| Oversampling    | 16x          |
| Data bits       | 8            |
| Parity          | None         |
| Stop bits       | 1            |

## Architecture
baud_gen → baud_tick → uart_tx → serial_line → uart_rx
                  
## Simulation Results
- Tool: QuestaSim 10.7
- Test byte: 8'hA5
- Result: PASS — TX/RX loopback verified

## How to Run
1. Open QuestaSim
2. Compile all .v files in order:
   baud_gen → uart_tx → uart_rx → uart_top → uart_testbench
3. Simulate uart_testbench
4. run 2ms
5. Check transcript for PASS message

## Key Concepts
- FSM based design (Moore machine)
- 16x oversampling for clock mismatch tolerance
- Midpoint sampling for noise immunity
- Asynchronous reset
- Structural modeling at top level
