verdiSetActWin -dock widgetDock_<Message>
simSetSimulator "-vcssv" -exec \
           "/home/bitsilica/SAT/ajay/new_coralNPU/sim/build/simv" -args \
           "+UVM_TESTNAME=coralnpu_test_base"
debImport "-dbdir" "/home/bitsilica/SAT/ajay/new_coralNPU/sim/build/simv.daidir"
debLoadSimResult /home/bitsilica/SAT/ajay/new_coralNPU/sim/build/inter.fsdb
wvCreateWindow
wvRestoreSignal -win $_nWave2 "./verdiLog/signal.rc" -overWriteAutoAlias on \
           -appendSignals on
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvExpandGroup -win $_nWave2 "AXI_slave_if"
verdiSetActWin -win $_nWave2
wvExpandGroup -win $_nWave2 "AXI_slave_if/G3-CB"
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 6913.726045 -snap {("G3-CB" 5)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvZoomIn -win $_nWave2
wvScrollDown -win $_nWave2 56
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 56
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvCollapseGroup -win $_nWave2 "AXI_slave_if/G3-CB"
wvExpandGroup -win $_nWave2 "AXI_slave_if/G3-W"
wvZoomOut -win $_nWave2
wvZoomIn -win $_nWave2
wvSetCursor -win $_nWave2 56.070746 -snap {("G3-W" 4)}
wvSetCursor -win $_nWave2 163.081581 -snap {("G4" 0)}
wvCollapseGroup -win $_nWave2 "AXI_slave_if/G3-W"
wvExpandGroup -win $_nWave2 "AXI_master_if"
wvExpandGroup -win $_nWave2 "AXI_master_if/AXI_master_if-w"
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvSetCursor -win $_nWave2 264.758842 -snap {("AXI_master_if-ar" 0)}
wvCollapseGroup -win $_nWave2 "AXI_master_if/AXI_master_if-w"
wvSetCursor -win $_nWave2 120.176849 -snap {("AXI_slave_if" 0)}
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiSetActWin -win $_nWave2
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvCollapseGroup -win $_nWave2 "AXI_slave_if"
verdiSetActWin -win $_nWave2
wvCollapseGroup -win $_nWave2 "AXI_master_if"
wvSelectGroup -win $_nWave2 {G4}
wvSetCursor -win $_nWave2 193.132569 -snap {("G4" 0)}
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcSelect -win $_nTrace1 -range {267634 267634 1 12 1 1}
srcTBAddBrkPnt -win $_nTrace1 -line 267634 -file \
           /home/bitsilica/SAT/ajay/new_coralNPU/coralnpu_RTL/RvvCoreMiniVerificationAxi.sv
wvSetCursor -win $_nWave2 82.456979 -snap {("G4" 0)}
verdiSetActWin -win $_nWave2
wvExpandGroup -win $_nWave2 "AXI_master_if"
wvSelectGroup -win $_nWave2 {G4}
debExit
