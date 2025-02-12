import {
  map,
  mapDoubleTap,
  rule,
  toKey,
  withModifier,
  writeToProfile,
} from "karabiner.ts";

writeToProfile("karabiner-config", [
  rule("Caps Lock -> Hyper/Esc, R⌥ / ⇥ -> Meh, ⌘ -> Hyper ").manipulators([
    map("caps_lock").toHyper().toIfAlone("escape"),
    map("right_option").toMeh(),
    map("tab").toMeh().toIfAlone("tab"),
    map("right_command").toHyper(),
  ]),

  rule("Hyper + A/D -> Tab left/right").manipulators([
    withModifier("Hyper")({
      s: toKey("tab", ["left_control", "shift"]),
      d: toKey("tab", ["left_control"]),
    }),
  ]),

  rule("Avoid starting sysdiagnose with hyper").manipulators([
    map("comma", ["command", "shift", "option", "control"]).to([]),
    map("period", ["command", "shift", "option", "control"]).to([]),
    map("slash", ["command", "shift", "option", "control"]).to([]),
  ]),

  rule("Double-tap ⌘+Q to quit").manipulators([
    mapDoubleTap("q", "command").to("q", "command").singleTap(null),
  ]),
]);
