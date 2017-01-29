#!/bin/bash
rm plot.dat
PERIOD=0.1
DATA_POINTS=$1
if [ $DATA_POINTS == "" ]; then
    DATA_POINTS=50
fi
X=0
writedata() {
    while true; do
        X=$(echo $PERIOD "+" $X | bc -l)
        mb=$(nvidia-smi | head -n +9 | tail -n 1 | awk '{print $9}' | sed 's/MiB//')
        echo -e $X"\t"$mb >> plot.dat
        echo "$(tail -n $DATA_POINTS plot.dat)" > plot.dat
        sleep $PERIOD
    done
    echo "done"
}
trap "killall background" INT TERM
writedata &
sleep 0.5
watch -n $PERIOD gnuplot -e "'set term dumb; plot \"plot.dat\" using 1:2 with lines'"



