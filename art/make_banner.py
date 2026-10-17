"""CHIM Vampire Bridge - Nexus banner (1920x1080), original artwork, no third-party logos.
Left half: CHIM - cold blue AI network and dialogue (as on the other CHIM bridges' banners).
Right half: vampires - a blood moon over a dark castle, bats, red mist and drops of blood.
The halves meet on a 45 degree diagonal. Writes banner.html; render it to PNG with a
headless browser (see render_banner.ps1).
"""
import math, os, random

W, H = 1920, 1080
C = W // 2 + H // 2          # 45 degree divider: x + y = C, through the middle
rnd = random.Random(1313)


def inside_left(x, y, margin=0):
    return x + y < C - margin


out = []
add = out.append
add(f'<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}">')
add(f'''<defs>
  <linearGradient id="cold" x1="0" y1="0" x2="1" y2="1">
    <stop offset="0" stop-color="#040b1c"/><stop offset="0.55" stop-color="#0a2348"/><stop offset="1" stop-color="#0f3a6e"/>
  </linearGradient>
  <linearGradient id="warm" x1="1" y1="1" x2="0" y2="0">
    <stop offset="0" stop-color="#050106"/><stop offset="0.55" stop-color="#2a030c"/><stop offset="1" stop-color="#5c0a18"/>
  </linearGradient>
  <radialGradient id="moon" cx="0.42" cy="0.4" r="0.6">
    <stop offset="0" stop-color="#ffd2c4"/><stop offset="0.45" stop-color="#e2442f"/><stop offset="1" stop-color="#7a0d12"/>
  </radialGradient>
  <linearGradient id="bloodText" x1="0" y1="0" x2="0" y2="1">
    <stop offset="0" stop-color="#ffb3a6"/><stop offset="0.55" stop-color="#e2202f"/><stop offset="1" stop-color="#8e0a17"/>
  </linearGradient>
  <linearGradient id="drop" x1="0" y1="0" x2="0" y2="1">
    <stop offset="0" stop-color="#ff5a5a"/><stop offset="1" stop-color="#7a0610"/>
  </linearGradient>
  <radialGradient id="coldGlow" cx="0.32" cy="0.42" r="0.55">
    <stop offset="0" stop-color="#3fc8ff" stop-opacity="0.28"/><stop offset="1" stop-color="#3fc8ff" stop-opacity="0"/>
  </radialGradient>
  <radialGradient id="warmGlow" cx="0.76" cy="0.62" r="0.5">
    <stop offset="0" stop-color="#ff3a3a" stop-opacity="0.30"/><stop offset="1" stop-color="#ff3a3a" stop-opacity="0"/>
  </radialGradient>
  <linearGradient id="seam" x1="0" y1="1" x2="1" y2="0">
    <stop offset="0" stop-color="#3fc8ff"/><stop offset="0.5" stop-color="#ffffff"/><stop offset="1" stop-color="#ff3a3a"/>
  </linearGradient>
  <linearGradient id="titleGrad" x1="0" y1="0" x2="1" y2="0">
    <stop offset="0" stop-color="#7fdcff"/><stop offset="0.5" stop-color="#ffffff"/><stop offset="1" stop-color="#ff8a80"/>
  </linearGradient>
  <linearGradient id="gold" x1="0" y1="0" x2="1" y2="1">
    <stop offset="0" stop-color="#fff1c2"/><stop offset="0.35" stop-color="#f2c15a"/><stop offset="0.7" stop-color="#b9822a"/><stop offset="1" stop-color="#ffe29a"/>
  </linearGradient>
  <linearGradient id="goldText" x1="0" y1="0" x2="0" y2="1">
    <stop offset="0" stop-color="#fff0c8"/><stop offset="0.6" stop-color="#ffcf6e"/><stop offset="1" stop-color="#e9a84a"/>
  </linearGradient>
  <radialGradient id="petal" cx="0.4" cy="0.35" r="0.8">
    <stop offset="0" stop-color="#ff8aa8"/><stop offset="0.7" stop-color="#c2224f"/><stop offset="1" stop-color="#7d0f30"/>
  </radialGradient>
  <filter id="blur8"><feGaussianBlur stdDeviation="8"/></filter>
  <filter id="blur3" x="-50%" y="-50%" width="200%" height="200%"><feGaussianBlur stdDeviation="3"/></filter>
  <filter id="soft" x="-60%" y="-60%" width="220%" height="220%"><feGaussianBlur stdDeviation="22"/></filter>
  <filter id="shadow" x="-20%" y="-50%" width="140%" height="200%">
    <feDropShadow dx="0" dy="4" stdDeviation="10" flood-color="#000" flood-opacity="0.85"/>
  </filter>
  <clipPath id="leftHalf"><polygon points="0,0 {C},0 {C - H},{H} 0,{H}"/></clipPath>
  <clipPath id="rightHalf"><polygon points="{C},0 {W},0 {W},{H} {C - H},{H}"/></clipPath>
  <path id="heart" d="M0,-30 C-25,-70 -90,-55 -90,-5 C-90,40 -30,75 0,105 C30,75 90,40 90,-5 C90,-55 25,-70 0,-30 Z"/>
  <path id="dropShape" d="M0,-40 C14,-18 26,-2 26,14 C26,30 14,42 0,42 C-14,42 -26,30 -26,14 C-26,-2 -14,-18 0,-40 Z"/>
  <path id="bat" d="M0,0 C-10,-14 -26,-16 -40,-8 C-34,-6 -30,0 -32,6 C-26,2 -20,4 -18,10 C-14,4 -8,4 -4,8 L0,2 L4,8 C8,4 14,4 18,10 C20,4 26,2 32,6 C30,0 34,-6 40,-8 C26,-16 10,-14 0,0 Z"/>
  <path id="petalShape" d="M0,-40 C30,-38 42,-8 30,18 C20,38 -8,46 -26,30 C-44,12 -36,-36 0,-40 Z"/>
</defs>''')

# ---------------- left: CHIM
add('<g clip-path="url(#leftHalf)">')
add(f'<rect width="{W}" height="{H}" fill="url(#cold)"/><rect width="{W}" height="{H}" fill="url(#coldGlow)"/>')
for row in range(0, 30):
    for col in range(0, 40):
        x = col * 60 + (30 if row % 2 else 0)
        y = row * 52
        if inside_left(x, y):
            pts = " ".join(f"{x + 26 * math.cos(math.radians(a)):.1f},{y + 26 * math.sin(math.radians(a)):.1f}" for a in range(30, 390, 60))
            add(f'<polygon points="{pts}" fill="none" stroke="#3fc8ff" stroke-opacity="0.05" stroke-width="1"/>')
nodes = []
while len(nodes) < 70:
    x, y = rnd.uniform(40, C), rnd.uniform(40, H - 40)
    if inside_left(x, y, 60):
        nodes.append((x, y))
for (x1, y1) in nodes:
    for (x2, y2) in sorted(nodes, key=lambda p: (p[0] - x1) ** 2 + (p[1] - y1) ** 2)[1:4]:
        add(f'<line x1="{x1:.0f}" y1="{y1:.0f}" x2="{x2:.0f}" y2="{y2:.0f}" stroke="#3fc8ff" stroke-opacity="0.22" stroke-width="1.4"/>')
for (x, y) in nodes:
    r = rnd.uniform(2.5, 6)
    add(f'<circle cx="{x:.0f}" cy="{y:.0f}" r="{r * 3:.1f}" fill="#3fc8ff" opacity="0.12" filter="url(#blur3)"/>')
    add(f'<circle cx="{x:.0f}" cy="{y:.0f}" r="{r:.1f}" fill="#bff0ff" opacity="0.85"/>')


def bubble(cx, cy, w, h, tail_left, opacity, heart_inside=False):
    tail = f"M{cx - w * 0.25:.0f},{cy + h / 2:.0f} l{-28 if tail_left else 28},38 l{30 if tail_left else -30},-38 Z"
    add(f'<g opacity="{opacity}"><rect x="{cx - w / 2:.0f}" y="{cy - h / 2:.0f}" width="{w}" height="{h}" rx="{h / 2:.0f}" fill="#0b2a52" stroke="#7fdcff" stroke-width="3"/>'
        f'<path d="{tail}" fill="#0b2a52" stroke="#7fdcff" stroke-width="3" stroke-linejoin="round"/>')
    if heart_inside:
        add(f'<use href="#dropShape" transform="translate({cx},{cy - 2}) scale(0.62)" fill="url(#drop)"/>')
    else:
        add("".join(f'<circle cx="{cx + d:.0f}" cy="{cy:.0f}" r="9" fill="#bff0ff"/>' for d in (-34, 0, 34)))
    add('</g>')


bubble(330, 300, 230, 96, True, 0.95)
bubble(620, 190, 190, 80, False, 0.85, heart_inside=True)
bubble(250, 820, 160, 70, True, 0.6)
add('</g>')


# ---------------- right: vampires - blood moon, castle, bats, blood
add('<g clip-path="url(#rightHalf)">')
add(f'<rect width="{W}" height="{H}" fill="url(#warm)"/><rect width="{W}" height="{H}" fill="url(#warmGlow)"/>')
for _ in range(40):  # red mist
    x, y = rnd.uniform(C - H, W), rnd.uniform(H * 0.45, H)
    if not inside_left(x, y, -40):
        add(f'<circle cx="{x:.0f}" cy="{y:.0f}" r="{rnd.uniform(40, 110):.0f}" fill="#b0101e" opacity="{rnd.uniform(0.05, 0.14):.2f}" filter="url(#blur8)"/>')
# the blood moon
add('<circle cx="1640" cy="300" r="250" fill="#ff3a2a" opacity="0.30" filter="url(#soft)"/>')
add('<circle cx="1640" cy="300" r="170" fill="url(#moon)"/>')
for (dx, dy, r, o) in [(-55, -30, 30, 0.18), (40, 50, 22, 0.15), (70, -60, 16, 0.14), (-20, 80, 14, 0.12)]:
    add(f'<circle cx="{1640 + dx}" cy="{300 + dy}" r="{r}" fill="#5a0a0e" opacity="{o}"/>')
# a castle on the crag, black against the moon and the mist
castle = ("M1180,1080 L1180,880 L1230,840 L1300,860 L1320,760 L1340,760 L1340,720 L1355,700 L1370,720 L1370,760 "
          "L1395,760 L1410,820 L1460,800 L1480,640 L1495,640 L1495,600 L1512,570 L1529,600 L1529,640 L1544,640 "
          "L1560,790 L1620,770 L1640,690 L1655,690 L1655,660 L1670,640 L1685,660 L1685,690 L1700,690 L1720,800 "
          "L1800,830 L1880,880 L1920,900 L1920,1080 Z")
add(f'<path d="{castle}" fill="#030103"/>')
for (x, y) in [(1340, 790), (1505, 680), (1508, 720), (1660, 730), (1240, 900), (1585, 840)]:
    add(f'<rect x="{x}" y="{y}" width="9" height="16" rx="3" fill="#ff7a3a" opacity="0.8"/>')
for _ in range(14):  # bats
    x, y = rnd.uniform(C - H + 200, W - 40), rnd.uniform(60, 600)
    if not inside_left(x, y, -80) and not (y > 340 and x < 1720):
        s = rnd.uniform(0.6, 1.5)
        add(f'<use href="#bat" transform="translate({x:.0f},{y:.0f}) rotate({rnd.uniform(-20, 20):.0f}) scale({s:.2f})" fill="#080204" opacity="0.92"/>')
for (x, y, s) in [(1420, 300, 0.9), (1860, 640, 0.7), (1340, 1000, 0.8), (1890, 160, 0.6)]:  # drops of blood
    if not inside_left(x, y, -60):
        add(f'<use href="#dropShape" transform="translate({x},{y}) scale({s})" fill="url(#drop)" opacity="0.85"/>')
for _ in range(35):  # embers
    x, y = rnd.uniform(C - H + 100, W), rnd.uniform(0, H)
    if not inside_left(x, y, -60):
        add(f'<circle cx="{x:.0f}" cy="{y:.0f}" r="{rnd.uniform(1.5, 3.5):.1f}" fill="#ff9a7a" opacity="{rnd.uniform(0.3, 0.8):.2f}"/>')
add('</g>')

# ---------------- seam
add(f'<line x1="{C - H - 20}" y1="{H + 20}" x2="{C + 20}" y2="-20" stroke="url(#seam)" stroke-width="26" opacity="0.35" filter="url(#blur8)"/>')
add(f'<line x1="{C - H - 20}" y1="{H + 20}" x2="{C + 20}" y2="-20" stroke="url(#seam)" stroke-width="5"/>')

# ---------------- title
add('<g font-family="Georgia, Palatino Linotype, serif" text-anchor="middle" filter="url(#shadow)">')
BOX = 1400  # title plate, centred
add(f'<rect x="{(W - BOX) / 2:.0f}" y="{H / 2 - 150}" width="{BOX}" height="300" rx="28" fill="#000" opacity="0.38"/>')
# one line, centred as a whole: the two words keep their own colours as tspans
add(f'<text x="{W / 2}" y="{H / 2 + 10}" text-anchor="middle" font-size="120" font-weight="bold">'
    f'<tspan letter-spacing="8" fill="#7fdcff">CHIM</tspan>'
    f'<tspan dx="40" letter-spacing="3" fill="url(#bloodText)">Vampire</tspan></text>')
add(f'<text x="{W / 2}" y="{H / 2 + 100}" font-size="64" letter-spacing="34" fill="url(#titleGrad)">BRIDGE</text>')
add(f'<text x="{W / 2}" y="{H - 48}" font-size="34" letter-spacing="6" fill="#ffffff" opacity="0.85">by SaurOff</text>')
add('</g>')
add('</svg>')

here = os.path.dirname(os.path.abspath(__file__))
svg = "\n".join(out)
open(os.path.join(here, "banner.svg"), "w", encoding="utf-8").write(svg)
open(os.path.join(here, "banner.html"), "w", encoding="utf-8").write(
    '<!doctype html><html><head><meta charset="utf-8"><style>html,body{margin:0;padding:0;background:#000;overflow:hidden}</style></head><body>'
    + svg + "</body></html>")
print("written", os.path.join(here, "banner.html"))
