~nT = TempoClock.new(1.39).permanent_(true);
~nT = TempoClock.new(1.49).permanent_(true);

(
~nT.sched(~nT.timeToNextBeat(quant: 1) + 0.2 + (~nT.beatDur * 0), {
    ~pul2.free;
    ~pul2 = {
        var trig = Impulse.ar((1 / ~nT.beatDur) * 4);
        var dem = Demand.ar(trig, 0, Dseq([1, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0], inf));
        // var dem = Demand.ar(trig, 0, Dseq([0, 0, 1, 0, 0, 1, 1, 0], inf));
        var note = Demand.ar(trig, 0, 42 + 12 + Dseq([0].stutter(5), inf));
        var sig = MiPlaits.ar(42 - 36 + 24,
            engine: 9,
            harm: 0.95,
            timbre: 1,
            morph: SinOsc.kr(0.1).range(0, 0.95),
            morph: 0.25,
            trigger: trig * dem,
            decay: 0.8,
            lpg_colour: 0
        );
        // sig = HPF.ar(sig, 200);
        sig = VadimFilter.ar(sig, SinOsc.kr(0.1).range(100, 1000), resonance: 0, type: 5);
        sig = sig * 2.4 * SinOsc.kr(0.1).range(1, 3);
        sig[1]!2;
    }.play(fadeTime: 0.01);
});
~nT.sched(~nT.timeToNextBeat(quant: 1) + 0.2 + (~nT.beatDur * 0), {
    z.free;
    z = {
        var trig = Impulse.ar((1 / (~nT.beatDur)));
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0, 0], inf));
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
            pitch: 30 + [0, 0.1],
            timbre: 0.45 + lfo,
            color: 0.0 + dem2,
            model: 4,
            resamp: 2,
            decim: 32,
            bits: 2,
            ws: 0
        );
        // sig = LPF.ar(sig, 2000);
        sig = VadimFilter.ar(sig, 4000, resonance: 0, type: 1);
        sig * 0.65625 * 1.5;
    }.play(fadeTime: 0.1);
    h.free;
    h = {
        var trig = Impulse.ar((1 / (~nT.beatDur)));
        var block = Demand.ar(trig, 0, Dseq([1, 0, 0, 0, 0], inf));
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
            pitch: 42 + [0, 0.1] + 12,
            timbre: 0.01 + lfo,
            color: 0.0 + dem2,
            model: 4,
            resamp: 2,
            decim: 32,
            bits: 6,
            ws: 0.4
        );
        // sig = HPF.ar(sig, 1000);
        sig = VadimFilter.ar(sig, 1000, resonance: 0, type: 5);
        sig * 0.065625 * 1.5;
    }.play(fadeTime: 0.1);
    v.set(\gate, 0, \fadeTime, 0.1);
    v = {
        var trig, amp, sig;
        trig = Impulse.ar(~nT.tempo);
        amp = EnvGen.ar(Env.new([0, 0.25, 0], [0.0125, 2]), trig);
        sig = MiPlaits.ar(25 + 12 - 2,
            engine: 13,
            harm: 0.5,
            timbre: 0.9,
            morph: 0.7,
            trigger: trig,
            decay: 0.2,
            lpg_colour: 0,
            mul: 2) * 0.25;
        sig = sig[0];
        sig = VAKorg35.ar(sig, freq: 200, res: 0.1, overdrive: 0.05);
        sig!2;
    }.play(fadeTime: 0);
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
        // sig = HPF.ar(sig, 500);
        // sig = LPF.ar(sig, 3000);
        sig = VadimFilter.ar(sig, 500, resonance: 0, type: 5);
        sig = VadimFilter.ar(sig, 4000, resonance: 0, type: 1);
        sig * 4.8 * 2;
    }.play(fadeTime: 0.1);
});
)