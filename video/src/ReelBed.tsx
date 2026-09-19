import React from "react";
import { AbsoluteFill, interpolate, spring, useCurrentFrame, useVideoConfig } from "remotion";
import { TransitionSeries, springTiming } from "@remotion/transitions";
import { fade } from "@remotion/transitions/fade";

/**
 * A data-driven five-beat reel bed. Every scene is plain type on a flat ground in the
 * brand's own colours, timed from `beats[].seconds`. Nothing here is decorative: the
 * bed exists so the creator's on-screen text lands on the beat they are speaking.
 *
 * Retime by editing src/reel.json. Scenes cross-fade over 12 frames, so each beat is
 * padded by 12 frames except the last; on-screen time equals `seconds` exactly.
 */

export type Beat = {
  kind: "hook" | "shock" | "intro" | "explain" | "cta";
  seconds: number;
  big: string;
  small?: string;
  items?: string[];
};

export type Reel = {
  brand: {
    name: string;
    handle: string;
    colors: { bg: string; ink: string; accent: string; muted: string };
  };
  fps: number;
  beats: Beat[];
};

const FADE = 12;
const FONT = "Inter, -apple-system, 'Segoe UI', Helvetica, Arial, sans-serif";

export const reelDurationInFrames = (reel: Reel) =>
  reel.beats.reduce((sum, b, i) => sum + Math.round(b.seconds * reel.fps) + (i < reel.beats.length - 1 ? FADE : 0), 0) -
  FADE * (reel.beats.length - 1);

const useRise = (delay: number, damping = 20, stiffness = 140) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  const p = spring({ frame: frame - delay, fps, from: 0, to: 1, config: { damping, stiffness } });
  const o = interpolate(frame - delay, [0, 9], [0, 1], { extrapolateLeft: "clamp", extrapolateRight: "clamp" });
  return { opacity: o, transform: `translateY(${(1 - p) * 26}px)`, filter: `blur(${(1 - p) * 8}px)` } as React.CSSProperties;
};

const Ground: React.FC<{ reel: Reel; children: React.ReactNode }> = ({ reel, children }) => {
  const frame = useCurrentFrame();
  const { width, height } = useVideoConfig();
  const drift = 1 + Math.min(frame, 400) * 0.00006;
  const c = reel.brand.colors;
  const pad = Math.round(width * 0.08);
  return (
    <AbsoluteFill style={{ background: c.bg, fontFamily: FONT, color: c.ink }}>
      <AbsoluteFill style={{ transform: `scale(${drift})` }}>
        <div
          style={{
            position: "absolute",
            inset: 0,
            background: `radial-gradient(60% 50% at 20% 15%, ${c.accent}22, transparent 70%)`,
          }}
        />
      </AbsoluteFill>
      <AbsoluteFill style={{ padding: pad, justifyContent: "center", alignItems: "center", textAlign: "center" }}>
        {children}
      </AbsoluteFill>
      <div
        style={{
          position: "absolute",
          bottom: Math.round(height * 0.035),
          right: pad,
          fontSize: 24,
          fontWeight: 800,
          letterSpacing: "0.04em",
          color: c.muted,
        }}
      >
        {reel.brand.handle}
      </div>
    </AbsoluteFill>
  );
};

const Eyebrow: React.FC<{ text: string; color: string; delay?: number }> = ({ text, color, delay = 0 }) => (
  <div style={{ ...useRise(delay), fontSize: 24, fontWeight: 800, letterSpacing: "0.22em", textTransform: "uppercase", color }}>
    {text}
  </div>
);

const Big: React.FC<{ text: string; color: string; size: number; delay?: number }> = ({ text, color, size, delay = 6 }) => (
  <div style={{ ...useRise(delay), fontSize: size, fontWeight: 900, letterSpacing: "-0.03em", lineHeight: 1.02, color, marginTop: 18, maxWidth: 900 }}>
    {text}
  </div>
);

const Small: React.FC<{ text?: string; color: string; delay?: number; size?: number }> = ({ text, color, delay = 26, size = 40 }) =>
  text ? (
    <div style={{ ...useRise(delay), fontSize: size, fontWeight: 700, lineHeight: 1.25, color, marginTop: 28, maxWidth: 880 }}>{text}</div>
  ) : null;

const Scene: React.FC<{ reel: Reel; beat: Beat }> = ({ reel, beat }) => {
  const c = reel.brand.colors;
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();
  switch (beat.kind) {
    case "hook":
      return (
        <Ground reel={reel}>
          <Big text={beat.big} color={c.ink} size={124} delay={4} />
          <Small text={beat.small} color={c.accent} delay={30} size={44} />
        </Ground>
      );
    case "shock":
      return (
        <Ground reel={reel}>
          <Big text={beat.big} color={c.accent} size={150} delay={4} />
          <Small text={beat.small} color={c.ink} delay={28} />
        </Ground>
      );
    case "intro":
      return (
        <Ground reel={reel}>
          <Eyebrow text="who's telling you this" color={c.muted} />
          <Big text={beat.big} color={c.ink} size={96} delay={8} />
          <Small text={beat.small} color={c.muted} delay={30} size={34} />
        </Ground>
      );
    case "explain":
      return (
        <Ground reel={reel}>
          <Eyebrow text="the one thing" color={c.accent} />
          <Big text={beat.big} color={c.ink} size={64} delay={6} />
          <div style={{ display: "flex", flexDirection: "column", gap: 16, marginTop: 36, width: 880 }}>
            {(beat.items ?? []).map((item, i) => {
              const p = spring({ frame: frame - (24 + i * 18), fps, from: 0, to: 1, config: { damping: 21, stiffness: 145 } });
              return (
                <div
                  key={i}
                  style={{
                    opacity: p,
                    transform: `translateX(${(1 - p) * -40}px)`,
                    textAlign: "left",
                    fontSize: 38,
                    fontWeight: 800,
                    lineHeight: 1.2,
                    padding: "18px 26px",
                    borderRadius: 18,
                    background: `${c.ink}0D`,
                    borderLeft: `5px solid ${c.accent}`,
                    color: c.ink,
                  }}
                >
                  {item}
                </div>
              );
            })}
          </div>
        </Ground>
      );
    case "cta": {
      const pulse = 1 + Math.sin(Math.max(0, frame - 30) * 0.09) * 0.012;
      return (
        <Ground reel={reel}>
          <Eyebrow text="comment the word" color={c.muted} />
          <div style={{ transform: `scale(${pulse})` }}>
            <Big text={beat.big} color={c.accent} size={150} delay={6} />
          </div>
          <Small text={beat.small} color={c.ink} delay={30} size={36} />
        </Ground>
      );
    }
  }
};

export const ReelBed: React.FC<{ reel: Reel }> = ({ reel }) => (
  <TransitionSeries>
    {reel.beats.map((beat, i) => (
      <React.Fragment key={i}>
        <TransitionSeries.Sequence durationInFrames={Math.round(beat.seconds * reel.fps) + (i < reel.beats.length - 1 ? FADE : 0)}>
          <Scene reel={reel} beat={beat} />
        </TransitionSeries.Sequence>
        {i < reel.beats.length - 1 && (
          <TransitionSeries.Transition timing={springTiming({ config: { damping: 200 }, durationInFrames: FADE })} presentation={fade()} />
        )}
      </React.Fragment>
    ))}
  </TransitionSeries>
);
