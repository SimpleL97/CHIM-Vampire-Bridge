<?php

/**
 * CHIM Vampire Bridge by SaurOff - text added at the bottom of every prompt: a vampire's
 * blood thirst and a Vampire Lord's gift, and the thralls - what this agent is to them or
 * they to it. Loaded by main.php before the prompt_bottom slot is rendered.
 */

require_once(__DIR__ . DIRECTORY_SEPARATOR . "cov_lib.php");

if (function_exists('chimRegisterPromptInjection')) {
    chimRegisterPromptInjection("prompt_bottom", "cov_blood", function ($slot, $context) {
        try {
            return covVampirePromptFor(trim(strval($GLOBALS["HERIKA_NAME"] ?? "")), covNow());
        } catch (Throwable $e) {
            error_log("[cov_vampire_bridge] blood: " . $e->getMessage());
            return "";
        }
    }, 805);
    chimRegisterPromptInjection("prompt_bottom", "cov_thralls", function ($slot, $context) {
        try {
            return covThrallPromptFor(trim(strval($GLOBALS["HERIKA_NAME"] ?? "")));
        } catch (Throwable $e) {
            error_log("[cov_vampire_bridge] thralls: " . $e->getMessage());
            return "";
        }
    }, 820);
    chimRegisterPromptInjection("prompt_bottom", "cov_thrall_rule", function ($slot, $context) {
        try {
            return covThrallActionRule(trim(strval($GLOBALS["HERIKA_NAME"] ?? "")));
        } catch (Throwable $e) {
            return "";
        }
    }, 860);
}
