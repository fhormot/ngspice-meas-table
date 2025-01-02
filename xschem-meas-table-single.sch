v {xschem version=3.4.6 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
B 2 1120 -460 1920 -60 {flags=graph
y1=-0.025
y2=1.9
ypos1=0
ypos2=2
divy=5
subdivy=1
unity=1
x1=0
x2=3e-09
divx=5
subdivx=1
xlabmag=1.0
ylabmag=1.0
node="v_i
v_o"
color="4 8"
dataset=-1
unitx=1
logx=0
logy=0

autoload=0
sim_type=tran}
T {tcleval([xschem raw read $netlist_dir/[file tail [file rootname [xschem get current_name]]]-meas.raw
  set table "t_pd_l2h,t_pd_h2l"
  foreach t_pd_l2h [xschem raw values t_pd_l2h] t_pd_h2l [xschem raw values t_pd_h2l] \{
    append table \\\\n [to_eng $t_pd_l2h] \{,\} [to_eng $t_pd_h2l]
  \}
  xschem raw switch 0
  return [tabulate $table ,]])
} 2130 -470 0 1 0.3 0.3 {floater=1 font=monospace layer=15}
N 380 -410 520 -410 {lab=v_i}
N 950 -260 1000 -260 {lab=v_o}
N 120 -460 120 -280 {lab=VDD}
N 120 -460 580 -460 {lab=VDD}
N 120 -220 120 -60 {lab=GND}
N 220 -220 220 -60 {lab=GND}
N 220 -410 220 -280 {lab=v_i}
N 220 -410 380 -410 {lab=v_i}
N 580 -160 580 -130 {lab=#net1}
N 580 -380 580 -350 {lab=#net2}
N 520 -410 540 -410 {lab=v_i}
N 520 -410 520 -320 {lab=v_i}
N 520 -320 540 -320 {lab=v_i}
N 520 -320 520 -190 {lab=v_i}
N 520 -200 540 -200 {lab=v_i}
N 520 -190 520 -100 {lab=v_i}
N 520 -100 540 -100 {lab=v_i}
N 580 -70 580 -40 {lab=GND}
N 580 -480 580 -440 {lab=VDD}
N 580 -260 730 -260 {lab=v_o_n}
N 730 -320 730 -260 {lab=v_o_n}
N 580 -160 700 -160 {lab=#net1}
N 580 -360 700 -360 {lab=#net2}
N 730 -260 730 -200 {lab=v_o_n}
N 580 -170 580 -160 {lab=#net1}
N 580 -260 580 -230 {lab=v_o_n}
N 580 -290 580 -260 {lab=v_o_n}
N 580 -60 730 -60 {lab=GND}
N 730 -160 730 -60 {lab=GND}
N 760 -160 800 -160 {lab=VDD}
N 760 -360 800 -360 {lab=GND}
N 800 -360 840 -160 {lab=GND}
N 580 -460 730 -460 {lab=VDD}
N 730 -460 730 -360 {lab=VDD}
N 800 -160 840 -360 {lab=VDD}
N 840 -460 840 -360 {lab=VDD}
N 730 -460 840 -460 {lab=VDD}
N 730 -60 840 -60 {lab=GND}
N 840 -160 840 -60 {lab=GND}
N 580 -200 600 -200 {lab=GND}
N 600 -200 600 -60 {lab=GND}
N 580 -100 600 -100 {lab=GND}
N 580 -320 600 -320 {lab=VDD}
N 600 -460 600 -320 {lab=VDD}
N 580 -410 600 -410 {lab=VDD}
N 730 -260 870 -260 {lab=v_o_n}
N 120 -60 590 -60 {lab=GND}
C {lab_wire.sym} 480 -410 0 0 {name=p2 sig_type=std_logic lab=v_i
W=2.0}
C {lab_wire.sym} 990 -260 0 0 {name=p3 sig_type=std_logic lab=v_o}
C {vsource.sym} 120 -250 0 0 {name=V1 value=1.8 savecurrent=false}
C {vsource.sym} 220 -250 0 0 {name=V2 value="pwl 
+ 0 0
+ 't_delay' 0
+ 't_delay+t_edge' 1.8
+ 't_delay+t_edge+t_top' 1.8
+ 't_delay+2*t_edge+t_top' 0
+ '2*t_delay+2*t_edge+t_top' 0"
+ savecurrent=false}
C {devices/code.sym} 1280 -610 0 0 {name=NGSPICE
only_toplevel=true
value="
.param t_delay=1n
.param t_edge=10p
.param t_top=1n
.control
	save all

	setplot new
	set myplot=$curplot
	let t_pd_l2h=vector(1)
	let t_pd_h2l=vector(1)

	tran 0.1p 3n

	MEAS TRAN t_pd_L2H TRIG V(v_i) VAL=0.9 RISE=1 TARG V(v_o) VAL=0.9 RISE=1
	MEAS TRAN t_pd_H2L TRIG V(v_i) VAL=0.9 FALL=1 TARG V(v_o) VAL=0.9 FALL=1

	let \{$myplot\}.t_pd_l2h[0]=t_pd_l2h
	let \{$myplot\}.t_pd_h2l[0]=t_pd_h2l

	write xschem-meas-table-single.raw

	setplot $myplot
	settype time t_pd_l2h
	settype time t_pd_h2l
	write xschem-meas-table-single-meas.raw
.endc
" }
C {devices/code.sym} 1110 -610 0 0 {name=TT_MODELS
only_toplevel=true
format="tcleval(@value )"
value=".lib $::SKYWATER_MODELS/sky130.lib.spice tt
.include $::SKYWATER_STDCELLS/sky130_fd_sc_hd.spice"
spice_ignore=false
place=header}
C {sky130_stdcells/inv_1.sym} 910 -260 0 0 {name=x1 VGND=GND VNB=GND VPB=VDD VPWR=VDD prefix=sky130_fd_sc_hd__ }
C {devices/launcher.sym} 1510 -580 0 0 {name=h3
descr="Netlist & sim" 
tclcommand="xschem netlist; xschem simulate"}
C {devices/launcher.sym} 1510 -530 0 0 {name=h2 
descr="Load waveforms" 
tclcommand="
xschem raw_read $netlist_dir/[file tail [file rootname [xschem get current_name]]].raw tran
"
}
C {sky130_fd_pr/pfet_01v8.sym} 560 -410 0 0 {name=M4
W=2.5
L=0.45
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {gnd.sym} 580 -40 0 0 {name=l3 lab=GND}
C {vdd.sym} 580 -480 0 0 {name=l4 lab=VDD}
C {sky130_fd_pr/pfet_01v8.sym} 730 -340 3 0 {name=M5
W=1.3
L=0.45
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} 730 -180 1 0 {name=M6
W=4.5
L=0.45
nf=1 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} 560 -200 0 0 {name=M1
W=1
L=0.45
nf=1 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {lab_wire.sym} 690 -260 0 0 {name=p1 sig_type=std_logic lab=v_o_n
}
C {sky130_fd_pr/nfet_01v8.sym} 560 -100 0 0 {name=M2
W=1
L=0.45
nf=1 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} 560 -320 0 0 {name=M3
W=2.5
L=0.45
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
