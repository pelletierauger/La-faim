(
var f = 220 * 9.midiratio;
var ff = 54 + -12;
~pul2.free;
~pul3.free;
~bee.stop;
~sPA.stop;
~sPC.stop;
~nT.sched(~nT.timeToNextBeat(quant: 1) + 0.2 + (~nT.beatDur * 0), {
a.free;
    c.free;
    [~noLow, ~noLow2].do({|i| i.set(\gate, 0, \fadeTime, 1)});
    ~pul2 = {
        var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
        var dem = Demand.ar(trig, 0, Dseq([1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0], inf));
        var note = Demand.ar(trig, 0, ff + 12 + Dseq([0].stutter(5), inf));
        var sig = MiPlaits.ar(42 - 36 + 24,
            engine: 9,
            harm: 0.95,
            timbre: 1,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.25,
            trigger: trig * dem,
            decay: 0.8,
            lpg_colour: 0,
            mul: 3);
        /*    sig = (sig * 0.15) + MiRings.ar(sig,
        trig: 0,
        pit: note,
        struct: 0.9,
        bright: 0.4,
        damp: 0.65,
        pos: 2,
        bypass: 0);*/
        // sig = LPF.ar(sig, 10000);
        sig = HPF.ar(sig, 200);
        sig = sig * 0.8;
        sig[1]!2;
    }.play(fadeTime: 0);
});
h.free;
z.free;
~nT.sched(~nT.timeToNextBeat(quant: 1) + 0.2 + (~nT.beatDur * 0), {
    z = {
        var trig = Impulse.ar(1 / (~nT.beatDur * 5));
        var notes = Demand.ar(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.ar(trig, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.ar(trig, 0, Dseq([0, 0.99], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 30!2,
            timbre: 0.45 + lfo,
            color: 0.0 + dem2 + [0, 0.01],
            model: 4,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        );
        sig = LPF.ar(sig, 2000);
        sig * 0.65625 * 2;
    }.play(fadeTime: 0.1);

    h = {
        var trig = Impulse.ar(1 / (~nT.beatDur * 5));
        var notes = Demand.ar(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.ar(trig, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.ar(trig, 0, Dseq([0, 0.8], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 42!2 + 12,
            timbre: 0.01 + lfo,
            color: 0.0 + dem2 + [0, 0.01],
            model: 4,
            resamp: 2,
            decim: 32,
            bits: 6,
            ws: 0.4
        );
        sig = HPF.ar(sig, 1000);
        sig * 0.065625 * 2;
    }.play(fadeTime: 0.1);
});
~nT.sched(~nT.timeToNextBeat(quant: 1) + 0.2 + (~nT.beatDur * 0), {
    ~noLow = {
        var trig = Impulse.kr(1 / (~nT.beatDur * 5));
        var notes = Demand.kr(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.kr(trig, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.kr(trig, 0, Dseq([0, 0.9], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 48 - 36,
            timbre: dem2 * 0.5,
            color: 0.0 + dem2 + [0, 0.01],
            model: 4,
            resamp: 2,
            decim: 32,
            bits: 4,
            ws: 0
        );
        sig = LPF.ar(sig, 4000);
        sig * 0.75 * 0.5 * 0.4 * 18 * (1 - dem2).lag(0.5);
    }.play(fadeTime: 0.1);
});
~pul3.free;
~nT.sched(~nT.timeToNextBeat(quant: 1) + 0.18 + (~nT.beatDur * 0), {
    ~pul3 = {
        var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
        var dem = Demand.ar(trig, 0, Dseq([1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0], inf));
        var note = Demand.ar(trig, 0, ff + 12 + Dseq([0].stutter(5), inf));
        var sig = MiPlaits.ar(42 - 36,
            engine: 9,
            harm: 0.95,
            timbre: 0.9,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.25,
            trigger: trig * dem,
            decay: 0.9,
            lpg_colour: 0,
            mul: 3);
        /*    sig = (sig * 0.15) + MiRings.ar(sig,
        trig: 0,
        pit: note,
        struct: 0.9,
        bright: 0.4,
        damp: 0.65,
        pos: 2,
        bypass: 0);*/
        // sig = LPF.ar(sig, 6000);
        sig = HPF.ar(sig, 200);
        sig = sig * 2;
        sig[1]!2;
    }.play(fadeTime: 0);
});
/*u.free;
~nT.sched(~nT.timeToNextBeat(quant: 1) + 0.2, {
u = {
    var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
    var note = Demand.ar(trig, 0, 42
            + Dseq([-2, -7, -9, -7, -7].stutter(4), inf)
        );
    var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0], inf));
    var mod = Demand.ar(trig, 0, Dseq(((1..8)/10).stutter(1), inf));
    var sig = MiPlaits.ar(note - 12,
        engine: 3,
        harm: 0.125,
        timbre: 0.75,
        morph: SinOsc.kr(0.1).range(0, 0.95),
        morph: 0.5,
        trigger: trig * block,
        decay: 0.4,
        lpg_colour: 0,
        mul: 3);
    sig = sig[0]!2 * 1;
    sig = (sig * 0.15) + MiRings.ar(sig,
        trig: 0,
        pit: note - 12,
        struct: 0.9,
        bright: mod,
        damp: 1 - mod,
        pos: 0,
        bypass: 0,
            model: 4
        );
    sig = sig * 0.25;
        sig = Decimator.ar(sig, rate: 20000, bits: 6) * 0.5;
        sig = HPF.ar(sig, 4000) * 4;
    }.play(fadeTime: 0);
});*/
)



(
{
    var trig = Impulse.ar(4);
    var dem = Demand.ar(trig, 0, Dseq([0, 1], inf));
    var sig = SinOsc.ar(440) * dem;
    dem.lag(0.25);
}.plot(2);
)