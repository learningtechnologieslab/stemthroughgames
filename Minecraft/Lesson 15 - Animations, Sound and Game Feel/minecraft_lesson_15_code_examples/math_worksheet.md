# Day 15 — FPS & Ticks Math Worksheet
**STEM Through Games | Animations, Sound & Game Feel**

Name: _________________________________ Date: _______________ Period: ____

---

## Part 1: The Formulas

Fill in the blanks:

> **Loop Time** = Frames ÷ **_______**
>
> **Seconds** = Ticks ÷ **_______**  *(Minecraft runs at _______ ticks per second)*

---

## Part 2: Worked Example

**Run Cycle:** 8 frames at 12 FPS

```
Loop Time = 8 ÷ 12 = _________ seconds
```

**A command block fires every 10 ticks:**

```
Duration = 10 ÷ 20 = _________ seconds
```

---

## Part 3: Practice Problems

Solve each problem. Show your division.

**Q1.** Idle animation: 4 frames at 6 FPS — how long is one loop?

```
Loop Time = _____ ÷ _____ = _________ seconds
```

**Q2.** Jump animation: 5 frames at 15 FPS — how long does it play?

```
Loop Time = _____ ÷ _____ = _________ seconds
```

**Q3.** A repeating command block fires every 10 ticks. How many seconds between each fire?

```
Duration = _____ ÷ _____ = _________ seconds
```

**Q4.** You want a sound cooldown to last 0.5 seconds. How many ticks should you use?

```
Ticks = _________ × 20 = _________ ticks
```

**Q5.** A walk cycle loop is 0.4 seconds long at 8 FPS. How many frames does it have?

```
Frames = _________ × _________ = _________ frames
```

**Q6.** A 1-second walk cycle plays at 10 FPS. How many frames?

```
Frames = _________ × _________ = _________ frames
```

---

## Part 4: Minecraft Timing Challenges

**Q7.** The footstep cooldown in our datapack is set to **6 ticks**.

- How many seconds is that? _______________
- How many times per second does the footstep sound play? _______________
- If you wanted steps to sound *faster* (like running), would you increase or decrease the cooldown? _______________

**Q8.** You want the hurt effect to lock player movement for exactly 0.4 seconds.

- How many ticks is that? _______________
- Show your work: _______________

**Q9.** Your background music track is 90 seconds long. How many ticks long is it?

```
Ticks = 90 × _____ = _________ ticks
```

---

## Part 5: Design Challenge

You are designing a "boss fight" music track.

- The boss fight should feel **intense and urgent**
- Your music loops every **4 seconds**
- You decide it should have **32 frames** (musical beats)

**Calculate the FPS (beats per second):**
```
FPS = Frames ÷ Loop Time = _____ ÷ _____ = _________ FPS
```

In music, "FPS" is like **BPM (beats per minute)**. Convert your answer:
```
BPM = FPS × 60 = _____ × 60 = _________ BPM
```

> *Is 120+ BPM fast or slow? How does this connect to the emotional design slide?*

---

## Answer Key *(Teacher Copy)*

| Question | Answer |
|---|---|
| Part 1 blanks | FPS, 20, 20 |
| Worked Example | 0.67 sec; 0.5 sec |
| Q1 | 4 ÷ 6 = 0.67 sec |
| Q2 | 5 ÷ 15 = 0.33 sec |
| Q3 | 10 ÷ 20 = 0.5 sec |
| Q4 | 0.5 × 20 = 10 ticks |
| Q5 | 0.4 × 8 = 3.2 frames (round to 3) |
| Q6 | 1 × 10 = 10 frames |
| Q7 | 0.3 sec; 3.3 times/sec; decrease |
| Q8 | 0.4 × 20 = 8 ticks |
| Q9 | 90 × 20 = 1800 ticks |
| Design | 32 ÷ 4 = 8 FPS; 8 × 60 = 480 BPM *(very fast — discuss!)* |
