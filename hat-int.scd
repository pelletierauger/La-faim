
(
u.free;
~nT.sched(~nT.timeToNextBeat(quant: 5) + 0.2, {
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
});
)