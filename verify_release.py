"""CHIM Vampire Bridge - checks that the Nexus zip holds everything that is live.

python3 -I verify_release.py <zip> [<live server ext dir>] [<game Data dir>]
Compares the zip with build outputs, sources, the live CHIM server plugin and
the deployed game files, and fails if a compiled script is older than its source.
"""
import io, os, sys, zipfile

ROOT = os.path.dirname(os.path.abspath(__file__))
SCRIPTS = ["COV", "COV_Config", "COV_Bridge", "COV_Events", "COV_MCM", "COV_Thralls", "COV_EnthrallEffect"]
zpath = sys.argv[1]
live = sys.argv[2] if len(sys.argv) > 2 else None
data = sys.argv[3] if len(sys.argv) > 3 else None
z = zipfile.ZipFile(zpath)
names = set(z.namelist())
problems = []

def check(label, ok):
    print(f"  {'OK ' if ok else 'BAD'} {label}")
    if not ok:
        problems.append(label)

def read(p):
    return open(p, "rb").read()

print("game files vs build:")
check("CHIMVampireBridge.esp", z.read("00 Core/CHIMVampireBridge.esp") == read(os.path.join(ROOT, "build", "CHIMVampireBridge.esp")))
for s in SCRIPTS:
    pex = os.path.join(ROOT, "build", "Scripts", s + ".pex")
    psc = os.path.join(ROOT, "src", "Scripts", "Source", s + ".psc")
    check(f"{s}.pex newer than its .psc", os.path.getmtime(pex) >= os.path.getmtime(psc))
    check(f"{s}.pex in zip = build", z.read(f"00 Core/Scripts/{s}.pex") == read(pex))
    check(f"{s}.psc in zip = source", z.read(f"20 Source/Source/Scripts/{s}.psc") == read(psc))
for f in ["info.xml", "ModuleConfig.xml", "images/banner.jpg"]:
    check(f"fomod/{f}", z.read(f"fomod/{f}") == read(os.path.join(ROOT, "fomod", f)))
for f in ["config.json", "settings.ini"]:
    check(f"MCM {f}", z.read(f"00 Core/MCM/Config/CHIMVampireBridge/{f}") == read(os.path.join(ROOT, "mcm", f)))

# MCM translations: every $key the menu uses must exist in every language file,
# or players with that game language see raw $keys
import re
menu_keys = set(re.findall(r"\$COV_[A-Za-z]+", z.read("00 Core/MCM/Config/CHIMVampireBridge/config.json").decode("utf-8")))
check(f"menu uses $keys ({len(menu_keys)})", len(menu_keys) > 0)
tdir = os.path.join(ROOT, "mcm", "translations")
for f in sorted(os.listdir(tdir)):
    zipped = z.read(f"00 Core/Interface/Translations/{f}")
    check(f"{f} in zip = source", zipped == read(os.path.join(tdir, f)))
    have = {l.split("\t")[0] for l in zipped[2:].decode("utf-16-le").splitlines() if l}
    check(f"{f} has all {len(menu_keys)} menu keys", zipped[:2] == b"\xff\xfe" and menu_keys <= have)

pkgs = [n for n in names if n.startswith("00 Core/CHIM/server-plugins/cov_vampire_bridge/") and n.endswith(".dwpkg")]
check("exactly one server package", len(pkgs) == 1)
pkg = zipfile.ZipFile(io.BytesIO(z.read(pkgs[0])))
srcdir = os.path.join(ROOT, "server", "cov_vampire_bridge")
print("server package vs source" + (" and live server:" if live else ":"))
for f in sorted(os.listdir(srcdir)):
    body = pkg.read("server/" + f)
    check(f"{f} = source", body == read(os.path.join(srcdir, f)))
    check(f"{f} = tools copy", z.read(f"10 Server Tools/CHIM Vampire Bridge Server Tools/cov_vampire_bridge/{f}") == body)
    if live:
        check(f"{f} = live server", os.path.exists(os.path.join(live, f)) and read(os.path.join(live, f)) == body)
if live:
    extra = set(os.listdir(live)) - set(os.listdir(srcdir))
    check("no live server files missing from the package", not extra)

if data:
    print("deployed game files vs zip:")
    check("Data/CHIMVampireBridge.esp", read(os.path.join(data, "CHIMVampireBridge.esp")) == z.read("00 Core/CHIMVampireBridge.esp"))
    for s in SCRIPTS:
        p = os.path.join(data, "Scripts", s + ".pex")
        check(f"Data/Scripts/{s}.pex", os.path.exists(p) and read(p) == z.read(f"00 Core/Scripts/{s}.pex"))

print("RESULT:", "all good" if not problems else f"{len(problems)} problem(s)")
sys.exit(1 if problems else 0)
