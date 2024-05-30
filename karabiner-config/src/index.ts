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
    // //     / + [ 1    2    3    4    5 ] =>
    // withMapper(["⌘", "⌥", "⌃", "⇧", "⇪"])((k, i) =>
    //   map((i + 1) as NumberKeyValue).toPaste(k)
    // ),
    // withMapper(["←", "→", "↑", "↓", "␣", "⏎", "⇥", "⎋", "⌫", "⌦", "⇪"])((k) =>
    //   map(k).toPaste(k)
    // ),
  ]),

  rule("Caps Lock -> Hyper").manipulators([
    map("caps_lock").toHyper().toIfAlone("escape"),
  ]),

  importJson(
    resolve(
      homedir(),
      ".config/karabiner/assets/complex_modifications/1713770432.json"
    )
  ),

  hyperLayer("o", "app-launch-layer").manipulators([
    { f: toApp("Finder") },
    { b: toApp("Firefox Developer Edition") },
    { c: toApp("Google Chrome") },
    { s: toApp("Slack") },
    { t: toApp("iTerm") },
    { v: toApp("Visual Studio Code") },
    { p: toApp("Spotify") },
  ]),

  hyperLayer("b", "browser-launch-layer").manipulators([
    { g: to$('open "https://github.com"') },
    { y: to$('open "https://youtube.com"') },
    { c: to$('open "https://app.fastmail.com/calendar/b"') },
    { m: to$('open "https://fastmail.com"') },
    { n: to$('open "https://notion.so"') },
    { r: to$('open "https://news.ycombinator.com"') },
    {
      j: to$(
        'open "https://nestiolistings.atlassian.net/jira/software/projects/AUTO/boards/78?assignee=712020%3Aee6769de-6645-4366-a7c5-75deffd3351a"'
      ),
    },
  ]),

  hyperLayer("c", "control-layer").manipulators([
    { h: toKey("rewind") },
    { l: toKey("fastforward") },
    { k: toKey("play_or_pause") },
    { j: toKey("volume_decrement") },
    { u: toKey("volume_increment") },
    { m: toKey("mute") },
    { i: toKey("apple_display_brightness_decrement") },
    { p: toKey("apple_display_brightness_increment") },
  ]),

  rule("Key mapping").manipulators([
    // config key mappings
    map(1).to(1),
  ]),
]);
