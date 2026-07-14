# ============================================================
#  DAY 7 — EXAMPLE 5: Secret Ending (Challenge Level ⭐⭐⭐)
#
#  CONCEPTS COVERED:
#    • default  — declare a variable with a starting value
#    • $        — the Python line prefix; changes a variable
#    • if / elif / else  inside labels
#    • A hidden ending only unlocked by a specific choice combo
#
#  HOW THE SECRET WORKS:
#    The player makes TWO choices. Only if they pick the
#    "specific" option both times does the secret ending unlock.
#    Otherwise they get one of the two normal endings.
#
#  NOTE FOR STUDENTS:
#    Variables are officially Day 8 content — this file is
#    a PREVIEW for students who want to go further today.
# ============================================================

# Declare a variable called 'trust' that starts at 0.
# Every time the player makes the "trusting" choice, we add 1.
# If trust reaches 2, they unlock the secret ending.
default trust = 0


label start:

    scene bg_station
    with fade

    "You are waiting at a train station."
    "A stranger sits down next to you — they look worried."

    define s = Character("Stranger", color="#00D4B1")
    define y = Character("You", color="#FFD166")

    s "I don't suppose you have a spare ticket?"
    s "I lost mine and the next train is the last one tonight."

    # ── CHOICE 1 ──────────────────────────────────────────
    menu:
        "Give them your spare ticket":
            $ trust += 1        # trust goes from 0 to 1
            y "Here — I have an extra."
            s "Oh! Thank you. Really."
            jump scene_two

        "Sorry, I only have one":
            y "Sorry, I only have one."
            s "Of course. No worries."
            jump scene_two


# ──────────────────────────────────────────────────────────
label scene_two:

    "The train arrives."
    "The stranger boards, then turns back."

    s "Are you getting on?"

    # ── CHOICE 2 ──────────────────────────────────────────
    menu:
        "Yes — sit with them":
            $ trust += 1        # trust goes from 1 to 2 (or 0 to 1)
            y "Sure, why not?"
            jump check_ending

        "No — wait for the next one":
            y "I'll catch the next train."
            s "Suit yourself. Safe travels."
            jump ending_alone


# ──────────────────────────────────────────────────────────
#  After choice 2, we CHECK the trust score
#  and jump to the right ending.
# ──────────────────────────────────────────────────────────
label check_ending:

    if trust >= 2:
        jump ending_secret      # Both choices were trusting → secret!
    else:
        jump ending_normal      # Only one trusting choice → normal end


# ──────────────────────────────────────────────────────────
label ending_normal:

    scene bg_train
    with dissolve

    "You ride the train in comfortable silence."
    "The stranger falls asleep before the first stop."
    "It is a perfectly ordinary evening."

    "           ~ THE END: Ordinary Journey ~"
    return


# ──────────────────────────────────────────────────────────
label ending_alone:

    scene bg_station
    with fade

    "The train pulls away."
    "The platform is empty now."
    "The next train is in four hours."
    "You find a bench and open a book."

    "           ~ THE END: The Long Wait ~"
    return


# ──────────────────────────────────────────────────────────
#  SECRET ENDING — only reachable if trust == 2
# ──────────────────────────────────────────────────────────
label ending_secret:

    scene bg_train
    with dissolve

    "You sit across from the stranger."
    "They tell you they are heading to a music festival."
    "You mention you had tickets but never went."
    "They pull out a spare wristband from their jacket pocket."

    s "This is clearly meant to be."

    "You spend the weekend at the festival."
    "You are still friends, three years later."

    "           ★ SECRET END: The Wristband ★"
    "      (Unlocked by trusting the stranger twice)"
    return
