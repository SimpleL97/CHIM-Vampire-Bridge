<?php

/**
 * CHIM Vampire Bridge by SaurOff - runs before CHIM logs a request or takes its lock.
 *
 *   cov_state   silent bookkeeping from COV_Events (config, vampires, lords, court,
 *               thralls, released, fed): stored and answered here, never reaches the
 *               history or the LLM.
 */

require_once(__DIR__ . DIRECTORY_SEPARATOR . "cov_lib.php");

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
