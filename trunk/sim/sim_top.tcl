	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"TB"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
	set run_time			"2476660"
#	set run_time			"-all"

#============================ Add verilog files  ===============================
# Pleas add other module here	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/counter25.v
    vlog 	+acc -incr -source  +define+SIM 	$hdl_path/counter64.v 
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/register25b.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/top_level.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/top_level_controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/top_level_counter24.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/top_level_dp.v	
	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/addRc/addRc.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/addRc/addRc_controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/addRc/addRc_datapath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/addRc/addRc_file_reader.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/addRc/addRc_file_writer.v
	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colParity/col_parity.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colParity/col_parity_curr_depth.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colParity/col_parity_pre_depth.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colParity/colParity_controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colParity/colParity_datapath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colParity/colParity_file_reader.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colParity/colParity_file_writer.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/colParity/rotate_co25.v
	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/permute/permute.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/permute/permute_controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/permute/permute_datapath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/permute/permute_file_reader.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/permute/permute_file_writer.v
	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/revaluate/revaluate.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/revaluate/revaluate_controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/revaluate/revaluate_datapath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/revaluate/revaluate_file_reader.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/revaluate/revaluate_file_writer.v
	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/rotate/rotate.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/rotate/rotate_controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/rotate/rotate_datapath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/rotate/rotate_file_reader.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/rotate/rotate_file_writer.v

		
	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./tb/$TB.v
	onerror {break}

#================================ simulation ====================================

	vsim	-voptargs=+acc -debugDB $TB


#======================= adding signals to wave window ==========================


	add wave -hex -group 	 	{TB}				sim:/$TB/*
	add wave -hex -group 	 	{top}				sim:/$TB/uut/*	
	add wave -hex -group -r		{all}				sim:/$TB/*

#=========================== Configure wave signals =============================
	
	configure wave -signalnamewidth 2
    

#====================================== run =====================================

	run $run_time 
	