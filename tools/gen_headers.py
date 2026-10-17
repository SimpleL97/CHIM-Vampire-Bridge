"""CHIM Vampire Bridge - writes declaration-only Papyrus headers for the CI build.

    python3 -I tools/gen_headers.py <source dir> [<source dir> ...]

The source dirs are the game's Papyrus sources (Data/Scripts/Source, Data/Source/Scripts:
base game, SKSE, OStim Standalone, PapyrusUtil, CHIM), first one wins. Starting from
src/Scripts/Source it follows every script type the mod uses - and every type those
types mention in their declarations - and writes stubs/headers/<Type>.psc with only the
script line, properties, function and event signatures: no code, no comments. Types
already stubbed by hand (stubs/ and its other folders) are left to those.

The compiler needs these headers only to type-check the calls; they are never compiled
into the release (the game runs the real scripts of those mods). Re-run after the mod
starts using a type it did not use before; the CI build fails with "undefined" when a
header is missing.
"""
import os, re, sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC = os.path.join(ROOT, "src", "Scripts", "Source")
OUT = os.path.join(ROOT, "stubs", "headers")
# hand-written stubs: stubs/ and every folder in it but headers/
HAND = [os.path.join(ROOT, "stubs")] + sorted(
    os.path.join(ROOT, "stubs", d) for d in os.listdir(os.path.join(ROOT, "stubs"))
    if d != "headers" and os.path.isdir(os.path.join(ROOT, "stubs", d)))

IDENT = re.compile(r"[A-Za-z_][A-Za-z0-9_]*")
FUNC = re.compile(r"^(?:([\w\[\]]+)\s+)?(function|event)\s+(\w+)\s*\((.*)\)(.*)$", re.I)
PROP = re.compile(r"^([\w\[\]]+)\s+property\s+(\w+)(.*)$", re.I)
END = re.compile(r"^end(function|event|property|state)\b", re.I)


def read(path):
    for enc in ("utf-8", "cp1252"):
        try:
            return open(path, encoding=enc).read()
        except UnicodeDecodeError:
            pass
    return open(path, encoding="latin1").read()


def logical_lines(text):
    """code lines without comments, strings blanked, docstrings and continuations folded"""
    code, i, n = [], 0, len(text)
    while i < n:
        c = text[i]
        if c == '"':  # string literal, kept
            j = i + 1
            while j < n and text[j] not in '"\n':
                j += 2 if text[j] == "\\" else 1
            code.append(text[i:j + 1])
            i = j + 1
        elif text.startswith(";/", i):  # block comment
            j = text.find("/;", i + 2)
            j = n if j < 0 else j + 2
            code.append("\n" * text.count("\n", i, j))
            i = j
        elif c == ";":  # line comment
            j = text.find("\n", i)
            i = n if j < 0 else j
        elif c == "{":  # docstring
            j = text.find("}", i)
            j = n if j < 0 else j + 1
            code.append("\n" * text.count("\n", i, j))
            i = j
        else:
            code.append(c)
            i += 1
    out, buf = [], ""
    for line in "".join(code).splitlines():
        line = line.rstrip()
        if line.endswith("\\"):
            buf += line[:-1] + " "
            continue
        line = (buf + line).strip()
        buf = ""
        if line:
            out.append(line)
    return out


def strip_strings(line):
    return re.sub(r'"(?:[^"\\]|\\.)*"', '""', line)


def header(lines):
    """the declarations of a script: (header text, the identifiers those declarations use)"""
    out, used, depth = [], set(), 0
    for line in lines:
        low = line.lower()
        if low.startswith("scriptname "):
            out.append(line)
            used.update(IDENT.findall(line))
            continue
        if re.match(r"^state\s", low) or re.match(r"^auto\s+state\s", low):
            depth += 1  # functions inside states are not part of the type's interface
            continue
        if low.startswith("endstate"):
            depth -= 1
            continue
        if depth:
            continue
        m = FUNC.match(line)
        if m:
            ret, kind, name, args, flags = m.groups()
            flags_l = flags.lower()
            sig = ((ret + " ") if ret else "") + kind.capitalize() + " " + name + "(" + args.strip() + ")"
            for f in ("global", "native"):
                if re.search(r"\b" + f + r"\b", flags_l):
                    sig += " " + f.capitalize()
            used.update(IDENT.findall(strip_strings((ret or "") + " " + args)))
            out.append(sig)
            if "native" not in flags_l:
                out.append("End" + kind.capitalize())
            continue
        m = PROP.match(line)
        if m:
            typ, name, rest = m.groups()
            used.add(typ.replace("[]", ""))
            out.append(f"{typ} Property {name} Auto" + (" Hidden" if re.search(r"\bhidden\b", rest, re.I) else ""))
    return "\n".join(out) + "\n", used


def main(dirs):
    available = {}
    for d in dirs:
        for f in sorted(os.listdir(d)) if os.path.isdir(d) else []:
            if f.lower().endswith(".psc"):
                available.setdefault(f[:-4].lower(), os.path.join(d, f))
    own = {f[:-4].lower() for f in os.listdir(SRC) if f.lower().endswith(".psc")}
    hand = {f[:-4].lower() for d in HAND for f in os.listdir(d) if f.lower().endswith(".psc")}

    wanted, queue = set(), []

    def want(names):
        for n in names:
            k = n.lower()
            if k in available and k not in own and k not in hand and k not in wanted:
                wanted.add(k)
                queue.append(k)

    for f in os.listdir(SRC):
        if f.lower().endswith(".psc"):
            for line in logical_lines(read(os.path.join(SRC, f))):
                want(IDENT.findall(strip_strings(line)))
    # a hand-written stub can mention types it does not define either
    for d in HAND:
        for f in os.listdir(d):
            if f.lower().endswith(".psc"):
                want(header(logical_lines(read(os.path.join(d, f))))[1])

    headers = {}
    while queue:
        k = queue.pop()
        text, used = header(logical_lines(read(available[k])))
        headers[k] = (os.path.basename(available[k]), text)
        want(used)

    os.makedirs(OUT, exist_ok=True)
    for f in os.listdir(OUT):
        if f.lower().endswith(".psc"):
            os.remove(os.path.join(OUT, f))
    for k, (name, text) in sorted(headers.items()):
        with open(os.path.join(OUT, name), "w", encoding="utf-8", newline="\n") as fh:
            fh.write("; declaration-only header for the CI build (tools/gen_headers.py) - not part of the mod\n" + text)
    print(f"{len(headers)} headers in {OUT}")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    main(sys.argv[1:])
