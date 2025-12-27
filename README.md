# ⏱️ Time / Clock Mod for Balatro

## Overview
This mod introduces **time as a first-class resource** in Balatro.

Time passes only during blinds and directly affects:
- scaling
- decay
- destruction
- retriggers
- economy
- card identity

Players gain tools to **read, manipulate, pause, and spend time**, but time pressure is always present. Power gained through time is **visible, slow, and bounded**.

This mod is designed as a **systemic expansion**, not just a Joker pack.

---

## Core Principles
- Time is pressure
- Control is earned
- Waiting is sometimes correct, but never free
- Positioning and order matter
- Power scales, but is always bounded

---

## ⏱️ Global Clock
- Time starts at **0** at run start
- Time advances **only during blinds** (including Boss Blinds)
- Time does **not** advance in shops or menus
- The clock is always visible on-screen
- Clock **speed and pause state persist between blinds**
- If a control source is removed (e.g. Freeze sold), the clock resumes immediately

---

## 🎛️ Clock Controls

### Speed (Vouchers)
- **Hypersonic** → Unlocks **2× speed**
- **Lightspeed** → Requires Hypersonic, unlocks **4× speed**

### Pause
**Freeze (Rare Joker)**
- Adds a Pause button to the clock
- While paused, time-based effects stop
- Removing Freeze resumes time immediately

---

## 🔥 Burning System

### Burning Enhancement
- Burning cards gain **+2 Mult per minute**
- After **5 minutes**, the card is destroyed
- Countdown pauses when time is paused

### Tarot: The Pyre
- Apply Burning to **2 selected cards**

---

## 🔀 Shuffle Edition
- Cards keep the Shuffle edition
- Every **3 minutes** on the global clock, all Shuffle cards reshuffle their modifier

---

## 🧷 Stickers

### Travelback
- On scoring: **–5 seconds** from the clock

### Blessed
- Gains **+0.1 XMult per minute**
- Caps at **5×**
- Ordered left → right by increasing value

---

## 🧷 Seals

### Travel
- On scoring: **+5 seconds** to the clock

### Pink Seal
- While scoring, card rank becomes the **leading digit of the clock**
- Mapping:
  - 0 → 10
  - 1 → Ace
  - 2–9 → 2–9

---

## 🔮 Spectral Cards

### Pendulum
- Applies a **random Pink or Travelback seal** to a selected card

---

## 🃏 Jokers

### Common
- Hourglass
- Rust
- Alarm Clock
- I’m On Fire
- Wait

### Uncommon
- Goblin
- Extinguisher
- Robin Hood
- Engineer
- Fuse
- Sundial
- Supernova

### Rare
- Freeze
- Fertilizer
- Angel

### Legendary
- Chronos

---

## 🂠 Decks
- Pendulum Deck
- Chronos Deck
- Cinder Deck

---

## 🏁 Challenge
**Against the Clock**
- Beat Ante 8 before the clock hits **10:00**
- Instant loss when time runs out

---

## Status
Design complete. Implementation next.
