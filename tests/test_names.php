<?php
// Names in a target (cov_lib.php: covResolveTargets, covNameRetry), against a fake CHIM database.
// Run from the repository: php tests/test_names.php

class FakeDb
{
    public $opts = [];
    public $infonpc = "";
    public $close = "";
    function fetchOne($sql, $p = [])
    {
        if (strpos($sql, "FROM eventlog") !== false) {
            $d = ($p[0] ?? "") === "infonpc" ? $this->infonpc : $this->close;
            return $d === "" ? [] : ["data" => $d];
        }
        if (strpos($sql, "FROM conf_opts") !== false) {
            return isset($this->opts[$p[0]]) ? ["value" => $this->opts[$p[0]]] : [];
        }
        return [];
    }
    function upsertRowOnConflict($t, $row, $k)
    {
        $this->opts[$row["id"]] = $row["value"];
    }
}

$db = new FakeDb();
$db->infonpc = "(beings in range:Hilde the Lioness (far away),Ярл Torvald the Greater,Ulf [Стражник Вайтрана],Asta [RefID: FE07FE69],Gunnar [Bandit Defender] (dead),Freya,Valdimar (busy),Курица,Курица)";
$db->close = "Freya/Valdimar (busy)/Brenna//Aldric";
$GLOBALS["db"] = $db;
$GLOBALS["PLAYER_NAME"] = "Aldric";

require __DIR__ . "/../server/cov_vampire_bridge/cov_lib.php";

$fail = 0;
function check($label, $got, $want)
{
    global $fail;
    $ok = $got === $want;
    if (!$ok) {
        $fail++;
    }
    printf("%s %-46s %s\n", $ok ? "ok  " : "FAIL", $label, $ok ? $got : "got <$got> want <$want>");
}

// group words and tasks are no names; the names are placed like in CHIM OStim Bridge
foreach ([
    ["women, thralls", "women, thralls"],
    ["the dead women", "the dead women"],
    ["everyone", "everyone"],
    ["follow", "follow"],
    ["Gunnar", "Gunnar [Bandit Defender]"],
    ["TheNarrator", "player"],
    ["Hilde, Ulf", "Hilde the Lioness, Ulf [Стражник Вайтрана]"],
    ["Hilde", "Hilde the Lioness"],
    ["Aldric Varro", "player"],
    ["me", "Brenna"],
] as [$in, $want]) {
    check("COV <$in>", covResolveTargets($in, "Brenna", COV_NOT_A_NAME), $want);
}

// a name nobody here has: an instruction once, then the plain refusal
$d2 = "command@ExtCmdCOV_Feed@Brenna~Bob@cannot feed: nobody called Bob is here";
check("COV retry, first", covNameRetry($d2) !== null, true);
check("COV retry, second", covNameRetry($d2), null);
echo $fail === 0 ? "ALL PASS\n" : "$fail FAILED\n";
exit($fail ? 1 : 0);
