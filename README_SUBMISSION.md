# Single-Cycle RISC-V RV32I — submission package

This folder contains 11 SystemVerilog RTL modules following the interface contracts of the course starter repository at https://github.com/Triparna-7/RISC-V-Single-Cycle_2 and the assignment handout. Instruction and data memories are external to the CPU.

## IMPORTANT — validation status
The RTL has been prepared from the published specifications, but **has NOT been run through the course RISC-n-Roll CI**, and the local environment does not have Icarus Verilog, Verilator or Yosys installed. **Do not claim that the project passed simulation, synthesis or course CI.** The tests are provided but have not been executed here.

## How to submit
1. Keep your existing repository and back it up first. Extract the ZIP and upload the **contents** into the root of `RISC-V-Single-Cycle_2`, preserving folder paths. GitHub web UI does not reliably upload nested folders by dragging a directory; Git CLI or GitHub Desktop is recommended.
2. Ensure `rnr-stage.yaml` is at the repository root. It is configured for `stage: integration` and lists all 11 RTL files.
3. Install the course CI app: https://github.com/apps/risc-n-roll-ci/installations/new ; select your repository.
4. Commit and push. Wait about one hour for `RISC-n-Roll-CI` on the latest commit.
5. Inspect every block result. If any block fails, fix it before submitting the repository URL.

## Suggested local test commands (if iverilog is installed)
```bash
iverilog -g2012 -s tb_blocks -o blocks.vvp $(find . -name '*.sv')
vvp blocks.vvp
iverilog -g2012 -s tb_core -o core.vvp $(find . -name '*.sv')
vvp core.vvp
```
These are smoke tests, not exhaustive RV32I validation. Run one testbench top at a time.

## Important architectural details
- Asynchronous active-high PC reset to `0x80000000`; `stall` holds PC.
- Register-file reset clears all 32 registers; x0 is always zero; stall gates register writes.
- Branch comparison returns its condition on the ALU `zero` output.
- JALR target clears bit 0.
- LUI/AUIPC and JAL/JALR use the specified WB selection.
- The integration interface has no internal instruction or data memory.

## Source of truth
See the existing 11 module README.md specifications in the original GitHub repository. The project deliberately follows those module interfaces rather than substituting a generic RISC-V architecture.
