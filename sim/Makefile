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
# 1. Grab all RTL files (including both .sv and .v files for the SRAMs)
RTL_SRCS = $(wildcard $(RTL_DIR)/*.sv $(RTL_DIR)/*.v)

# 2. Grab your UVM packages (Must be compiled before the testbench)
PKG_SRCS = $(wildcard $(UVM_TB_DIR)/package/*.sv)

# 3. Your Top-Level Testbench
TB_SRCS  = $(TB_DIR)/coralNPU_tb_top.sv

# 4. Combine them in the CORRECT ORDER (RTL -> Packages -> TB Top)
ALL_SRCS = $(PKG_SRCS) $(RTL_SRCS) $(TB_SRCS)

# ==============================================================================
# VCS Flags
# ==============================================================================
# Added UVM 1.2 support, corrected CoralNPU macros, and added all +incdir+ paths
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
            +define+TB_SUPPORT

SIM_EXE   = $(OUT_DIR)/simv
WAVE_FILE = $(OUT_DIR)/inter.fsdb

# ==============================================================================
# Runtime Argument Configuration
# ==============================================================================
# Default test name used if TESTNAME is not specified on the command line
TESTNAME ?= coralnpu_test_base

# ==============================================================================
# Targets and Rules
# ==============================================================================
.PHONY: all compile run wave signals_load clean

all: compile run

compile: $(SIM_EXE)

$(SIM_EXE): $(ALL_SRCS)
	@mkdir -p $(OUT_DIR)
	vcs $(VCS_FLAGS) -Mdir=$(OUT_DIR)/csrc -o $(SIM_EXE) $(ALL_SRCS)

# Appended +UVM_TESTNAME argument to forward the variable to the simulator
run: $(SIM_EXE)
	cd $(OUT_DIR) && ./simv +UVM_TESTNAME=$(TESTNAME)

wave:
	verdi -base -ssf $(WAVE_FILE) &
	
signals_load:
	verdi -base -ssf $(WAVE_FILE) -sswr $(LOAD_DIR)/signal.rc &

clean:
	rm -rf $(OUT_DIR) ucli.key vc_hdrs.h verdi_config_1.rc
