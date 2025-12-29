# ⏱️ Balatro Time

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

## 🔥 Fire System

### Fire Enhancement
- Fire cards start at **+15 mult**
- Fire cards lose **3 Mult per 30sec**
- After **5 minutes**, the card is destroyed
- Countdown pauses when time is paused

### Tarot: The Pyre
- Apply Fire to **2 selected cards**

<!-- ---

## 🔀 Shuffle Edition
- Cards keep the Shuffle edition
- Every **3 minutes** on the global clock, all Shuffle cards reshuffle their modifier

--- -->

## 🧷 Stickers

<!-- ### Green
- On scoring: **–5 seconds** from the clock -->

### Blessed
- Gains **+0.1 XMult per minute**
- Caps at **5×**
- Blessed jokers are ordered left → right by increasing value

---

## 🧷 Seals

### Green Seal
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
- Applies a **random Pink or Green seal** to up to 2 selected cards

---

## 🃏 Jokers

### Common
- <details>
  <summary>Hourglass</summary>

  - +1 chip every 5 seconds  
  - Respects game speed  
  - Resets on sell
  </details>

- <details>
  <summary>Rust</summary>

  - +15 Mult
  - reduced by 3 every 30 sec
  </details>

- <details>
  <summary>Alarm Clock</summary>
  
  - +40 chips + 5 mult
  - destroyed after 1min
  </details>

- <details>
  <summary>I’m On Fire</summary>
  
  - Adds the Fire modifier to all cards in hand
  - Triggers 3min after buying
  </details>

- <details>
  <summary>Wait</summary>

  - -30sec on trigger
  </details>

### Uncommon
- <details>
  <summary>Goblin</summary>

  - Stores 1$ every 15 sec in round
  - Capped at 10$
  - resets at end of round
  </details>

- <details>
  <summary>Extinguisher</summary>
  
  - Stops all Fire cards from burning
  </details>

- <details>
  <summary>Robin Hood</summary>

  - adds 1% to value on joker every 5sec
  - transfers value% of chips to mult
  - resets on trigger
  - max 50%
  </details>

- <details>
  <summary>Engineer</summary>

  - adds hypersonic/lightspeed voucher to next shop upon selling
  </details>

- <details>
  <summary>Fuse</summary>

  - destroys 5 random cards in hand after 2min
  </details>

- <details>
  <summary>Sundial</summary>

  - retriggers cards with rank equal to the leading digit in the clock twice
  </details>


- <details>
  <summary>Supernova</summary>
  
  - if time on clock is less than 15 sec
  - fills consumable slots with planet card for played hand
  </details>

### Rare
- <details>
  <summary>Freeze</summary>

  - allows the player to pauze time
  </details>

- <details>
  <summary>Fertilizer</summary>

  - increases interest cap by 1 for every 3min on global clock
  </details>

- <details>
  <summary>Angel</summary>

  - if the global clock contains 3 3s,
  - add a pendulum card to consumable slots
  - if theres place

### Legendary
- <details>
  <summary>Chronos</summary>

  - scales by 0.1 every 30sec
  - adds Blessed sticker to the joker on its right once every minute
  </details>

---

## 🂠 Decks
- Pendulum Deck
- Cinder Deck

---

## 🏁 Challenge
**Chronos Blessed**
- Beat Ante 8
- 2 hands, 1 consumable slot, 4 joker slots
- start with eternal Chronos

**Pressure**
- Beat Ante 8
- No Modifiers
- Lose if timer goes beyond 5min

---

## Status
Implementation near-complete, Art Needed
