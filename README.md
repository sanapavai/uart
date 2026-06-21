# UART Communication System Using VHDL

## Overview

This project implements a complete UART (Universal Asynchronous Receiver Transmitter) communication system in VHDL. The design includes both UART Transmitter and UART Receiver modules along with supporting components such as baud rate generation, finite state machines (FSMs), and shift registers.

The design was developed and simulated using Xilinx Vivado.

---

## Features

* UART Transmitter (TX)
* UART Receiver (RX)
* Baud Rate Generator
* Transmit Shift Register
* Receive Shift Register
* FSM-Based Control Logic
* 8-bit Data Communication
* Simulation Testbench
* Synthesizable VHDL Code

---

## Project Structure

```text
UART_Project/
│
├── uart_tx_fsm.vhd
├── uart_rx_fsm.vhd
├── uart_tx_shift_register.vhd
├── uart_rx_shift_register.vhd
├── baud_rate_generator.vhd
├── uart_top.vhd
├── tb_uart_top.vhd
│
└── README.md
```

---

## UART Frame Format

```text
| Start Bit | D0 | D1 | D2 | D3 | D4 | D5 | D6 | D7 | Stop Bit |
|     0     |            8 Data Bits           |     1     |
```

---

## Design Description

### Baud Rate Generator

Generates baud-rate timing pulses from the system clock.

### UART Transmitter

* Loads 8-bit parallel data.
* Sends Start Bit.
* Transmits data serially (LSB first).
* Sends Stop Bit.
* Generates transmission complete signal.

### UART Receiver

* Detects Start Bit.
* Samples incoming serial data.
* Reconstructs 8-bit data.
* Verifies Stop Bit.
* Generates receive complete signal.

### Shift Registers

* TX Shift Register: Parallel-to-Serial conversion.
* RX Shift Register: Serial-to-Parallel conversion.

---

## Simulation

The design was verified using Vivado Simulator.

### Test Procedure

1. Apply Reset.
2. Load 8-bit data.
3. Start UART Transmission.
4. Observe TX serial output.
5. Verify received data at RX output.

### Example

```text
Input Data  : 0xA5
Transmitted : 10100101
Received    : 10100101
Status      : PASS
```

---

## Tools Used

* VHDL
* Xilinx Vivado
* Vivado Simulator

---

## Applications

* FPGA-Based Communication Systems
* Embedded Systems
* Serial Data Transfer
* Sensor Interfaces
* Debug and Monitoring Systems

---

## Future Improvements

* Configurable Baud Rate
* Parity Bit Support
* FIFO-Based UART
* Interrupt Support
* AXI UART Integration

---

## Author

Developed as part of FPGA and Digital Communication learning using VHDL and Xilinx Vivado.
