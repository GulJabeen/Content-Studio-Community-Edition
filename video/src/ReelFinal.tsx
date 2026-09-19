import React from "react";
import { AbsoluteFill, OffthreadVideo, useVideoConfig, staticFile } from "remotion";

/**
 * ReelFinal — the finished 9:16 reel: your face cam over the motion bed.
 *
 * Layout (1080×1920):
 *   y    0– 840   face cam, cropped to fill  (1080×840)
 *   y  840–1920   ReelBed's square render    (1080×1080)
 *
 * The square bed exists precisely so it can sit under a face cam without being
 * letterboxed — render `ReelBed` (not `ReelBedVertical`) when you plan to combine.
 *
 * Audio comes from the face cam only; the bed is silent by design.
 */
export type Final = {
  /** path relative to video/public/ — e.g. "facecam.mp4" */
  facecam: string;
  /** path relative to video/public/ — e.g. "bed.mp4" */
  bed: string;
  fps: number;
  /** measured from the face cam by the combine command */
  durationInSeconds: number;
  /** face cam height in px; the bed takes the rest */
  facecamHeight?: number;
};

export const finalDurationInFrames = (f: Final) =>
  Math.max(1, Math.round(f.durationInSeconds * f.fps));

export const ReelFinal: React.FC<{ final: Final }> = ({ final }) => {
  const { height } = useVideoConfig();
  const camH = final.facecamHeight ?? 840;
  const bedH = height - camH;

  return (
    <AbsoluteFill style={{ backgroundColor: "#0b0b0d" }}>
      {/* face cam — cropped to fill, never squashed */}
      <div style={{ position: "absolute", top: 0, left: 0, width: "100%", height: camH, overflow: "hidden" }}>
        <OffthreadVideo
          src={staticFile(final.facecam)}
          style={{ width: "100%", height: "100%", objectFit: "cover" }}
        />
      </div>

      {/* the motion bed, muted */}
      <div style={{ position: "absolute", top: camH, left: 0, width: "100%", height: bedH, overflow: "hidden" }}>
        <OffthreadVideo
          src={staticFile(final.bed)}
          muted
          style={{ width: "100%", height: "100%", objectFit: "cover" }}
        />
      </div>

      {/* hairline seam so the two halves read as one frame, not a collage */}
      <div
        style={{
          position: "absolute", top: camH - 1, left: 0, width: "100%", height: 2,
          background: "rgba(255,255,255,0.10)",
        }}
      />
    </AbsoluteFill>
  );
};
