import {
  map,
  mapDoubleTap,
  rule,
  toKey,
  withModifier,
  writeToProfile,
} from "karabiner.ts";

writeToProfile("karabiner-config", [
  rule("Caps Lock -> Hyper/Esc, Right ⌥ -> Meh, RCMD -> Hyper ").manipulators([
    map("caps_lock").toHyper().toIfAlone("escape"),
    map("right_option").toMeh(),
    map("right_command").toHyper(),
  ]),

  rule("Hyper + A/D -> Tab left/right").manipulators([
    withModifier("Hyper")({
      s: toKey("tab", ["left_control", "shift"]),
      d: toKey("tab", ["left_control"]),
    }),
  ]),

  rule("Tab -> Meh").manipulators([map("tab").toMeh().toIfAlone("tab")]),

  rule("Avoid starting sysdiagnose with hyper").manipulators([
    map("comma", ["command", "shift", "option", "control"]).to([]),
    map("period", ["command", "shift", "option", "control"]).to([]),
    map("slash", ["command", "shift", "option", "control"]).to([]),
  ]),

  rule("Command+Q override with double tap requirement").manipulators([
    mapDoubleTap("q", "command").to("q", "command").singleTap(null),
  ]),
]);
