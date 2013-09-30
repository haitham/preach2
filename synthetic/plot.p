set boxwidth 0.5
set style fill solid
set terminal postscript eps  enhanced
set xlabel "Number of nodes"
set ylabel "Average time [sec]"

set output "BA.eps"
plot "summary.out" using 2:xtic(1) with boxes title ""
set output
!epstopdf BA.eps

set output "ER.eps"
plot "summary.out" using 3:xtic(1) with boxes title ""
set output
!epstopdf ER.eps