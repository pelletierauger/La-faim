(
[~pul2, ~pul3, ~noLow2].do({|i| i.set(\gate, 0, \fadeTime, 1)});
~bee.stop;
~chill.stop;
~sPA.stop;
~sPC.stop;
)

(
var f = 220 * 9.midiratio;
var ff = 54 + -12;
~hat.free;
~nT.sched(~nT.timeToNextBeat(quant: 1) + 0.2 + (~nT.beatDur * 0), {
    ~hat = {
        var trig = Impulse.ar((1 / ~nT.beatDur));
        var dem = Demand.ar(trig, 0, Dseq([1], inf));
        var note = Demand.ar(trig, 0, 42 + 12 + Dseq([0].stutter(5), inf));
        var sig = MiPlaits.ar(42 + 24 + 24 + 12 + 12,
            engine: 9,
            harm: 0.99,
            timbre: 0.99,
            morph: 0.25,
            trigger: trig,
            decay: 0.99,
            lpg_colour: 0,
            mul: 3);
/*    sig = (sig * 0.15) + MiRings.ar(sig,
        trig: 0,
        pit: note,
        struct: 0.5,
        bright: 0.2,
        damp: 0.65,
        pos: 2,
        bypass: 0);*/
        sig = LPF.ar(sig, 6000);
        sig = HPF.ar(sig, 200);
        sig = sig * 0.125 * 0.25;
        sig[1]!2;
    }.play(fadeTime: 0);
});
)