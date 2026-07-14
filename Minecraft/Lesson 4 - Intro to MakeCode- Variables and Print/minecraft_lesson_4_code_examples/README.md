# Day 4 Code Examples
## STEM Through Games — Minecraft Education Edition
### Topic: Intro to MakeCode · Variables & Print

---

## How to Use These Files

These files contain MakeCode JavaScript code for use inside **Minecraft Education Edition**. Each file is a standalone script designed to be copied into the MakeCode editor one at a time.

### Opening MakeCode in Minecraft Education

1. Launch **Minecraft Education Edition** and open or create a world
2. Press **C** to open the Code Builder
3. Select **MakeCode**
4. Click the **\</>** button in the top-right of MakeCode to switch to **JavaScript view**
5. Select all the default code and **delete it**
6. Open the `.js` file you want to use (in any text editor, Notepad, etc.)
7. Copy the code and paste it into MakeCode
8. Press the green **▶ Run** button — your character will speak the output in-game

> **Tip for students:** The lesson asks you to *type* the code instead of pasting it. That's intentional — typing every character helps you read the code more carefully and builds real muscle memory.

---

## File Structure

```
minecraft_day4/
│
├── README.md                          ← You are here
│
├── starter/
│   └── starter_script.js              ← Start here (Step 2 of the lesson)
│
├── explore/
│   ├── explore_A_change_name.js       ← Explore A: Change your name
│   ├── explore_B_lower_health.js      ← Explore B: Lower health to 50
│   ├── explore_C_add_score.js         ← Explore C: Add to the score
│   ├── explore_D_take_damage.js       ← Explore D: Subtract health (damage)
│   └── explore_math_operators.js      ← All 5 operators in one demo
│
├── extension/
│   ├── extension_star1_more_variables.js   ← ★   More variables
│   ├── extension_star2_modulo_mystery.js   ← ★★  Modulo deep dive
│   └── extension_star3_narrative.js        ← ★★★ Narrative adventure scene
│
└── teacher/
    ├── teacher_demo.js                ← Full live demo with talking points
    └── common_errors.js               ← Common student mistakes + fixes
```

---

## Lesson Flow — Which File, When

| Lesson Segment | Time | File(s) to Use |
|---|---|---|
| **Main Activity Step 2** — Write & Run | 15 min | `starter/starter_script.js` |
| **Main Activity Step 3** — Explore & Modify | 15 min | `explore/explore_A` through `explore_D` |
| **Math Connection** | 10 min | `explore/explore_math_operators.js` |
| **Extension ★** | Early finishers | `extension/extension_star1_more_variables.js` |
| **Extension ★★** | Early finishers | `extension/extension_star2_modulo_mystery.js` |
| **Extension ★★★** | Early finishers | `extension/extension_star3_narrative.js` |
| **Teacher live demo** | Ongoing | `teacher/teacher_demo.js` |
| **Troubleshooting** | As needed | `teacher/common_errors.js` |

---

## File Descriptions

### `starter/starter_script.js`
The foundational script for the lesson. Students declare three variables (`playerName`, `health`, `score`) and use `player.say()` to display them in the Minecraft world. This is the file students type from scratch during Step 2 of the Main Activity.

**What students see in-game:**
```
Hero
Health: 100
Score: 0
```

---

### `explore/explore_A_change_name.js`
Students replace `"Hero"` with their own name and re-run. Demonstrates that changing a variable's *value* changes the output while the variable *name* stays the same.

### `explore/explore_B_lower_health.js`
Students set `health = 50` and observe the new output. Connects number variables to the Minecraft concept of losing hearts.

### `explore/explore_C_add_score.js`
Introduces `score = score + 10` — updating a variable using itself. Shows the before/after values and connects to earning XP in Minecraft. Includes a discussion prompt about what math operation happened.

### `explore/explore_D_take_damage.js`
Uses `health = health - 25` twice to simulate two hits from an enemy. Shows the running total of damage and connects subtraction to real Minecraft combat. Includes a math challenge: how many hits to reach 0?

### `explore/explore_math_operators.js`
A comprehensive demo of all five operators (+, -, \*, /, %) with real Minecraft scenarios for each one. Ideal for the Math Connection segment or as a student reference while exploring.

---

### `extension/extension_star1_more_variables.js` ★
Adds `level`, `lives`, and `enemyCount` to the starter variables and prints them all. Good for students who finish the main explore activities early.

### `extension/extension_star2_modulo_mystery.js` ★★
A guided investigation of the `%` (modulo) operator. Students discover the pattern, see why a result of `0` means a milestone, and explore a bonus application: how Minecraft's day/night cycle uses modulo to calculate the time of day.

### `extension/extension_star3_narrative.js` ★★★
An open-ended creative challenge. Students define variables for a complete adventure scenario (hero name, weapon, villain, quest, reward) and use string concatenation to have their character narrate a full intro scene. Combines all concepts from the lesson in an expressive format.

---

### `teacher/teacher_demo.js`
A structured live-demo script with inline talking points and pause prompts. Organized into five sections:
1. What is a variable?
2. Changing a variable's value
3. Math with variables (all five operators)
4. Strings vs. numbers
5. Final stats read-out

Run this section by section during instruction, pausing to ask the embedded questions.

### `teacher/common_errors.js`
A reference script showing the five most common student mistakes with both the broken and fixed version of each. Use this for:
- Live debugging when a student is stuck
- Showing the class what a red error looks like
- A printed reference sheet for students with IEPs or who need extra support

**Errors covered:**
1. Missing quotes around a string
2. Using `let` when updating an existing variable
3. Missing `+` when joining text and variables
4. Variable name capitalization mismatch
5. Trying to do math on a string value

---

## Key Concepts at a Glance

| Concept | MakeCode Syntax | Example |
|---|---|---|
| Declare a string variable | `let name = "text"` | `let playerName = "Hero"` |
| Declare a number variable | `let name = 0` | `let health = 100` |
| Update a variable | `name = newValue` | `score = score + 10` |
| Display output in-game | `player.say(value)` | `player.say("Health: " + health)` |
| Addition | `a + b` | `score + 10` |
| Subtraction | `a - b` | `health - 25` |
| Multiplication | `a * b` | `speed * 2` |
| Division | `a / b` | `coins / 4` |
| Modulo (remainder) | `a % b` | `score % 10` |

---

## Troubleshooting Quick Reference

| Symptom | Likely Cause | Fix |
|---|---|---|
| Red underline on a word | Missing quotes around text | Add `"` `"` around the value |
| `score` shows `010` instead of `10` | `"0"` used instead of `0` | Remove quotes from the number |
| Variable seems to reset | Used `let` when updating | Remove `let` from the update line |
| Character says `Health: undefined` | Variable name typo | Check exact spelling and capitalization |
| Two values run together (e.g. `10010`) | Added a string + number | Ensure the number variable has no quotes |

---

## Coming Up: Day 5

These variables will power the next lesson. On Day 5 students will use `if/else` statements to make the game *respond* to variable values — for example, checking `if (health <= 0)` to end the game.

```javascript
// Preview of Day 5 thinking:
if (health <= 0) {
    player.say("Game Over!")
} else {
    player.say("Keep going, " + playerName + "!")
}
```

---

*STEM Through Games · Minecraft Education Edition · Day 4 of 10*
