<?php

/**
 * CHIM Vampire Bridge by SaurOff - how agents react to the events the game sends.
 * Loaded inside a function: use $GLOBALS.
 */

require_once(__DIR__ . DIRECTORY_SEPARATOR . "cov_lib.php");

$covNpc  = $GLOBALS["HERIKA_NAME"] ?? "";
$covTail = $GLOBALS["TEMPLATE_DIALOG"] ?? "";

$GLOBALS["PROMPTS"]["cov_thrall"] = [
    "cue" => ["({$covNpc} reacts in character to what just happened to the thrall described above. If {$covNpc} is the one who was bound: a dazed, devoted first line to their new masters. If {$covNpc} was released: confusion, relief or anger. Anyone else: their honest reaction - awe, unease, amusement or desire. One or two short lines.) {$covTail}"],
];
$GLOBALS["PROMPTS"]["cov_vampire_turned"] = [
    "cue" => ["({$covNpc} reacts in character to the vampirism described above. If it happened to them: the new hunger, the light hurting their eyes, fear, anger or a dark thrill. If it happened to someone else: their honest reaction to that person now being a vampire. One or two short lines.) {$covTail}"],
];
$GLOBALS["PROMPTS"]["cov_refused"] = [
    "cue" => ["({$covNpc} wanted to do what is described above, but it did not happen in the game, for the reason given. {$covNpc} says one short line in character about it - surprise, annoyance, a joke, or what to do instead - and does not try the same action again now. The reason is for {$covNpc} to understand, not to quote: speak only in-world, never mention the game, mods, ORomance, stats or numbers.) {$covTail}"],
];

// the player's turn: an order not to kill some enemies becomes the action Spare (cov_lib.php)
try {
    $covCue = covSpareCue();
    if ($covCue !== "") {
        foreach (["inputtext", "inputtext_s", "ginputtext", "ginputtext_s"] as $covType) {
            if (isset($GLOBALS["PROMPTS"][$covType]["cue"]) && is_array($GLOBALS["PROMPTS"][$covType]["cue"])) {
                foreach ($GLOBALS["PROMPTS"][$covType]["cue"] as $covI => $covText) {
                    // prompts.php can be loaded more than once in a request
                    if (is_string($covText) && strpos($covText, $covCue) === false) {
                        $GLOBALS["PROMPTS"][$covType]["cue"][$covI] = $covText . " " . $covCue;
                    }
                }
            }
        }
    }
} catch (Throwable $e) {
    error_log("[cov_vampire_bridge] spare cue: " . $e->getMessage());
}
