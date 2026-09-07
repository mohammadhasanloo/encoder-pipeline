# Simulation with Icarus Verilog. The original flow used ModelSim; this needs
# only open-source tools.

TOP       := TB
SOURCES   := $(shell find trunk/src/hdl -name '*.v') trunk/sim/tb/TB.v
BUILD     := build
SIMULATOR := $(BUILD)/$(TOP).vvp

.PHONY: all sim clean

all: sim

$(SIMULATOR): $(SOURCES)
	@mkdir -p $(BUILD)
	iverilog -g2005 -o $@ -s $(TOP) $(SOURCES)

# Each stage reads the file the one before it wrote, so the run leaves the whole
# chain of intermediates in trunk/sim/file/ for inspection.
sim: $(SIMULATOR)
	cd trunk/sim && vvp ../../$(SIMULATOR)

clean:
	rm -rf $(BUILD) trunk/sim/encoder.vcd \
		trunk/sim/file/colPInput.txt trunk/sim/file/rotateInput.txt \
		trunk/sim/file/permuteInput.txt trunk/sim/file/addRcInput.txt \
		trunk/sim/file/revaluateInput.txt
