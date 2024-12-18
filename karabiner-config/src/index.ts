import {
  hyperLayer,
  ifVar,
  importJson,
  layer,
  map,
  mapSimultaneous,
  NumberKeyValue,
  rule,
  to$,
  toApp,
  toKey,
  toSetVar,
  withMapper,
  withModifier,
  writeToProfile,
} from "karabiner.ts";
import { homedir } from "node:os";
import { resolve } from "path";

// ! Change '--dry-run' to your Karabiner-Elements Profile name.
// (--dry-run print the config json into console)
// + Create a new profile if needed.
writeToProfile("karabiner-config", [
  // It is not required, but recommended to put symbol alias to layers,
  // (If you type fast, use simlayer instead, see https://evan-liu.github.io/karabiner.ts/rules/simlayer)
  // to make it easier to write '←' instead of 'left_arrow'.
  // Supported alias: https://github.com/evan-liu/karabiner.ts/blob/main/src/utils/key-alias.ts

  layer("/", "symbol-mode").manipulators([
    // Example of how to paste common characters on this layer
    // withMapper(["←", "→", "↑", "↓", "␣", "⏎", "⇥", "⎋", "⌫", "⌦", "⇪"])((k) =>
    //   map(k).toPaste(k)
    // ),
  ]),

  rule("Caps Lock -> Hyper").manipulators([
    map("caps_lock").toHyper().toIfAlone("escape"),
    map("right_option").toMeh(),
    map("right_command").toHyper(),
  ]),

  rule("Hyper + A/D for Tab Navigation").manipulators([
    withModifier("Hyper")({
      s: toKey("tab", ["left_control", "shift"]),
      d: toKey("tab", ["left_control"]),
    }),
  ]),

  rule("Tab -> Meh").manipulators([map("tab").toMeh().toIfAlone("tab")]),

  importJson(
    resolve(
      homedir(),
      ".config/karabiner/assets/complex_modifications/1713770432.json",
    ),
  ),

  rule("Control").manipulators([
    withModifier("Hyper")({
      i: toKey("apple_display_brightness_decrement"),
      p: toKey("apple_display_brightness_increment"),
    }),
  ]),

  // hyperLayer("b", "browser-launch-layer").manipulators([
  //   { g: to$('open "https://github.com"') },
  //   { y: to$('open "https://youtube.com"') },
  // ]),
]);
