import React from "react";
import { Composition } from "remotion";
import { ReelBed, reelDurationInFrames, type Reel } from "./ReelBed";
import { ReelFinal, finalDurationInFrames, type Final } from "./ReelFinal";
import reelJson from "./reel.json";
import finalJson from "./final.json";

// The JSON import widens "kind" to string; the cast keeps the beat union honest.
const reel = reelJson as Reel;
const final = finalJson as Final;

/**
 * Two compositions, same scenes, same data (src/reel.json):
 *   ReelBed          1080×1080  square  — the default; your face cam is cut in over it
 *   ReelBedVertical  1080×1920  9:16    — when the bed IS the reel (no face cam)
 *   ReelFinal        1080×1920  9:16    — face cam over the square bed = the finished reel
 * Durations come from the `seconds` on each beat, so retiming is editing the JSON.
 */
export const RemotionRoot: React.FC = () => (
  <>
    <Composition
      id="ReelBed"
      component={ReelBed}
      durationInFrames={reelDurationInFrames(reel)}
      fps={reel.fps}
      width={1080}
      height={1080}
      defaultProps={{ reel }}
    />
    <Composition
      id="ReelBedVertical"
      component={ReelBed}
      durationInFrames={reelDurationInFrames(reel)}
      fps={reel.fps}
      width={1080}
      height={1920}
      defaultProps={{ reel }}
    />
    <Composition
      id="ReelFinal"
      component={ReelFinal}
      durationInFrames={finalDurationInFrames(final)}
      fps={final.fps}
      width={1080}
      height={1920}
      defaultProps={{ final }}
    />
  </>
);
