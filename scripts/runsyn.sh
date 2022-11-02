#!/bin/sh -v

yosys -s ../../scripts/synth.ys >ref.log.txt
cp movavg_gl.v ref.movavg_gl.v
sta <../../scripts/sta.cmd >ref.cp.txt
sta <../../scripts/sta.dist.cmd >tmp
tail --lines=+13 tmp | awk '{print $5}' | head --lines=-1 >ref.slackdist.txt

yosys -s ../../scripts/synth.speed.ys >speed.log.txt
cp movavg_gl.v speed.movavg_gl.v
sta <../../scripts/sta.cmd >speed.cp.txt
sta <../../scripts/sta.dist.cmd >tmp
tail --lines=+13 tmp | awk '{print $5}' | head --lines=-1 >speed.slackdist.txt

yosys -s ../../scripts/synth.area.ys >area.log.txt
cp movavg_gl.v area.movavg_gl.v
sta <../../scripts/sta.cmd >area.cp.txt
sta <../../scripts/sta.dist.cmd >tmp
tail --lines=+13 tmp | awk '{print $5}' | head --lines=-1 >area.slackdist.txt

rm tmp
rm movavg_gl.v
