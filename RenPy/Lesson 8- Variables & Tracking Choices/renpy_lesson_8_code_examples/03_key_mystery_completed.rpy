## ============================================================
##  DAY 8 — EXAMPLE 3: The Key Mystery  (COMPLETED REFERENCE)
##  STEM Through Games · Ren'Py Programming
## ============================================================
##
##  CONCEPT:  Boolean variable + if / elif / else branching.
##
##  This is the FINISHED version of the starter activity.
##  Use it to check your work AFTER you've tried Example 02.
##
##  WHAT'S NEW vs the starter:
##    ✓  TODO 1 filled in — has_key set to True on pick-up
##    ✓  TODO 2 filled in — if / elif / else at the gate
##    ✓  Extension A included — has_badge + elif branch
##    ✓  Inline comments explain every decision
##
## ============================================================

# ── CHARACTER DEFINITIONS ─────────────────────────────────────
define e = Character("Explorer", color="#5EC8E5")
define g = Character("Guard",    color="#E5A85E")
define s = Character("Scholar",  color="#B5E55E")


# ── VARIABLE DECLARATIONS ─────────────────────────────────────
#
#   Two variables this time.
#   Both start as False — neither item has been picked up yet.

default has_key   = False   # True once the player finds the iron key
default has_badge = False   # True if the player helped the scholar


# ── MAIN STORY ────────────────────────────────────────────────
label start:

    scene bg bg_forest with fade

    e "I wake up at the edge of a strange forest."
    e "The trees are twisted and the sky is an odd shade of purple."

    # ── SCHOLAR DETOUR (optional badge opportunity) ────────────
    #
    #   Before the gate, the player meets a scholar who needs help.
    #   Helping grants has_badge = True — a second way past the guard.

    scene bg bg_forest with dissolve

    s "Excuse me, traveller! Could you help me find my lost notebook?"

    menu:
        "\"Of course — I'll keep an eye out.\"":
            $ has_badge = True            # Player earns the badge
            s "Wonderful! Please take this Scholar's Badge."
            s "It proves you're a friend of the Academy."
            e "I pin the badge to my coat."

        "\"Sorry, I'm in a hurry.\"":
            s "Oh... I understand. Safe travels."
            e "I walk on, a little guilty."

    # ── KEY PICKUP ────────────────────────────────────────────

    e "As I take my first step down the path, something catches the light."
    e "There's a small object half-buried in the dirt."

    menu:

        "Pick up the glinting object.":
            $ has_key = True              # ← TODO 1 answer
            e "I brush off the dirt. It's an old iron key!"
            e "I slip it into my pocket."

        "Ignore it and keep walking.":
            e "Probably just a bottle cap. I walk on."

    jump locked_gate


# ── LOCKED GATE ───────────────────────────────────────────────
label locked_gate:

    scene bg bg_castle_gate with fade

    g "Halt! This gate is sealed."
    g "No one enters without authorisation."

    # ── if / elif / else — THREE possible outcomes ─────────────
    #
    #   Python evaluates the conditions TOP TO BOTTOM and runs
    #   the FIRST block whose condition is True, then skips the rest.
    #
    #   Priority order here:
    #     1. Has the key?      → highest privilege, go straight in
    #     2. Has the badge?    → scholar's voucher, guard accepts it
    #     3. Neither?          → turned away

    if has_key:
        # Condition: has_key is True
        g "Wait — is that the master key?!"
        g "I haven't seen one of those in years."
        g "Go right ahead, traveller."
        jump inside_castle

    elif has_badge:
        # Condition: has_key is False, BUT has_badge is True
        g "Hmm... no key, but..."
        g "Is that a Scholar's Badge? The Academy is always welcome here."
        g "I'll make an exception. In you go."
        jump inside_castle

    else:
        # Condition: BOTH are False — nothing to show the guard
        g "No key, no badge, no entry."
        g "Come back when you have proper authorisation."
        jump turned_away


# ── ENDINGS ───────────────────────────────────────────────────
label inside_castle:

    scene bg bg_inside_castle with fade

    e "The gate groans and swings open."
    e "I step inside the castle courtyard."

    # Show a different message depending on HOW they got in.
    # This is another if/elif — variables can be checked anywhere!

    if has_key and has_badge:
        e "I have both the key and the badge. I came very prepared."
    elif has_key:
        e "The iron key worked. Lucky I picked it up."
    elif has_badge:
        e "The scholar's badge got me through. Kindness pays off."

    e "My adventure truly begins..."
    jump ending


label turned_away:

    scene bg bg_forest with fade

    e "I stare at the locked gate."
    e "There must be something I missed out there."
    e "I turn back toward the forest."
    jump ending


label ending:

    e "Whatever happens next... that's a story for another day."
    return


## ============================================================
##  TEACHER NOTES
## ============================================================
##
##  VARIABLES in this file:
##    has_key   (Boolean)  — set True if player picks up the iron key
##    has_badge (Boolean)  — set True if player helps the scholar
##
##  LOGIC TRACE — walk students through these scenarios:
##
##    Scenario A: helped scholar + picked up key
##      has_badge = True,  has_key = True
##      → if has_key: → TRUE  → "master key" dialogue → inside_castle
##      (elif is never checked because if was True)
##
##    Scenario B: helped scholar, skipped key
##      has_badge = True,  has_key = False
##      → if has_key: → FALSE
##      → elif has_badge: → TRUE → "Scholar's Badge" → inside_castle
##
##    Scenario C: skipped scholar, picked up key
##      has_badge = False,  has_key = True
##      → if has_key: → TRUE  → inside_castle
##
##    Scenario D: skipped everything
##      has_badge = False,  has_key = False
##      → if: FALSE,  elif: FALSE,  else: → turned_away
##
##  DISCUSSION: How many unique paths through this story are there?
##    Count them!  (Answer: 2 choices × 2 choices = 4 combinations,
##    but only 3 distinct endings at the gate.)
##
## ============================================================
