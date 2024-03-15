#NEXT STOP
use_debug false
use_bpm 155
#----------------------------------------------------------------------
#MIXER
master = 1.0

kick_amp = 0.8
tüt1_amp = 0.2
tüt2_amp = 0.2
clap_amp = 0.5
ts_amp = 0.15

hat_amp = 0.2
zk_amp = 0.2

synth1_amp = 0.0
synth2_amp = 0.0

train_amp = 0.0

metro1_amp = 0.0
metro2_amp = 0.2
#----------------------------------------------------------------------
#RHYTHMS
kick_rhythm = (ring 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,
               1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1,
               1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,
               1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1)

kick_rhythm2 = (ring 1, 0, 0, 1, 0, 0, 0, 1,
                1, 0, 0, 1, 1, 0, 1, 0,
                1, 0, 0, 1, 0, 0, 1, 0,
                1, 0, 0, 1, 1, 1, 0, 0)

perc_rhythm = (ring 1, 1, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 1, 1, 1, 0)

sn_rhythm = (ring 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,
             1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1,
             1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,
             1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1,1)

#----------------------------------------------------------------------
#SAMPLE CONTROLS
kick1 = "~your_path~/kick1"
kick2 = "~your_path~/kick2"

hat1 = "~your_path~/hat1"
hat2 = "~your_path~/hat2"
snare = "~your_path~/snare"
clap = "~your_path~/clap"
perc = "~your_path~/perc"

metro = "~your_path~/metroEN.wav"
metro2 = "~your_path~/metroSP2.wav"
train = "~your_path~/train.wav"
#----------------------------------------------------------------------

#DRUMS
live_loop :kick do
  #stop
  with_fx :gverb, release: 0.025, dry: 0.75, room: 2.3 do # 2.2
    with_fx :eq, low_shelf: 0.1,  low: 0.05 do
      sample kick1, amp: kick_amp * master * kick_rhythm.tick, beat_stretch: 1.0, cutoff: 100, release: 0.002, attack: 0.02
      sleep 0.5
    end
  end
end

live_loop :tüt1 do
  #stop
  with_fx :reverb, mix: 0.5, room: 0.75 do
    sample perc, #hat | snare | perc
      amp: tüt1_amp * master,
      beat_stretch: (ring 1.0, 1.075).tick,
      cutoff: 90
    sleep 4
  end
end


live_loop :tüt2 do
  #stop
  with_fx :reverb, mix: 0.15, room: 0.2 do
    sample perc, #hat | snare | perc
      amp: tüt2_amp * master,
      beat_stretch: 1,
      rate: (ring  2, -1, 2, 2).tick,
      cutoff: 90
    sleep 4
  end
end

live_loop :clap do
  #stop
  with_fx :reverb, mix: 0.15, room: 0.5 do
    sample clap,
      amp: clap_amp * master * sn_rhythm.tick ,
      beat_stretch: 0.5,
      cutoff: 90,
      rate: 1
    sleep 1
  end
end

live_loop :hat do
  #stop
  with_fx :reverb, mix: 0.5, room: 0.25 do
    ride_co = range(105, 100, 1).mirror
    with_fx :reverb, mix: 0.3, room: 0.25 do
      sample  perc,
        amp: hat_amp * master * sn_rhythm.tick,
        beat_stretch: 1,
        cutoff: ride_co.look,
        rate: 3
      sleep 0.5
    end
  end
end

live_loop :ts do
  #stop
  with_fx :reverb, mix: 0.25 do
    sample  perc,
      amp: ts_amp * master,
      rate: -1.75,
      cutoff: 120,
      release: 0.08,
      attack: 0.01
    sleep 1
  end
end

live_loop :tüttztz do
  #stop
  sync :tüt1
  with_fx :slicer, phase: 0.25 do
    with_fx :reverb, mix: 0.15, room: 0.35 do
      2.times do
        sample  clap,
          amp: zk_amp * master,
          beat_stretch: 0.35,
          rate: 1, #(ring 1, 1, -0.5,-0.5).tick | 1
          cutoff: 100
        sleep 0.25
      end
      sleep 1
      4.times do
        sample  clap,
          amp: zk_amp * master,
          beat_stretch: 0.25,
          rate: 1, #(ring 1, 1, -1,-0.5).tick | 1
          cutoff: 100
        sleep 0.25
      end
      sleep 1
      1.times do
        sample  clap,
          amp: zk_amp * master,
          beat_stretch: 0.25,
          rate: 1, ##(ring 1, 1, -1,-1).tick | 1
          cutoff: 100
        sleep 0.25
      end
      sleep 2
    end
  end
end

#STUFF
live_loop :metro do
  stop
  with_fx :reverb, mix: 0.7 do
    with_fx :slicer, phase: 0.5 do # 4 | 0.5
      sample  metro,
        amp: metro1_amp * master,
        beat_stretch: 7, #8 | 7 | 5.75
        rate: (ring 1, 1).tick,
        cutoff: 90,
        release: 0.05,
        attack: 0.05
      sleep 16
    end
  end
end

live_loop :metro2 do
  #stop
  with_fx :reverb, mix: 0.4 do
    with_fx :slicer, phase: (ring 1, 0.5, 1, 0.25).tick do
      sample  metro2,
        amp: metro2_amp * master,
        beat_stretch: 1.25, #(ring, -1.25, 8).tick
        cutoff: 90,
        release: 0.05,
        attack: 0.05
      sleep 8
    end
  end
end

live_loop :train do
  stop
  #sync :kick
  with_fx :slicer, phase: 0.5 do
    sample  train,
      amp: train_amp * master,
      beat_stretch: 24,
      release: 0.8,
      rate: (ring -1, 1, -1, 1.5).tick,
      release: 0.01,
      attack: 0.3,
      cutoff: 80
    sleep 12
  end
end

#SYNTHS
live_loop :synth1 do
  stop
  with_fx :slicer, phase: 0.5 do
    use_random_seed (ring, 2000, 22).tick
    4.times do
      with_synth :bass_foundation do
        n = (ring :d3, :f2, :e3, :b3).choose
        play scale(n, :blues_major).choose,
          release: (ring 6, 6.5, 7,  6).tick ,
          cutoff: 115,
          res: 0.8,
          attack: 0.75,
          wave: 0,
          amp: synth2_amp * master,
          pitch: 12 #
        sleep 4
      end
    end
  end
end

live_loop :synth2 do
  stop
  with_fx :reverb, mix: 0.35, room: 0.25 do
    with_fx :hpf, cutoff: 20 do
      with_fx :lpf, cutoff: 130 do
        use_random_seed (ring, 2000, 22).tick #(ring, 20, 22).tick | (ring, 2000, 22).tick
        2.times do # 16 | 2
          with_synth :bass_foundation do
            synth_co = range(80, 90, 1).mirror
            n = (ring :d2, :f2, :e3, :b3).choose
            play scale(n, :bartok).choose,
              release: (ring 0.01, 7.5, 9, 7).tick  , # ring 0.01, 7.5, 9, 7 || ring 0.5, 0.75, 0.9, 0.25 || 0.01, 2.0, 2.5, 1.75
              cutoff: synth_co.look,
              res: 0.8,
              attack: 0.01,
              amp: synth1_amp * master, #
              pitch: -7 # -7 || -10,
              sleep 2 # 0.5 | 2
          end
        end
      end
    end
  end
end