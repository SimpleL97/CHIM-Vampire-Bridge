<?php

/**
 * CHIM Vampire Bridge by SaurOff - runs before CHIM logs a request or takes its lock.
 *
 *   funcret     a refused action of this bridge becomes the event cov_refused, which the
 *               agent answers at once (successful ones stay as they are).
 *   cov_downed  spared enemies lie beaten down: goes on as an instruction to the Vampire
 *               Lord the game sent it to (CHIM lets only instructions act, not events).
 *   cov_state   silent bookkeeping from COV_Events (config, vampires, lords, court,
 *               thralls, released, fed): stored and answered here, never reaches the
 *               history or the LLM.
 */

require_once(__DIR__ . DIRECTORY_SEPARATOR . "cov_lib.php");

// a refused action of this bridge: answered at once, as the event cov_refused (cov_lib.php)
if (isset($gameRequest) && is_array($gameRequest) && strval($gameRequest[0] ?? "") === "funcret") {
    try {
        $covRefusal = covRefusalEvent(strval($gameRequest[3] ?? ""));
        if ($covRefusal !== null) {
            $gameRequest[0] = "cov_refused";
            $gameRequest[3] = $covRefusal;
        }
    } catch (Throwable $e) {
        error_log("[cov_vampire_bridge] refusal: " . $e->getMessage());
    }
}

// spared enemies lie beaten down: the Vampire Lord who hears it may bind them, as an instruction
if (isset($gameRequest) && is_array($gameRequest) && strval($gameRequest[0] ?? "") === "cov_downed") {
    try {
        $gameRequest[3] = covDownedInstruction(implode("|", array_slice($gameRequest, 3)));
        $gameRequest[0] = "instruction";
    } catch (Throwable $e) {
        error_log("[cov_vampire_bridge] downed: " . $e->getMessage());
    }
}

if (isset($gameRequest) && is_array($gameRequest) && strval($gameRequest[0] ?? "") === "cov_state") {
    try {
        // CHIM splits every request on "|" (main.php: explode("|", ...)), and the state
        // lines use "|" themselves: glue everything after the third field back
        covApplyGameState(implode("|", array_slice($gameRequest, 3)), covNow());
    } catch (Throwable $e) {
        error_log("[cov_vampire_bridge] preprocessing: " . $e->getMessage());
    }
    terminate();
}
