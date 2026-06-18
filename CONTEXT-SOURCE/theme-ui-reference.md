## # Fluidbar Ui Elements & Themes

## Horizontal Bar Themes

### 01 · block halves

```
CPU Usage [██████████████████████▌░░░░░░░░░] 70%
6 cores · 3.8 GHz
usr 58% sys 14% idle 28%
Uses ▏▎▍▌▋▊▉█ eighth-steps for sub-cell precision
```

### 02 · shade fill

```
RAM [███████████▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░░] 70%
8.8 GB / 16 GB
active 6.1G cache 2.7G free 7.2G
Transitions ░ → ▒ → ▓ → █ across fill zones
```

### 03 · braille dots

```
Network RX [⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀] 70%
↓ 480 Mbps
eth0 pkts 1.2M err 0
Braille block ⣀⣄⣤⣦⣶⣷⣿ for dense micro-resolution fill
```

### 04 · thin line

```
Disk Read ├━━━━━━━━━━━━━━━━━━━━━━──────────┤ 70%
↑ 220 MB/s
/dev/nvme0 queue 4 lat 0.3ms
Light box-drawing ─ for unfilled, ━ for filled section
```

### 05 · double line

```
GPU Temp ╠══════════════════════──────────╣ 70%
83 °C / 100 °C
RTX 4070 fan 78% tdp 150W
Double-rule ═ fill inside ╠ ╣ frame for bold presence
```

### 06 · arrow pulse

```
Upload [►►►►►►►►►►►►►►►►►►►►►▶··········] 70%
↑ 55 Mbps
WAN tx 88K pkts drop 0%
Chevron ► chains give a directional flow illusion
```

### 07 · diamond chain

```
Cache Hit [◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◇◇◇◇◇◇◇◇◇◇] 70%
91.4% ratio
L2 8 MB hits 2.3M miss 210K
◆ for filled cells, ◇ empty — geometric rhythm at high fill
```

### 08 · pipe fill

```
Swap Used [┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃┃╎╎╎╎╎╎╎╎╎╎] 70%
0.9 GB / 4 GB
zswap on pages 230K faults 0
Vertical bar ┃ fill with ╎ dotted empty — minimal noise
```

### 09 · wave roll

```
Throughput [∿≈~∿≈~∿≈~∿≈~∿≈~∿≈~∿≈~∿··········] 70%
1.34 Gbps
bond0 irq bal offload on
Alternating ∿ ≈ ~ gives a sinusoidal wave texture
```

### 10 · segment LED

```
Battery [▐█▌▐█▌▐█▌▐█▌▐█▌▐█▌▐█▌▐░▌▐░▌▐░▌] 70%
76% · 3h 12m left
charging 9.2V 2.1A cycles 247
▐█▌ filled segments vs ▐░▌ empty — simulates LED segments
```

# Element Reference

| #   | Characters   | Character class                        |
| --- | ------------ | -------------------------------------- |
| 01  | `▏▎▍▌▋▊▉█ ░` | Block elements — eighth-step precision |
| 02  | `░▒▓█`       | Block shades — gradient texture        |
| 03  | `⠀⣀⣄⣤⣦⣶⣷⣿`   | Braille blocks — ultra-dense fill      |
| 04  | `─ ━ ├ ┤`    | Box drawing — thin line                |
| 05  | `─ ═ ╠ ╣`    | Box drawing — double rule              |
| 06  | `► ▶ ·`      | Geometric — arrow chain                |
| 07  | `◆ ◇`        | Geometric — diamond chain              |
| 08  | `┃ ╎`        | Box drawing — pipe fill                |
| 09  | `∿ ≈ ~ ·`    | Mathematical — wave roll               |
| 10  | `▐█▌ ▐░▌`    | Block elements — LED segments          |

## Verital Bars

*

| #   | Characters   | Notes                                                  |
| --- | ------------ | ------------------------------------------------------ |
| 01  | `▁▂▃▄▅▆▇█ ░` | Eighth-step tip — sub-row precision at the column head |
| 02  | `░▒▓█`       | Density gradient bottom-to-top                         |
| 03  | `⣿⣷⣶⣦⣤⣄⣀ ⠀`  | Braille blocks — densest sub-cell resolution           |
| 04  | `┃ ╎`        | Box-drawing thin pipe                                  |
| 05  | `║ │`        | Box-drawing double pipe                                |
| 06  | `● ∘ ·`      | Dot density rise                                       |
| 07  | `◆ ◇`        | Diamond stack                                          |
| 08  | `▲ ▴ ·`      | Arrow tip + body — directional                         |
| 09  | `∿ ≈ ~`      | Wave column texture                                    |
| 10  | `▬ ╌`        | Horizontal segment stack — LED readout feel            |
