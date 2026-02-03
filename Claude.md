# Project Context: FPGA Porting to PCIe Squirrel (XC7A35T)

## Target Hardware Specifications
- **Device:** Xilinx Artix-7 xc7a35tfgg484-2

## Build & Environment Configuration
To run builds and verify the port, the following environment must be initialized:
- **Python Venv:** `source ~/openpcie/.venv/bin/activate`
- **Vivado Tools:** `source /tools/Xilinx_2024/Vivado/2024.2/settings64.sh`
- **Build Command:** Use the existing command found in the project README.

## Reference Sources (Included in /references/)
- **PCILeech Squirrel:** (Standard for DMA/PCIe on this board)
- **Enjoy-Digital Screamer:** (Base gateware for this hardware family)
- xc7a35tfgg484pkg.txt:** PIN Information