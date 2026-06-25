# ==============================================================================
# Directories
# ==============================================================================
RTL_DIR    = ../coralnpu_RTL
TB_DIR     = ../tb_tops
UVM_TB_DIR = ../uvm_tb
OUT_DIR    = build
LOAD_DIR   = ./verdiLog

# ==============================================================================
# Source Files
# ==============================================================================
# 1. Grab all RTL files
RTL_SRCS = $(wildcard $(RTL_DIR)/*.sv $(RTL_DIR)/*.v)
# 2. Grab your UVM packages
PKG_SRCS = $(wildcard $(UVM_TB_DIR)/package/*.sv)
# 3. Your Top-Level Testbench
TB_SRCS  = $(TB_DIR)/coralNPU_tb_top.sv
# 4. Combine them in the CORRECT ORDER (RTL -> Packages -> TB Top -> DPI C++)
DPI_SRCS = ../dpi/sram_backdoor.cc
ALL_SRCS = $(PKG_SRCS) $(RTL_SRCS) $(TB_SRCS) $(DPI_SRCS)

# ==============================================================================
# VCS Flags
# ==============================================================================
VCS_FLAGS = -full64 -sverilog -kdb -debug_access+all \
            -ntb_opts uvm-1.2 \
            +incdir+$(RTL_DIR) \
            +incdir+$(TB_DIR) \
            +incdir+$(UVM_TB_DIR)/agents/axi_master \
            +incdir+$(UVM_TB_DIR)/agents/axi_master/axi_m_aw_agt \
            +incdir+$(UVM_TB_DIR)/agents/axi_master/axi_m_w_agt \
            +incdir+$(UVM_TB_DIR)/agents/axi_master/axi_m_b_agt \
            +incdir+$(UVM_TB_DIR)/agents/axi_master/axi_m_ar_agt \
            +incdir+$(UVM_TB_DIR)/agents/axi_master/axi_m_r_agt \
            +incdir+$(UVM_TB_DIR)/agents/axi4 \
            +incdir+$(UVM_TB_DIR)/agents/axi4/slave_aw_agent \
            +incdir+$(UVM_TB_DIR)/agents/axi4/slave_w_agent \
            +incdir+$(UVM_TB_DIR)/agents/axi4/slave_b_agent \
            +incdir+$(UVM_TB_DIR)/agents/axi4/slave_ar_agent \
            +incdir+$(UVM_TB_DIR)/agents/axi4/slave_r_agent \
            +incdir+$(UVM_TB_DIR)/env \
            +incdir+$(UVM_TB_DIR)/package \
            +incdir+$(UVM_TB_DIR)/tests \
            +define+VLEN_128 \
            +define+ZVE32F_ON \
            +define+TB_SUPPORT \
            +define+DPI_MEMORY

SIM_EXE   = $(OUT_DIR)/simv
WAVE_FILE = $(OUT_DIR)/inter.fsdb

# ==============================================================================
# Firmware Compilation (Automated via Bazel Mirroring)
# ==============================================================================
TESTNAME ?= coralnpu_test_base
SW_TEST ?= hello_world_add_floats

# Where your custom tests live
C_TESTS_DIR = ../example_c

# Exact path to the main Google repo
BAZEL_WORKSPACE = ../../coralnpu/coralnpu

# The temporary "mirror" folder we will create inside the Google repo
BAZEL_MIRROR_DIR = $(BAZEL_WORKSPACE)/examples/my_custom_tests

ELF_FILE = elf_out/$(SW_TEST).elf

sw:
	@echo "--- Compiling $(SW_TEST) Firmware using Bazel ---"
	@mkdir -p elf_out
	@mkdir -p $(BAZEL_MIRROR_DIR)
	@cp $(C_TESTS_DIR)/$(SW_TEST).cc $(BAZEL_MIRROR_DIR)/
	@echo 'load("//rules:coralnpu_v2.bzl", "coralnpu_v2_binary")' > $(BAZEL_MIRROR_DIR)/BUILD.bazel
	@echo 'coralnpu_v2_binary(name = "$(SW_TEST)", srcs = ["$(SW_TEST).cc"])' >> $(BAZEL_MIRROR_DIR)/BUILD.bazel
	cd $(BAZEL_WORKSPACE) && bazel build //examples/my_custom_tests:$(SW_TEST)
	cp $(BAZEL_WORKSPACE)/bazel-bin/examples/my_custom_tests/$(SW_TEST).elf $(ELF_FILE)
	@echo "--- Firmware Compilation Complete ---"
# ==============================================================================
# Targets and Rules
# ==============================================================================
.PHONY: all compile run wave signals_load clean sw

all: sw compile run

compile: $(SIM_EXE)

$(SIM_EXE): $(ALL_SRCS)
	@mkdir -p $(OUT_DIR)
	vcs $(VCS_FLAGS) -Mdir=$(OUT_DIR)/csrc -o $(SIM_EXE) $(ALL_SRCS)

run: $(SIM_EXE)
	cd $(OUT_DIR) && ./simv +UVM_TESTNAME=$(TESTNAME) +ELF_PATH=../$(ELF_FILE)

wave:
	verdi -base -ssf $(WAVE_FILE) &
	
signals_load:
	verdi -base -ssf $(WAVE_FILE) -sswr $(LOAD_DIR)/signal.rc &

clean:
	rm -rf $(OUT_DIR) elf_out ucli.key vc_hdrs.h verdi_config_1.rc
