reset
set key right
#set style function linespoints
set xlabel '{/Symbol d}'
set terminal postscript eps  enhanced
set ylabel '{/Symbol D}P_{reach}'
#set key horizontal

#set output 'avg.eps'
#plot 'avg.out' using 1:2 w lp lw 2  title 'Hyperdiploid',\
#	 'avg.out' using 1:3 w lp lw 2  title 'TCF3-PBX1',\
#	 'avg.out' using 1:4 w lp lw 2  title 'ETV6\_RUNX1',\
#	 'avg.out' using 1:5 w lp lw 2  title 'MLL',\
#	 'avg.out' using 1:6 w lp lw 2  title 'Ph',\
#	 'avg.out' using 1:7 w lp lw 2  title 'Hypo',\
#	 'avg.out' using 1:8 w lp lw 2  title 'Other',\
#	 'avg.out' using 1:9 w lp lw 2  title 'T-ALL',\
#	 'avg.out' using 1:10 w lp lw 2  title 'Control\_HSC',\
#	 'avg.out' using 1:11 w lp lw 2  title 'Control\_lymphoid',\
#	 'avg.out' using 1:12 w lp lw 2  title 'Control\_myeloid'
#set output
#!epstopdf avg.eps

set output 'avg_abs.eps'
plot 'avg_abs.out' using 1:2 w lp lw 2  title 'Hyperdiploid',\
	 'avg_abs.out' using 1:3 w lp lw 2  title 'TCF3-PBX1',\
	 'avg_abs.out' using 1:4 w lp lw 2  title 'ETV6\_RUNX1',\
	 'avg_abs.out' using 1:5 w lp lw 2  title 'MLL',\
	 'avg_abs.out' using 1:6 w lp lw 2  title 'Ph',\
	 'avg_abs.out' using 1:7 w lp lw 2  title 'Hypo',\
	 'avg_abs.out' using 1:8 w lp lw 2  title 'Other',\
	 'avg_abs.out' using 1:9 w lp lw 2  title 'T-ALL',\
	 'avg_abs.out' using 1:10 w lp lw 2  title 'Control\_HSC',\
	 'avg_abs.out' using 1:11 w lp lw 2  title 'Control\_lymphoid',\
	 'avg_abs.out' using 1:12 w lp lw 2  title 'Control\_myeloid'
set output
!epstopdf avg_abs.eps

set key left
set output 'avg_abs_min.eps'
plot 'avg_abs.out' using 1:2 w lp lw 2  title 'Hyperdiploid',\
	 'avg_abs.out' using 1:3 w lp lw 2  title 'TCF3-PBX1',\
	 'avg_abs.out' using 1:4 w lp lw 2  title 'ETV6\_RUNX1',\
	 'avg_abs.out' using 1:5 w lp lw 2  title 'MLL',\
	 'avg_abs.out' using 1:6 w lp lw 2  title 'Ph',\
	 'avg_abs.out' using 1:7 w lp lw 2  title 'Hypo',\
	 'avg_abs.out' using 1:10 w lp lw 2  title 'Control\_HSC',\
	 'avg_abs.out' using 1:11 w lp lw 2  title 'Control\_lymphoid',\
	 'avg_abs.out' using 1:12 w lp lw 2  title 'Control\_myeloid'
set output
!epstopdf avg_abs_min.eps

set key left
set output 'avg_abs_2.eps'
plot 'avg_abs_2.out' using 1:2 w lp lw 2  title 'Hyperdiploid',\
	 'avg_abs_2.out' using 1:3 w lp lw 2  title 'TCF3-PBX1',\
	 'avg_abs_2.out' using 1:4 w lp lw 2  title 'ETV6\_RUNX1',\
	 'avg_abs_2.out' using 1:5 w lp lw 2  title 'MLL',\
	 'avg_abs_2.out' using 1:6 w lp lw 2  title 'Ph',\
	 'avg_abs_2.out' using 1:7 w lp lw 2  title 'Hypo',\
	 'avg_abs_2.out' using 1:8 w lp lw 2  title 'Other',\
	 'avg_abs_2.out' using 1:9 w lp lw 2  title 'T-ALL',\
	 'avg_abs_2.out' using 1:10 w lp lw 2  title 'Control\_HSC',\
	 'avg_abs_2.out' using 1:11 w lp lw 2  title 'Control\_lymphoid',\
	 'avg_abs_2.out' using 1:12 w lp lw 2  title 'Control\_myeloid'
set output
!epstopdf avg_abs_2.eps
