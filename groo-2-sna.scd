(
var f = 220 * 9.midiratio;
var ff = 54 + -12;
// ~pul2.free;
// ~pul3.free;
// ~bee.stop;
// ~sPA.stop;
// ~sPC.stop;
~nT.sched(~nT.timeToNextBeat(quant: 1) + 0.2 + (~nT.beatDur * 0), {
    // a.free;
    // c.free;
    [~pul2].do({|i| i.set(\gate, 0, \fadeTime, 1)});
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
        [~pul3].do({|i| i.set(\gate, 0, \fadeTime, 1)});
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

)