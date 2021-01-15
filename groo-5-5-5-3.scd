(
var f = 220 * 9.midiratio;
var ff = 54 + -12;
var sw = 0.01;
// a.free;
~nT.sched(~nT.timeToNextBeat(quant: 1) + 0.25 + (~nT.beatDur * 0), {
    a.set(\gate, 0, \fadeTime, 0.5);
    // [~noLow, z, h, ~pul2, ~pul3].do({|i| i.set(\gate, 0, \fadeTime, 0.1)});
    // ~sPA.stop;
    // ~sPC.stop;
    // u.free;
    a = {
        var trig = Impulse.ar((1 / (~nT.beatDur)));
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0, 0].wrapExtend(18), inf));
        var note = Demand.ar(trig, 0, ff + 12 + Dseq([0, 5, -2].stutter(5) ++ (3!3), inf));
        var note2 = Demand.ar(trig, 0, ff + 12 + Dseq([0, 5].stutter(1), inf));
        var sig = MiPlaits.ar(note + [0, 0.1],
            engine: 3,
            harm: 0.25,
            timbre: 0.0,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.5,
            trigger: trig * block,
            decay: 0.1,
            lpg_colour: 0,
            mul: 3);
        sig = (sig * 0.15) + MiRings.ar(sig,
            trig: 0,
            pit: note,
            struct: 0.9,
            bright: 0.4 - ((note2 - ff - 12) * 0.2 * 0.5),
            damp: 0.65 + ((note2 - ff - 12) * 0.2 * 0.25),
            pos: 2,
            bypass: 0);
        sig = sig * 0.125;
    }.play(fadeTime: 0);
});
// c.free;
~nT.sched(~nT.timeToNextBeat(quant: 1) + 0.25 + (~nT.beatDur * 0), {
    c.set(\gate, 0, \fadeTime, 0.5);
    c = {
        var trig = Impulse.ar((1 / (~nT.beatDur)));
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0, 0].wrapExtend(18), inf));
        var note = Demand.ar(trig, 0, 30 + 12 + Dseq([0, -5, -2].stutter(5) ++ (-7!3), inf));
        var sig = MiPlaits.ar(note + [0, 0.1],
            engine: 3,
            harm: 0.25,
            timbre: 0.0,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.5,
            trigger: trig * block,
            decay: 0.1,
            lpg_colour: 0,
            mul: 3);
        sig = (sig * 0.15) + MiRings.ar(sig,
            trig: 0,
            pit: note - 12,
            struct: 0.9,
            bright: 0.4,
            damp: 0.65,
            pos: 2,
            bypass: 0);
        sig = sig * 0.25;
    }.play(fadeTime: 0.01);
});
~sPA.stop;
~sPA = Pbind(
    \instrument, \samplerLPF,
    \dur, Pseq([4, 3 - sw, 3 + sw, 4 - sw, 4 + sw, 2].wrapExtend(18) ++ [1, 2, 3, 2, 2, 2] / 4, inf),
    \spos, 0,
    \atk, 0.001,
    \susT, 0.6,
    \rel, 0.001,
    \rate, Pseq([-5, -5, -5, -5, -4, -4].midiratio, inf),
    \amp, Pseq([2, 1, 1.5, 1, 1.75, 1.5], inf) * 1.4,
    \pan, 0,
    \out, 0,
    \buf, ~softPluckA,
    \buf, Pseq([~softPluckA].stutter(4) ++ [~softPluckB].stutter(2), inf)
).play(~nT, quant: [1, 0]);
~sPC.stop;
~sPC = Pbind(
    \instrument, Pseq([\samplerFlip, \sampler], inf),
    \dur, Pseq([4, 3 - sw, 3 + sw, 4 - sw, 4 + sw, 2].wrapExtend(18) ++ [1, 2, 3, 2, 2, 2] / 4, inf),
    \spos, 0.047,
    \atk, 0.001,
    \susT, 1.1,
    \rel, 0.001,
    \rate, -2.midiratio,
    \amp, Pseq([2, 1, 2, 1, 2, 1], inf) * 0.75,
    \pan, 0,
    \out, 0,
    \buf, ~softPluckC
).play(~nT, quant: [1, 0]);
u.free;
~nT.sched(~nT.timeToNextBeat(quant: 1) + 0.2, {
u = {
    var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
    var note = Demand.ar(trig, 0, 42
            + Dseq([-2, -7, -9, -7, -7].wrapExtend(18).stutter(4), inf)
            + Dseq((0!15 ++ (-5!3 + [0, 5, 7 - 12] + 12)).stutter(4), inf)
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
        sig = HPF.ar(sig, 2000);
    }.play(fadeTime: 0);
});
)


(
~bee.stop;
~bee = Pbind(
    \instrument, Pseq([\sampler, \samplerFlip], inf),
    // \dur, 8 / (122/60),
    \dur, 5 * 3 + 3,
    \spos, 0.0125,
    \atk, 0.001,
    \susT, ~abeille.duration - 5,
    \rel, 2,
    \rate, 1,
    \amp, 1.85,
    \pan, 0,
    \out, 0,
    \buf, ~abeille
).play(~nT, quant: [1, 0]);
)


(
var f = 220 * 9.midiratio;
var ff = 54 + -12;
~pul2.free;
~nT.sched(~nT.timeToNextBeat(quant: 1) + 0.2 + (~nT.beatDur * 0), {
    ~pul2 = {
        var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
        var dem = Demand.ar(trig, 0, Dseq(([1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0] ++ [1] ++ [0].stutter(19)).wrapExtend(72), inf));
        var note = Demand.ar(trig, 0, ff + 12 + Dseq([0].stutter(5), inf));
        var sig = MiPlaits.ar(42 - 36 + 24,
            engine: 9,
            harm: 0.95,
            timbre: 0.9,
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
        sig = LPF.ar(sig, 6000);
        sig = HPF.ar(sig, 200);
        sig = sig * 0.5;
        sig[1]!2;
    }.play(fadeTime: 0);
});
~pul3.free;
~nT.sched(~nT.timeToNextBeat(quant: 1) + 0.18 + (~nT.beatDur * 0), {
    ~pul3 = {
        var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
        var dem = Demand.ar(trig, 0, Dseq(([0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0] ++ ([0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0] * 1)).wrapExtend(72), inf));
        // var dem = Demand.ar(trig, 0, Dseq(([0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0] ++ [0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0] ++ [0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0] ++ [0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0]), inf));
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
        sig = HPF.ar(sig, 400);
        sig = sig * 1.5;
        sig[1]!2;
    }.play(fadeTime: 0);
});
)

// Bruit haut

(
[~noLow].do({|i| i.set(\gate, 0, \fadeTime, 1)});

~nT.sched(~nT.timeToNextBeat(quant: 1) + 0.2 + (~nT.beatDur * 0), {
    ~noLow = {
        var trig = Impulse.ar((1 / (~nT.beatDur)));
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0, 0].wrapExtend(18), inf));
        var notes = Demand.ar(trig, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.ar(trig, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.ar(trig * block, 0, Dseq([0, 0.9], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 48 - 36,
            timbre: dem2.lag(0.5) * 0.5,
            color: 0.0 + dem2.lag(0.5) + [0, 0.01],
            model: 4,
            resamp: 2,
            decim: 32,
            bits: 4,
            ws: 0
        );
        sig = LPF.ar(sig, 4000);
        sig * 0.75 * 0.5 * 0.4 * 12;
    }.play(fadeTime: 0.1);
});
)

// Bruit bas

(
[~noLow2].do({|i| i.set(\gate, 0, \fadeTime, 1)});

~nT.sched(~nT.timeToNextBeat(quant: 1) + 0.25 + (~nT.beatDur * 0), {
    ~noLow2 = {
                var trig = Impulse.ar((1 / (~nT.beatDur)));
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0, 0].wrapExtend(18), inf));
        var notes = Demand.ar(trig * block, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.ar(trig * block, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.ar(trig * block, 0, Dseq([0.5, 0.9], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 12,
            timbre: dem2.lag(0.5) * 0.5,
            color: 0.0 + dem2.lag(0.5) + [0, 0.01],
            model: 4,
            resamp: 2,
            decim: 32,
            bits: 4,
            ws: 0
        );
        sig = HPF.ar(sig, 500);
        sig = LPF.ar(sig, 3000);
        sig * 0.75 * 0.5 * 0.4 * 8;
    }.play(fadeTime: 0.1);
});
)



// Encore plus intense


(
var f = 220 * 9.midiratio;
var ff = 54 + -12;
~pul2.free;
~pul3.free;
a.free;
c.free;
~sPA.stop;
~sPC.stop;
~nT.sched(~nT.timeToNextBeat(quant: 1) + 0.2 + (~nT.beatDur * 0), {

    ~pul2 = {
        var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
        var dem = Demand.ar(trig, 0, Dseq([1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0].wrapExtend(60) ++ [1, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0], inf));
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
)


(
h.free;
z.free;
~nT.sched(~nT.timeToNextBeat(quant: 1) + 0.2 + (~nT.beatDur * 0), {
    z = {
        var trig = Impulse.ar((1 / (~nT.beatDur)));
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0, 0].wrapExtend(18), inf));
        var notes = Demand.ar(trig * block, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.ar(trig * block, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.ar(trig * block, 0, Dseq([0, 0.99], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 30!2,
            timbre: 0.45 + lfo,
            color: 0.0 + dem2,
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
        var trig = Impulse.ar((1 / (~nT.beatDur)));
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0, 0].wrapExtend(18), inf));
        var notes = Demand.ar(trig * block, 0,
            Dseq(32 + [0] + 0, inf)
        );
        var dem = Demand.ar(trig * block, 0, Dseq((1..6) * 0.1, inf));
        var dem2 = Demand.ar(trig * block, 0, Dseq([0, 0.8], inf));
        var lfo = SinOsc.kr(0.1).range(0.0, 0.001);
        var lfo2 = SinOsc.kr(0.25).range(0.75, 0.125);
        var lfo3 = SinOsc.kr(1).range(0, 2000);
        var env = EnvGen.kr(Env.new([0, 1, 0], [0.05, 2]), gate: trig);
        var sig = MiBraids.ar(
            pitch: 42!2 + 12,
            timbre: 0.01 + lfo,
            color: 0.0 + dem2,
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
)