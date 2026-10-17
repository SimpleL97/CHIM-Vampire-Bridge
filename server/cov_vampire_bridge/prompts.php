<?php

/**
 * CHIM Vampire Bridge by SaurOff - how agents react to the events the game sends.
 * Loaded inside a function: use $GLOBALS.
 */

$covNpc  = $GLOBALS["HERIKA_NAME"] ?? "";
$covTail = $GLOBALS["TEMPLATE_DIALOG"] ?? "";

$GLOBALS["PROMPTS"]["cov_thrall"] = [
    "cue" => ["({$covNpc} reacts in character to what just happened to the thrall described above. If {$covNpc} is the one who was bound: a dazed, devoted first line to their new masters. If {$covNpc} was released: confusion, relief or anger. Anyone else: their honest reaction - awe, unease, amusement or desire. One or two short lines.) {$covTail}"],
];
$GLOBALS["PROMPTS"]["cov_vampire_turned"] = [
    "cue" => ["({$covNpc} reacts in character to the vampirism described above. If it happened to them: the new hunger, the light hurting their eyes, fear, anger or a dark thrill. If it happened to someone else: their honest reaction to that person now being a vampire. One or two short lines.) {$covTail}"],
];
