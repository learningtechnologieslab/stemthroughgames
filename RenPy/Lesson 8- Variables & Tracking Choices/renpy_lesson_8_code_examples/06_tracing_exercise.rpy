## ============================================================
##  DAY 8 — EXAMPLE 6: Variable Tracing Exercise
##  STEM Through Games · Ren'Py Programming
## ============================================================
##
##  PURPOSE:  This file is a CLASSROOM EXERCISE, not a full game.
##            Students read the code and PREDICT what the player
##            will see — without running it.
##
##  HOW TO USE:
##    1. Print this file or display it on the projector.
##    2. Give students the TRACE TABLE below (or draw it on paper).
##    3. Read through the code together as a class.
##    4. Students fill in the table BEFORE running the game.
##    5. Then run it to check!
##
##  ┌─────────────────────────────────────────────────────────┐
##  │  TRACE TABLE — fill in each box as you read the code    │
##  ├───────────┬────────┬──────────┬────────┬────────────────┤
##  │  After... │  gold  │  has_key │  mood  │  Dialogue shown│
##  ├───────────┼────────┼──────────┼────────┼────────────────┤
##  │  Line A   │        │          │        │                │
##  │  Line B   │        │          │        │                │
##  │  Line C   │        │          │        │                │
##  │  Line D   │        │          │        │                │
##  │  Line E   │        │          │        │                │
##  │  Line F   │        │          │        │                │
##  │  Line G   │        │          │        │                │
##  └───────────┴────────┴──────────┴────────┴────────────────┘
##
##  ANSWERS are at the bottom of this file (scroll down).
##
## ============================================================

define e = Character("Explorer", color="#5EC8E5")
define n = Character(None, kind=nvl)

# ── Starting values ───────────────────────────────────────────
default gold    = 10         # LINE A — What is gold?
default has_key = False      # LINE A — What is has_key?
default mood    = "nervous"  # LINE A — What is mood?

label start:

    scene bg bg_town with fade

    # LINE B
    $ gold = gold * 2
    # Question: What is gold now?

    # LINE C
    $ gold -= 5
    # Question: What is gold now?

    e "I have [gold] gold coins in my purse."

    # LINE D
    if gold > 10:
        $ mood = "confident"
        e "Feeling wealthy today!"
    else:
        $ mood = "cautious"
        e "I'd better be careful with my spending."
    # Question: Which branch ran? What is mood now?

    # LINE E
    $ has_key = True
    e "I just found a key!"
    # Question: What is has_key now?

    # LINE F
    if has_key and gold >= 15:
        e "I have a key AND enough gold. I'm ready for anything."
    elif has_key:
        e "I have a key but I'm running low on gold."
    else:
        e "No key and not much gold. This could be tough."
    # Question: Which branch ran? (Check has_key AND gold at this point)

    # LINE G
    $ gold += 100
    $ has_key = False
    $ mood = "confused"

    if not has_key:
        e "Somehow I lost the key. Typical."
    else:
        e "Key is safe in my pocket."
    # Question: Which branch ran?  (Hint: read "not has_key" carefully)

    e "Final gold: [gold].  Mood: [mood]."
    return


## ============================================================
##  *** ANSWERS — TEACHER REFERENCE — DON'T SHOW STUDENTS FIRST ***
## ============================================================
##
##  Starting (LINE A):
##    gold    = 10
##    has_key = False
##    mood    = "nervous"
##
##  After LINE B  ($ gold = gold * 2)
##    gold    = 20        (10 × 2)
##    has_key = False     (unchanged)
##    mood    = "nervous" (unchanged)
##
##  After LINE C  ($ gold -= 5)
##    gold    = 15        (20 - 5)
##    has_key = False
##    mood    = "nervous"
##
##  After LINE D  (if gold > 10:)
##    gold > 10  →  15 > 10  →  TRUE
##    → first branch runs
##    gold    = 15
##    mood    = "confident"
##    Dialogue: "Feeling wealthy today!"
##
##  After LINE E  ($ has_key = True)
##    has_key = True
##    Dialogue: "I just found a key!"
##
##  After LINE F  (if has_key and gold >= 15:)
##    has_key is True  AND  gold (15) >= 15  →  TRUE
##    → first branch runs
##    Dialogue: "I have a key AND enough gold. I'm ready for anything."
##
##  After LINE G  ($ gold += 100, $ has_key = False, $ mood = "confused")
##    gold    = 115
##    has_key = False
##    mood    = "confused"
##    if not has_key:   →  not False  →  TRUE
##    → first branch runs
##    Dialogue: "Somehow I lost the key. Typical."
##    Final dialogue: "Final gold: 115.  Mood: confused."
##
##  COMPLETED TRACE TABLE:
##  ┌───────────┬───────┬──────────┬────────────┬──────────────────────────────────┐
##  │  After... │ gold  │  has_key │    mood    │  Dialogue shown                  │
##  ├───────────┼───────┼──────────┼────────────┼──────────────────────────────────┤
##  │  LINE A   │  10   │  False   │ "nervous"  │  (none yet)                      │
##  │  LINE B   │  20   │  False   │ "nervous"  │  (none yet)                      │
##  │  LINE C   │  15   │  False   │ "nervous"  │  "I have 15 gold coins..."       │
##  │  LINE D   │  15   │  False   │ "confident"│  "Feeling wealthy today!"        │
##  │  LINE E   │  15   │  True    │ "confident"│  "I just found a key!"           │
##  │  LINE F   │  15   │  True    │ "confident"│  "key AND enough gold..."        │
##  │  LINE G   │  115  │  False   │ "confused" │  "Somehow I lost the key."       │
##  │           │       │          │            │  "Final gold: 115. Mood: confused"│
##  └───────────┴───────┴──────────┴────────────┴──────────────────────────────────┘
##
## ============================================================
