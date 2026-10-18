<?php

/**
 * CHIM Vampire Bridge by SaurOff - actions.
 *
 * The LLM-facing action definitions live in CHIM's core_action_custom table, so they can
 * be toggled in the CHIM UI like any other action. This file installs or updates them
 * once per definition change, rewrites outgoing parameters into the shape the game
 * script expects, and shapes the follow-up prompt after the game reports back.
 *
 * Until its 1.2 CHIM OStim Bridge had these actions (ExtCmdCOB_Feed and so on) under the
 * same names; an old row of that kind gives its name over to the action here.
 */

require_once(__DIR__ . DIRECTORY_SEPARATOR . "cov_lib.php");

$GLOBALS["COV_ACTIONS"] = [
    "ExtCmdCOV_Feed" => [
        "name" => "Feed_On_Blood",
        "return" => "#HERIKA_NAME# drinks blood.",
        "params" => ["target" => "Who to drink from. Empty = #PLAYER_NAME#."],
        "description" => "ONLY if you are a vampire: bite someone who is here and drink their blood. Leave target empty to drink from #PLAYER_NAME# (when they allow it), or give the exact name of another person present. Use it when your thirst for blood is strong, or when #PLAYER_NAME# offers their neck. Not in combat. Call the action instead of only describing the bite.",
    ],
    "ExtCmdCOV_VampireLord" => [
        "name" => "Turn_Into_Vampire_Lord",
        "return" => "#HERIKA_NAME# gives #PLAYER_NAME# their blood.",
        "params" => ["target" => "leave empty"],
        "description" => "ONLY if you are a Vampire Lord: give #PLAYER_NAME# your blood and turn them into a Vampire Lord right now, the way the Vampire Lords of Dawnguard do. Only when #PLAYER_NAME# asks for it or clearly accepts your offer - never on your own. Not in combat. Call the action instead of only describing it.",
    ],
    "ExtCmdCOV_Enthrall" => [
        "name" => "Enthrall",
        "return" => "#HERIKA_NAME# bites someone and binds their will.",
        "params" => ["target" => "Exact name of the one to enthrall (who is here)."],
        "description" => "ONLY if you are a Vampire Lord, or the THRALLS notes say you can enthrall: bite someone who is here and bind their will - they become your thrall and #PLAYER_NAME#'s, and obey you both in everything. Works on mortals and on ordinary vampires, never on a Vampire Lord or Volkihar noble. "
            . "When #PLAYER_NAME# asks you to make someone your (or their) thrall, or when your own character would do it and #PLAYER_NAME# agrees. Enemies too, even in the middle of a fight: the bite ends their hostility. A Vampire Lord can also raise a dead person this way: Enthrall on the body brings them back to life as a thrall. Call the action instead of only describing it.",
    ],
    "ExtCmdCOV_Spare" => [
        "name" => "Spare",
        "return" => "#HERIKA_NAME# makes sure someone is taken alive.",
        "params" => ["target" => "Exact name of the one to keep alive, or \"women\" / \"men\" / \"everyone\" for every hostile woman / man / enemy - now and in the next fights; add \", thralls\" (\"women, thralls\") when #PLAYER_NAME# wants them made thralls; \"nobody\" ends that order."],
        "description" => "Keep enemies alive in a fight: companions only beat them down instead of killing them (only #PLAYER_NAME# could still kill them). When #PLAYER_NAME# says not to kill someone - \"do not kill the women\", \"take them alive\" - to make them thralls, to question them, or simply to spare them; "
            . "also when the order is given to all companions. \"women\" / \"men\" / \"everyone\" stays in force for the next fights until \"nobody\". "
            . "A Vampire Lord or Volkihar noble can then bind the ones lying beaten down with Enthrall.",
    ],
    "ExtCmdCOV_Release" => [
        "name" => "Release_Thrall",
        "return" => "#HERIKA_NAME# releases a thrall.",
        "params" => ["target" => "Exact name of the thrall to set free."],
        "description" => "Set a thrall free: their will is their own again. When #PLAYER_NAME# asks you to release them, or you as their master decide to. "
            . "Telling the thrall \"you are free\" does nothing in the game - only this action frees them, so call it in the reply where you let them go, with their name in target.",
    ],
];

foreach ($GLOBALS["COV_ACTIONS"] as $code => $def) {
    $GLOBALS["F_NAMES"][$code] = $def["name"];
}

// ---------------------------------------------------------------- install / update

(function () {
    $db = $GLOBALS["db"] ?? null;
    if (!$db) {
        return;
    }
    try {
        // version + fingerprint of the definitions above: any change to an action's name,
        // description or parameters is written to CHIM's table, not only a version bump
        $stamp = COV_VERSION . "-" . md5(json_encode($GLOBALS["COV_ACTIONS"]));
        $mark = $db->fetchOne("SELECT value FROM conf_opts WHERE id = 'cov_vampire_bridge_installed'");
        if (!empty($mark) && strval($mark["value"] ?? "") === $stamp) {
            return;
        }
        foreach ($GLOBALS["COV_ACTIONS"] as $code => $def) {
            $props = [];
            foreach ($def["params"] as $p => $desc) {
                $props[$p] = ["type" => "string", "description" => $desc];
            }
            $params = json_encode(["type" => "object", "required" => [], "properties" => $props], JSON_UNESCAPED_SLASHES);
            $row = $db->fetchOne("SELECT id FROM core_action_custom WHERE code_name = $1", [$code]);
            if (!empty($row)) {
                $db->fetchOne(
                    "UPDATE core_action_custom SET action_name = $2, description = $3, return_message = $4, parameters_json = $5::jsonb, updated_at = now() WHERE code_name = $1 RETURNING id",
                    [$code, $def["name"], $def["description"], $def["return"], $params]
                );
                continue;
            }
            $clash = $db->fetchOne("SELECT code_name FROM core_action_custom WHERE action_name = $1", [$def["name"]]);
            if (!empty($clash) && strpos(strval($clash["code_name"]), "ExtCmdCOB_") === 0) {
                // the same action as it was in CHIM OStim Bridge 1.x: it lives here now
                $db->fetchOne("DELETE FROM core_action_custom WHERE code_name = $1 RETURNING 1", [$clash["code_name"]]);
                covLog("took over the action {$def['name']} from {$clash['code_name']}");
                $clash = null;
            }
            if (!empty($clash)) {
                error_log("[cov_vampire_bridge] action name {$def['name']} is already used by {$clash['code_name']}; not installing {$code}");
                covLog("action name {$def['name']} is already used by {$clash['code_name']}; not installed");
                continue;
            }
            $db->fetchOne(
                "INSERT INTO core_action_custom (code_name, action_name, description, return_message, available_to_npc, available_to_followers, available_to_narrator, is_activated, parameters_json, metadata, game_function, import_version, script_proxy_program, created_at, updated_at)"
                . " VALUES ($1, $2, $3, $4, true, true, false, true, $5::jsonb, '{}'::jsonb, true, 0, '{}'::jsonb, now(), now()) RETURNING id",
                [$code, $def["name"], $def["description"], $def["return"], $params]
            );
        }
        $db->upsertRowOnConflict("conf_opts", ["id" => "cov_vampire_bridge_installed", "value" => $stamp], "id");
        error_log("[cov_vampire_bridge] actions installed/updated for " . $stamp);
        covLog("actions installed/updated for " . $stamp);
    } catch (Throwable $e) {
        error_log("[cov_vampire_bridge] install: " . $e->getMessage());
        covLog("install failed: " . $e->getMessage());
    }
})();

// ---------------------------------------------------------------- outgoing parameters

/**
 * CHIM sends "<npc>|command|<Action_Name>@<parameter>" to the game, but the Papyrus side
 * needs to know which agent asked: it gets "<agent>~<target>" ("-" for an empty target:
 * CHIM's command queue crashes on a parameter that ends with an empty field).
 */
$GLOBALS["action_post_process_fnct_ex"][] = function ($actions) {
    if (!is_array($actions)) {
        return $actions;
    }
    foreach ($actions as $n => $action) {
        try {
            $parts = explode("|", strval($action));
            if (count($parts) < 3) {
                continue;
            }
            $call = explode("@", $parts[2], 2);
            $actionName = $call[0];
            $codeName = function_exists('getFunctionCodeName') ? getFunctionCodeName($actionName) : false;
            if ($codeName === false || trim(strval($codeName)) === '') {
                $codeName = $actionName;
            }
            if (!isset($GLOBALS["COV_ACTIONS"][$codeName])) {
                continue;
            }
            $actorName = trim($parts[0]);
            $parameter = isset($call[1]) ? trim($call[1]) : "";
            if ($parameter !== "" && $parameter[0] === "{" && function_exists('decodeFunctionExecutionParameterPayload')) {
                $payload = decodeFunctionExecutionParameterPayload($parameter);
                if (is_array($payload)) {
                    $parameter = trim(strval($payload["target"] ?? ""));
                }
            }
            // "~" separates the fields on the Papyrus side; "|" separates the action line itself
            $parameter = trim(str_replace(["~", "|"], " ", $parameter));
            $parts[2] = $actionName . "@" . $actorName . "~" . ($parameter === "" ? "-" : $parameter);
            $actions[$n] = implode("|", $parts);
            covLog("action {$codeName} by {$actorName}: " . ($parameter === "" ? "-" : $parameter));
        } catch (Throwable $e) {
            error_log("[cov_vampire_bridge] post_process: " . $e->getMessage());
        }
    }
    return $actions;
};

// ---------------------------------------------------------------- after the game reports back

$covFuncret = function ($gameRequest) {
    // data: "command@<CodeName>@<parameter>@<result sentence>"
    $data = is_array($gameRequest) ? strval($gameRequest[3] ?? "") : "";
    $herika = $GLOBALS["HERIKA_NAME"] ?? "";
    $GLOBALS["FORCE_MAX_TOKENS"] = 120;
    covLog("result " . mb_substr($data, 0, 300));

    $refused = (stripos($data, "refuses") !== false) || (stripos($data, "cannot") !== false) || (stripos($data, "nothing to ") !== false);
    if ($refused) {
        $reason = $data;
        $cut = strrpos($data, "@");
        if ($cut !== false) {
            $reason = trim(substr($data, $cut + 1));
        }
        return [
            "argName" => "target",
            "request" => "{$herika} wanted this but it did not happen: {$reason}. Say one short line in character about it and drop the subject. Do not try the same action again this turn.",
        ];
    }
    return ["argName" => "target"];
};
foreach (array_keys($GLOBALS["COV_ACTIONS"]) as $code) {
    $GLOBALS["FUNCRET"][$code] = $covFuncret;
}
