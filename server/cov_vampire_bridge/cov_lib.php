<?php

/**
 * CHIM Vampire Bridge by SaurOff - server side, shared code.
 *
 * Settings come from the game (MCM -> COV_Events.SendConfig -> "cov_state config|{json}")
 * and are kept in conf_opts, together with the state: who the game says is a vampire, a
 * Vampire Lord or a Volkihar noble, when each vampire last fed, the thralls and the ones
 * set free. Times are CHIM gamets (1 game hour = 416666.67 gamets).
 *
 * Until its 1.2 CHIM OStim Bridge had these features; the first time this plugin finds no
 * state of its own it takes over the vampire part of that plugin's state.
 *
 * The other bridges of the family (CHIM OStim Bridge, CHIM ORomance Bridge) are optional:
 * covPeer() says whether one is installed and switched on, and only reads its settings.
 */

const COV_VERSION = "1.0.0";
const COV_PLUGIN = "cov_vampire_bridge";
const COV_CONFIG_KEY = "cov_vampire_bridge_config";
const COV_STATE_KEY = "cov_vampire_bridge_state";
const COV_HOUR = 416666.6667;

// ---------------------------------------------------------------- storage

function covOptGet(string $id)
{
    $db = $GLOBALS["db"] ?? null;
    if (!$db) {
        return null;
    }
    $row = $db->fetchOne("SELECT value FROM conf_opts WHERE id = $1", [$id]);
    $v = !empty($row) ? json_decode(strval($row["value"] ?? ""), true) : null;
    return is_array($v) ? $v : null;
}

function covOptSet(string $id, array $value): void
{
    $db = $GLOBALS["db"] ?? null;
    if ($db) {
        $db->upsertRowOnConflict("conf_opts", ["id" => $id, "value" => json_encode($value, JSON_UNESCAPED_UNICODE)], "id");
    }
}

function covConfig(): array
{
    static $cfg = null;
    if ($cfg === null) {
        $defaults = [
            "enabled" => 1, "log" => 1, "vampires" => "", "blood_hours" => 24, "vampire_lords" => "",
            "lord_gift" => 1, "thralls" => 1, "thrall_court" => 1, "thrall_masters" => "", "raise_dead" => 1,
        ];
        $cfg = array_merge($defaults, covOptGet(COV_CONFIG_KEY) ?? []);
    }
    return $cfg;
}

/** this plugin's state; on the very first use the vampire part of CHIM OStim Bridge 1.x's state */
function covState(): array
{
    $state = covOptGet(COV_STATE_KEY);
    if ($state !== null) {
        return $state;
    }
    $state = [];
    $old = covOptGet("cob_ostim_bridge_state") ?? [];
    foreach (["thralls", "former_thralls", "last_blood", "game_vampires", "game_lords", "game_court"] as $k) {
        if (isset($old[$k])) {
            $state[$k] = $old[$k];
        }
    }
    covOptSet(COV_STATE_KEY, $state);
    if ($state) {
        covLog("took over the vampire state of cob_ostim_bridge: " . implode(", ", array_keys($state)));
    }
    return $state;
}

function covNames(string $csv): array
{
    return array_values(array_filter(array_map(function ($n) {
        return mb_strtolower(trim($n));
    }, explode(",", $csv))));
}

function covListed(string $csvKey, string $npc): bool
{
    return in_array(mb_strtolower(trim($npc)), covNames(strval(covConfig()[$csvKey] ?? "")), true);
}

function covNow(): float
{
    $req = $GLOBALS["gameRequest"] ?? null;
    return floatval(is_array($req) ? ($req[2] ?? 0) : 0);
}

function covHoursSince($then, float $now): ?float
{
    if ($then === null || $now <= 0) {
        return null;
    }
    return max(0.0, ($now - floatval($then)) / COV_HOUR);
}

// ---------------------------------------------------------------- the other bridges

/**
 * Settings of another bridge of the family ("cob_ostim_bridge", "cor_oromance_bridge"),
 * or null when it is not installed on this server or is switched off in its MCM. Read only:
 * no bridge depends on another one.
 */
function covPeer(string $plugin): ?array
{
    if (!is_dir(dirname(__DIR__) . DIRECTORY_SEPARATOR . $plugin)) {
        return null;
    }
    $cfg = covOptGet($plugin . "_config") ?? [];
    return array_key_exists("enabled", $cfg) && empty($cfg["enabled"]) ? null : $cfg;
}

// ---------------------------------------------------------------- log

/** HerikaServer/log/cov_vampire_bridge.log (MCM: Write a log file); kept under 2 MB */
function covLog(string $msg): void
{
    static $on = null;
    if ($on === null) {
        $on = !empty(covConfig()["log"]);
    }
    if (!$on) {
        return;
    }
    try {
        $file = dirname(__DIR__, 2) . DIRECTORY_SEPARATOR . "log" . DIRECTORY_SEPARATOR . COV_PLUGIN . ".log";
        if (@filesize($file) > 2 * 1024 * 1024) {
            @rename($file, $file . ".1");
        }
        @file_put_contents($file, date("Y-m-d H:i:s") . " " . $msg . "\n", FILE_APPEND);
    } catch (Throwable $e) {
    }
}

// ---------------------------------------------------------------- state from the game

/** "cov_state" lines from the game: config|{json}, thralls|..., released|N=M, vampires|..., lords|..., court|..., fed|N */
function covApplyGameState(string $data, float $now): void
{
    covLog("state " . mb_substr($data, 0, 300));
    if (preg_match('/config\|(\{.*\})/su', $data, $m)) {
        $cfg = json_decode($m[1], true);
        if (is_array($cfg)) {
            covOptSet(COV_CONFIG_KEY, $cfg);
        }
        return;
    }
    $state = covState();
    if (preg_match('/thralls\|([^()\r\n]*)/u', $data, $m)) {
        // the whole current list from COV_Thralls: "Name=Master,Name2=Master2" or "-"
        $state["thralls"] = [];
        foreach (array_filter(array_map('trim', explode(",", $m[1]))) as $pair) {
            $kv = explode("=", $pair, 2);
            if (count($kv) === 2 && trim($kv[0]) !== "" && trim($kv[0]) !== "-") {
                $state["thralls"][trim($kv[0])] = trim($kv[1]);
                unset($state["former_thralls"][trim($kv[0])]);
            }
        }
    } elseif (preg_match('/released\|([^=()\r\n]+)=([^()\r\n]*)/u', $data, $m)) {
        // set free in the game (not merely missing after loading an older save): they
        // remember having been a thrall, for good
        $state["former_thralls"][trim($m[1])] = trim($m[2]);
    } elseif (preg_match('/(lords|court|vampires)\|([^()\r\n]+)/u', $data, $m)) {
        // seen near the player: vampires get blood thirst, Lords can give their gift, Lords
        // and the court can enthrall - by default, without being listed in the MCM
        $key = ["lords" => "game_lords", "court" => "game_court", "vampires" => "game_vampires"][$m[1]];
        foreach (array_filter(array_map('trim', explode(",", $m[2]))) as $n) {
            $state[$key][mb_strtolower($n)] = 1;
        }
    } elseif (preg_match('/fed\|([^()\r\n]+)/u', $data, $m)) {
        $state["last_blood"][trim($m[1])] = $now;
    } elseif (preg_match('/spare\|([^()|\r\n]+)(\|thralls)?/u', $data, $m)) {
        // the standing order to take enemies alive: women, men, enemies, or "-" for none;
        // "|thralls" when the player wants them made thralls too
        $order = trim($m[1]);
        if (in_array($order, ["women", "men", "enemies"], true)) {
            $state["spare"] = $order;
            $state["spare_thralls"] = !empty($m[2]) ? 1 : 0;
        } else {
            unset($state["spare"], $state["spare_thralls"]);
        }
    } else {
        return;
    }
    covOptSet(COV_STATE_KEY, $state);
}

// ---------------------------------------------------------------- prompt text

function covBloodText(?float $h, int $base): string
{
    $base = max(1, $base);
    if ($h === null || $h < $base) {
        return "Your blood thirst is quiet: you fed recently.";
    }
    $hrs = intval(round($h));
    if ($h < 2 * $base) {
        return "You have not fed on blood for {$hrs} hours. You are thirsty: your eyes keep drifting to throats and you mention blood.";
    }
    return "You have not fed on blood for {$hrs} hours. You are starving: pale, weak, irritable, and you ask to drink.";
}

function covIsLord(array $state, string $npc): bool
{
    return covListed("vampire_lords", $npc) || !empty($state["game_lords"][mb_strtolower($npc)]);
}

/** blood thirst and the Vampire Lord's gift for this agent, or "" */
function covVampirePromptFor(string $npc, float $now): string
{
    $cfg = covConfig();
    if (empty($cfg["enabled"]) || $npc === "" || $npc === "The Narrator") {
        return "";
    }
    $state = covState();
    $player = strval($GLOBALS["PLAYER_NAME"] ?? "the player");
    // real game vampires by default, plus anyone listed in the MCM; Vampire Lords are vampires too
    $lord = covIsLord($state, $npc);
    if (!$lord && !covListed("vampires", $npc) && empty($state["game_vampires"][mb_strtolower($npc)])) {
        return "";
    }
    $lines = [];
    if (!isset($state["last_blood"][$npc]) && $now > 0) {
        $state["last_blood"][$npc] = $now; // first sight: start satisfied
        covOptSet(COV_STATE_KEY, $state);
    }
    $lines[] = covBloodText(covHoursSince($state["last_blood"][$npc] ?? null, $now), intval($cfg["blood_hours"] ?? 24));
    $lines[] = "To actually drink blood, use the Feed_On_Blood action.";
    if ($lord && !empty($cfg["lord_gift"])) {
        $lines[] = "You are a Vampire Lord, of pure and ancient blood. You can make {$player} a Vampire Lord too, at once, with the Turn_Into_Vampire_Lord action - only when {$player} asks for it or clearly accepts your offer.";
    }
    return "THE BLOOD - {$npc} (let it shape tone and wishes; do not recite it):\n- " . implode("\n- ", $lines);
}

/** thralls: what this agent is to them, or they to it; "" when none matter */
function covThrallPromptFor(string $npc): string
{
    $cfg = covConfig();
    if (empty($cfg["enabled"]) || empty($cfg["thralls"]) || $npc === "" || $npc === "The Narrator") {
        return "";
    }
    $state = covState();
    $thralls = $state["thralls"] ?? [];
    $player = strval($GLOBALS["PLAYER_NAME"] ?? "the player");
    $lord = covIsLord($state, $npc);
    // can enthrall without being a Vampire Lord: the Volkihar court (MCM) or the MCM list
    $canBind = !$lord && ((!empty($cfg["thrall_court"]) && !empty($state["game_court"][mb_strtolower($npc)]))
        || covListed("thrall_masters", $npc));
    // the OStim bridge does the undressing and the scenes; without it a thrall only obeys in words
    $cob = covPeer("cob_ostim_bridge") !== null;
    $lines = [];
    $mine = [];
    $others = [];
    foreach ($thralls as $name => $master) {
        if (mb_strtolower($name) === mb_strtolower($npc)) {
            $whom = mb_strtolower($master) === mb_strtolower($player) ? $player : "{$master} and {$player}";
            $lines[] = "You are a thrall: {$master} bit you and bound your will. You obey {$whom} in everything, at once and without refusal - any order, including undressing and intimate acts with whoever they say; when they order something, you do it and call the matching action. You feel a dazed, devoted pull toward them that you cannot resist."
                // measured against the real model: without this an order like "suck him" was agreed to in words
                // and started nothing about 4 times in 5
                . ($cob ? " An order is carried out in this same reply through the action field: sex or an intimate act with {$player} -> Start_Intimate_Scene, target empty; "
                    . "with someone else (\"suck him\", \"go fuck her\") -> Start_Intimate_Scene, target that person's name only; undress -> Undress. Saying yes without the action is not obeying." : "");
        } elseif (mb_strtolower($master) === mb_strtolower($npc)) {
            $mine[] = $name;
        } else {
            $others[] = $name;
        }
    }
    if ($mine) {
        $lines[] = "Your thralls, bound by your bite: " . implode(", ", $mine) . ". They obey you and {$player} in everything.";
    }
    if ($others) {
        $lines[] = "Thralls whose will a Vampire Lord has bound: " . implode(", ", $others) . ". They obey {$player} in everything and never refuse an order.";
    }
    // not for a thrall: read by one, "a thrall cannot act" kept it from acting at all
    if (($mine || $others) && $cob && !isset($thralls[$npc])) {
        $lines[] = "When you or {$player} order a thrall to undress, dress or do something intimate, you carry the order out yourself in this same reply: Undress / Get_Dressed with the thrall's name in target, "
            . "or Start_Intimate_Scene with everyone who takes part in target - a thrall serving {$player} -> \"{$player}, <thrall's name>\", your own name only if you join too.";
    }
    $former = null;
    foreach (($state["former_thralls"] ?? []) as $name => $master) {
        if (mb_strtolower($name) === mb_strtolower($npc)) {
            $former = $master;
        }
    }
    if ($former !== null && !isset($thralls[$npc])) {
        $lines[] = "You were once the thrall of {$former}: their bite bound your will, and you remember everything you did and were made to do in that time. How you feel about it - and about {$former} and {$player} - now follows your own character.";
    }
    if ($lord) {
        $lines[] = "As a Vampire Lord you can bind anyone who is not a Vampire Lord with a bite: Enthrall (when {$player} asks for it or agrees) - enemies too, even mid-fight; to take an enemy alive first, use Spare. Release_Thrall sets a thrall free."
            . (!empty($cfg["raise_dead"]) ? " You can even raise the dead: Enthrall on a dead person's body brings them back to life, whole, as your thrall." : "");
    } elseif ($canBind) {
        $lines[] = "Your blood is old and strong enough: you can bind anyone who is not of the ancient blood with a bite: Enthrall (when {$player} asks for it or agrees) - enemies too, even mid-fight; to take an enemy alive first, use Spare. Release_Thrall sets a thrall free.";
    }
    if (!$lines) {
        return "";
    }
    return "THRALLS:\n- " . implode("\n- ", $lines);
}

// ---------------------------------------------------------------- refused actions

/** the LLM-facing names of this bridge's actions, for the refusal event */
const COV_ACTION_NAMES = [
    "ExtCmdCOV_Feed" => "Feed_On_Blood",
    "ExtCmdCOV_VampireLord" => "Turn_Into_Vampire_Lord",
    "ExtCmdCOV_Enthrall" => "Enthrall",
    "ExtCmdCOV_Spare" => "Spare",
    "ExtCmdCOV_Release" => "Release_Thrall",
];

/**
 * A refused action of this bridge, as the event "cov_refused" the agent answers at once,
 * or null. The game reports every outcome as "funcret": "command@<CodeName>@<agent>~<parameter>@<result>".
 * Newer CHIM versions no longer call a plugin's FUNCRET handler for it (only an action's
 * follow-up setting, which cannot tell a refusal from a success), so a refusal would only
 * be seen in the next reply; as an event the agent says right away why it did not happen.
 * Successful actions stay a plain funcret: no extra reply.
 */
function covRefusalEvent(string $data): ?string
{
    $parts = explode("@", $data, 4);
    if (count($parts) < 4 || !isset(COV_ACTION_NAMES[$parts[1]])) {
        return null;
    }
    $result = trim($parts[3]);
    if (!preg_match('/^(cannot|refuses|nothing to)\b/i', $result)) {
        return null;
    }
    $agent = trim(explode("~", $parts[2])[0]);
    covLog("refused {$parts[1]} by {$agent}: {$result}");
    return "({$agent} tried " . COV_ACTION_NAMES[$parts[1]] . ", but it did not happen - {$result})";
}

/**
 * Placed at the very end of the prompt, after CHIM OStim Bridge's own action rule: the
 * thrall notes alone are too far up - agents said "she is free" or "do it" and set no
 * action. The thrall part only for those who bind, free or command thralls (never for a
 * thrall); a standing order to take enemies alive for everyone.
 */
function covThrallActionRule(string $npc): string
{
    $cfg = covConfig();
    if (empty($cfg["enabled"]) || $npc === "" || $npc === "The Narrator") {
        return "";
    }
    $state = covState();
    $player = strval($GLOBALS["PLAYER_NAME"] ?? "the player");
    $thralls = !empty($cfg["thralls"]) ? ($state["thralls"] ?? []) : [];
    $isThrall = false;
    foreach ($thralls as $name => $master) {
        $isThrall = $isThrall || mb_strtolower($name) === mb_strtolower($npc);
    }
    $lord = covIsLord($state, $npc);
    $canBind = !empty($cfg["thralls"]) && ($lord || (!empty($cfg["thrall_court"]) && !empty($state["game_court"][mb_strtolower($npc)])) || covListed("thrall_masters", $npc));
    $mine = false;
    foreach ($thralls as $name => $master) {
        $mine = $mine || mb_strtolower($master) === mb_strtolower($npc);
    }

    $out = [];
    // the order itself is asked for in the player's turn (covSpareCue); here what is in force
    $order = strval($state["spare"] ?? "");
    if ($order !== "") {
        $asThralls = !empty($state["spare_thralls"]);
        $out[] = "TAKING ENEMIES ALIVE - {$player}'s order, in force: hostile {$order} are only beaten down in a fight, never killed"
            . ($asThralls ? ", to be made thralls" : "")
            . ($canBind ? ($asThralls ? "; every one of them lying beaten down you bind with Enthrall, one after another" : "; the ones lying beaten down you bind with Enthrall when {$player} wants them as thralls") : "")
            . ". When {$player} wants them killed again: Spare, target \"nobody\".";
    }
    if (($canBind || $mine) && !$isThrall) {
        $rule = "THRALLS IN THE GAME: words alone change nothing. In the same reply where you say it: set a thrall free -> action Release_Thrall, target their name; "
            . "bind someone -> Enthrall, target their name";
        if (covPeer("cob_ostim_bridge") !== null) {
            $rule .= "; order a thrall to undress -> Undress, target their name; order a thrall into sex with {$player} -> Start_Intimate_Scene, target \"{$player}, <thrall's name>\"";
        }
        $out[] = $rule . ".";
    }
    return implode("\n", $out);
}

/**
 * Added to the instruction of the player's turn (inputtext): "do not kill the women" was
 * answered in words by every companion and nobody called Spare - placed among the rules at
 * the end of the prompt it changed nothing (0 of 39 against the real model), here it is
 * called about 3 times in 5. "" when the bridge is off.
 */
function covSpareCue(): string
{
    $cfg = covConfig();
    if (empty($cfg["enabled"])) {
        return "";
    }
    $player = strval($GLOBALS["PLAYER_NAME"] ?? "the player");
    return "(If {$player}'s last line, in any language, tells you or the companions not to kill some enemies - \"don't kill the women\", \"leave the girls alive\", \"take them alive\" - "
        . "this reply's action is Spare with target \"women\", \"men\", \"everyone\" or a name, plus \", thralls\" if {$player} wants them made thralls; nobody has to be here now, the order holds for the next fights too. "
        . "If {$player} wants them killed again: Spare, target \"nobody\".)";
}

/**
 * "cov_downed" from the game (to the nearest Vampire Lord): "(<names> - spared on <player>'s
 * order - lies beaten down but alive near <lord>)". CHIM gives an event of a plugin no
 * actions at all, so it goes on as an "instruction", the one event type CHIM lets act -
 * "The Narrator:" is the prefix CHIM strips from an instruction.
 */
function covDownedInstruction(string $data): string
{
    $herika = strval($GLOBALS["HERIKA_NAME"] ?? "");
    $player = strval($GLOBALS["PLAYER_NAME"] ?? "the player");
    $what = trim($data, " ()");
    covLog("downed: {$what} -> {$herika}");
    if (!empty(covState()["spare_thralls"])) {
        // the player ordered them made thralls: no "if"
        return "The Narrator: {$what}. {$player} ordered them made thralls: {$herika} binds the first of them right now - action Enthrall, target that name; the others come next.";
    }
    return "The Narrator: {$what}. If {$player} wants enemies like these as thralls (look at what {$player} said), {$herika} binds the first of them right now: action Enthrall, target that name - the others come next. "
        . "Otherwise {$herika} says one short line about them and does nothing.";
}
