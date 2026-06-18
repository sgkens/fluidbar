# ASCII Extended — Vertical Progress Bars

10 vertical bar styles using ASCII Extended / Unicode block characters, suitable for TUI and CLI dashboard applications.

---

## Character reference

| # | Style | Characters | Notes |
|---|-------|-----------|-------|
| 01 | full block | `▁▂▃▄▅▆▇█ ░` | Eighth-step tip — sub-row precision at the column head |
| 02 | shade stack | `░▒▓█` | Density gradient bottom-to-top |
| 03 | braille col | `⣿⣷⣶⣦⣤⣄⣀ ⠀` | Braille blocks — densest sub-cell resolution |
| 04 | thin pipe | `┃ ╎` | Box-drawing thin pipe |
| 05 | double pipe | `║ │` | Box-drawing double pipe |
| 06 | dot rise | `● ∘ ·` | Dot density rise |
| 07 | diamond stack | `◆ ◇` | Diamond stack |
| 08 | arrow rise | `▲ ▴ ·` | Arrow tip + body — directional |
| 09 | wave col | `∿ ≈ ~` | Wave column texture |
| 10 | segment LED | `▬ ╌` | Horizontal segment stack — LED readout feel |

---

## 01 · full block

Uses `▁▂▃▄▅▆▇█` eighth-height steps for sub-row precision at the column tip.

```
 72  55  88  41  63  18  79  95
 █   ░   █   ░   █   ░   █   █
 █   ░   █   ░   █   ░   █   █
 █   ░   █   ░   █   ░   █   █
 █   █   █   ░   █   ░   █   █
 █   █   █   ░   █   ░   █   █
 █   █   █   ░   █   ░   █   █
 █   █   █   ░   █   ░   █   █
 █   █   █   ░   █   ░   █   █
 █   █   █   ░   █   ░   █   █
 █   █   █   █   █   ░   █   █
 █   █   █   █   █   ░   █   █
▅   ▆   █   ▒   ▅   ▂   ▇   █
CPU RAM GPU NET DSK SWP TMP PWR
```

---

## 02 · shade stack

Transitions `░ → ▒ → ▓ → █` — bottom dense, top fades.

```
 72  55  88  41  63  18  79  95
 ▒   ░   ▒   ░   ▒   ░   ▒   ▒
 ▓   ░   ▓   ░   ▒   ░   ▓   ▓
 █   ░   █   ░   ▓   ░   █   █
 █   ▒   █   ░   █   ░   █   █
 █   ▓   █   ░   █   ░   █   █
 █   █   █   ░   █   ░   █   █
 █   █   █   ░   █   ░   █   █
 █   █   █   ▒   █   ░   █   █
 █   █   █   ▓   █   ░   █   █
 █   █   █   █   █   ░   █   █
 █   █   █   █   █   ▒   █   █
 █   █   █   █   █   ▓   █   █
CPU RAM GPU NET DSK SWP TMP PWR
```

---

## 03 · braille col

`⣀⣄⣤⣦⣶⣷⣿` braille blocks — densest sub-cell vertical fill.

```
 72  55  88  41  63  18  79  95
 ⣿   ⠀   ⣿   ⠀   ⣿   ⠀   ⣿   ⣿
 ⣿   ⠀   ⣿   ⠀   ⣿   ⠀   ⣿   ⣿
 ⣿   ⠀   ⣿   ⠀   ⣿   ⠀   ⣿   ⣿
 ⣿   ⣿   ⣿   ⠀   ⣿   ⠀   ⣿   ⣿
 ⣿   ⣿   ⣿   ⠀   ⣿   ⠀   ⣿   ⣿
 ⣿   ⣿   ⣿   ⠀   ⣿   ⠀   ⣿   ⣿
 ⣿   ⣿   ⣿   ⠀   ⣿   ⠀   ⣿   ⣿
 ⣿   ⣿   ⣿   ⣿   ⣿   ⠀   ⣿   ⣿
 ⣿   ⣿   ⣿   ⣿   ⣿   ⠀   ⣿   ⣿
 ⣿   ⣿   ⣿   ⣿   ⣿   ⠀   ⣿   ⣿
 ⣿   ⣿   ⣿   ⣿   ⣿   ⣿   ⣿   ⣿
 ⣿   ⣿   ⣿   ⣿   ⣿   ⣿   ⣿   ⣿
⣶   ⣦   ⣿   ⣄   ⣦   ⣀   ⣷   ⣿
CPU RAM GPU NET DSK SWP TMP PWR
```

---

## 04 · thin pipe

`┃` filled · `╎` empty — box-drawing verticals, minimal noise.

```
 72  55  88  41  63  18  79  95
 ╎   ╎   ┃   ╎   ╎   ╎   ┃   ┃
 ╎   ╎   ┃   ╎   ╎   ╎   ┃   ┃
 ╎   ╎   ┃   ╎   ╎   ╎   ┃   ┃
 ┃   ╎   ┃   ╎   ╎   ╎   ┃   ┃
 ┃   ╎   ┃   ╎   ╎   ╎   ┃   ┃
 ┃   ┃   ┃   ╎   ╎   ╎   ┃   ┃
 ┃   ┃   ┃   ╎   ┃   ╎   ┃   ┃
 ┃   ┃   ┃   ╎   ┃   ╎   ┃   ┃
 ┃   ┃   ┃   ┃   ┃   ╎   ┃   ┃
 ┃   ┃   ┃   ┃   ┃   ╎   ┃   ┃
 ┃   ┃   ┃   ┃   ┃   ╎   ┃   ┃
 ┃   ┃   ┃   ┃   ┃   ╎   ┃   ┃
 ┃   ┃   ┃   ┃   ┃   ┃   ┃   ┃
CPU RAM GPU NET DSK SWP TMP PWR
```

---

## 05 · double pipe

`║` filled · `│` empty — double-rule verticals for bold presence.

```
 72  55  88  41  63  18  79  95
 │   │   ║   │   │   │   ║   ║
 │   │   ║   │   │   │   ║   ║
 │   │   ║   │   │   │   ║   ║
 ║   │   ║   │   │   │   ║   ║
 ║   │   ║   │   │   │   ║   ║
 ║   ║   ║   │   │   │   ║   ║
 ║   ║   ║   │   ║   │   ║   ║
 ║   ║   ║   │   ║   │   ║   ║
 ║   ║   ║   ║   ║   │   ║   ║
 ║   ║   ║   ║   ║   │   ║   ║
 ║   ║   ║   ║   ║   │   ║   ║
 ║   ║   ║   ║   ║   │   ║   ║
 ║   ║   ║   ║   ║   ║   ║   ║
CPU RAM GPU NET DSK SWP TMP PWR
```

---

## 06 · dot rise

`·` → `∘` → `●` rising density — sparse bottom, solid top.

```
 72  55  88  41  63  18  79  95
 ·   ·   ●   ·   ·   ·   ●   ●
 ·   ·   ●   ·   ·   ·   ●   ●
 ·   ·   ●   ·   ·   ·   ●   ●
 ●   ·   ●   ·   ·   ·   ●   ●
 ●   ·   ●   ·   ·   ·   ●   ●
 ●   ∘   ●   ·   ·   ·   ●   ●
 ●   ●   ●   ·   ∘   ·   ●   ●
 ●   ●   ●   ·   ●   ·   ●   ●
 ●   ●   ●   ∘   ●   ·   ●   ●
 ●   ●   ●   ●   ●   ·   ●   ●
 ●   ●   ●   ●   ●   ·   ●   ●
 ●   ●   ●   ●   ●   ·   ●   ●
 ●   ●   ●   ●   ●   ∘   ●   ●
CPU RAM GPU NET DSK SWP TMP PWR
```

---

## 07 · diamond stack

`◆` filled · `◇` empty — geometric rhythm, reads well at any height.

```
 72  55  88  41  63  18  79  95
 ◇   ◇   ◆   ◇   ◇   ◇   ◆   ◆
 ◇   ◇   ◆   ◇   ◇   ◇   ◆   ◆
 ◇   ◇   ◆   ◇   ◇   ◇   ◆   ◆
 ◆   ◇   ◆   ◇   ◇   ◇   ◆   ◆
 ◆   ◇   ◆   ◇   ◇   ◇   ◆   ◆
 ◆   ◆   ◆   ◇   ◇   ◇   ◆   ◆
 ◆   ◆   ◆   ◇   ◆   ◇   ◆   ◆
 ◆   ◆   ◆   ◇   ◆   ◇   ◆   ◆
 ◆   ◆   ◆   ◆   ◆   ◇   ◆   ◆
 ◆   ◆   ◆   ◆   ◆   ◇   ◆   ◆
 ◆   ◆   ◆   ◆   ◆   ◇   ◆   ◆
 ◆   ◆   ◆   ◆   ◆   ◇   ◆   ◆
 ◆   ◆   ◆   ◆   ◆   ◆   ◆   ◆
CPU RAM GPU NET DSK SWP TMP PWR
```

---

## 08 · arrow rise

`▲` tip · `▴` body · `·` empty — directional upward flow.

```
 72  55  88  41  63  18  79  95
 ·   ·   ▲   ·   ·   ·   ▲   ▲
 ·   ·   ▴   ·   ·   ·   ▴   ▴
 ·   ·   ▴   ·   ·   ·   ▴   ▴
 ▲   ·   ▴   ·   ·   ·   ▴   ▴
 ▴   ·   ▴   ·   ·   ·   ▴   ▴
 ▴   ▲   ▴   ·   ·   ·   ▴   ▴
 ▴   ▴   ▴   ·   ▲   ·   ▴   ▴
 ▴   ▴   ▴   ·   ▴   ·   ▴   ▴
 ▴   ▴   ▴   ▲   ▴   ·   ▴   ▴
 ▴   ▴   ▴   ▴   ▴   ·   ▴   ▴
 ▴   ▴   ▴   ▴   ▴   ·   ▴   ▴
 ▴   ▴   ▴   ▴   ▴   ·   ▴   ▴
 ▴   ▴   ▴   ▴   ▴   ▲   ▴   ▴
CPU RAM GPU NET DSK SWP TMP PWR
```

---

## 09 · wave col

`∿ ≈ ~` alternating — sinusoidal column texture.

```
 72  55  88  41  63  18  79  95
 ·   ·   ∿   ·   ·   ·   ∿   ∿
 ·   ·   ≈   ·   ·   ·   ≈   ≈
 ·   ·   ~   ·   ·   ·   ~   ~
 ∿   ·   ∿   ·   ·   ·   ∿   ∿
 ≈   ·   ≈   ·   ·   ·   ≈   ≈
 ~   ∿   ~   ·   ·   ·   ~   ~
 ∿   ≈   ∿   ·   ∿   ·   ∿   ∿
 ≈   ~   ≈   ·   ≈   ·   ≈   ≈
 ~   ∿   ~   ∿   ~   ·   ~   ~
 ∿   ≈   ∿   ≈   ∿   ·   ∿   ∿
 ≈   ~   ≈   ~   ≈   ·   ≈   ≈
 ~   ∿   ~   ∿   ~   ·   ~   ~
 ∿   ≈   ∿   ~   ∿   ∿   ∿   ∿
CPU RAM GPU NET DSK SWP TMP PWR
```

---

## 10 · segment LED

`▬` filled · `╌` empty — horizontal segment stack, LED readout feel.

```
 72  55  88  41  63  18  79  95
 ╌   ╌   ▬   ╌   ╌   ╌   ▬   ▬
 ╌   ╌   ▬   ╌   ╌   ╌   ▬   ▬
 ╌   ╌   ▬   ╌   ╌   ╌   ▬   ▬
 ▬   ╌   ▬   ╌   ╌   ╌   ▬   ▬
 ▬   ╌   ▬   ╌   ╌   ╌   ▬   ▬
 ▬   ▬   ▬   ╌   ╌   ╌   ▬   ▬
 ▬   ▬   ▬   ╌   ▬   ╌   ▬   ▬
 ▬   ▬   ▬   ╌   ▬   ╌   ▬   ▬
 ▬   ▬   ▬   ▬   ▬   ╌   ▬   ▬
 ▬   ▬   ▬   ▬   ▬   ╌   ▬   ▬
 ▬   ▬   ▬   ▬   ▬   ╌   ▬   ▬
 ▬   ▬   ▬   ▬   ▬   ╌   ▬   ▬
 ▬   ▬   ▬   ▬   ▬   ▬   ▬   ▬
CPU RAM GPU NET DSK SWP TMP PWR
```

---

## Usage notes

- **01 full block** and **03 braille** give the highest visual resolution per character row — best for live system metrics.
- **08 arrow rise** suits throughput or upload columns where direction carries meaning.
- **10 segment LED** works well for discrete capacity — battery cells, core slots, connection count.
- All styles are monospace-safe; render correctly in any terminal font (`JetBrains Mono`, `Cascadia Code`, `MonaspiceAr Nerd Font Mono`, etc.).
- Combine vertical bars with a horizontal axis rule (`─────────`) and corner connectors (`└` `┘`) for a full panel frame.

---

*Columns: CPU · RAM · GPU · NET · DSK · SWP · TMP · PWR — sample values: 72 55 88 41 63 18 79 95*
