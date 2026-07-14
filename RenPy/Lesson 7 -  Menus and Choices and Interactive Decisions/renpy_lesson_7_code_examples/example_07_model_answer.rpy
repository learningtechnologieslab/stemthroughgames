# ============================================================
#  DAY 7 — EXAMPLE 7: Model Answer — "The Signal"
#  What a strong completed student story looks like.
#
#  Show this to students AFTER they've attempted their own —
#  not before, so they don't just copy it.
#
#  WHAT MAKES THIS A STRONG EXAMPLE:
#    ✓ Opening narration establishes mood immediately
#    ✓ The choice has a real trade-off — neither option is "safe"
#    ✓ Both paths develop the story before the ending
#    ✓ Endings are distinct in tone (wonder vs. relief)
#    ✓ Character has a consistent voice throughout
#    ✓ All labels are clearly named
#    ✓ All labels end with return
#    ✓ No crashes — indentation is correct throughout
# ============================================================

define maya = Character("Maya", color="#6C63FF")
define voice = Character("???", color="#FF6B6B")


label start:

    scene bg_rooftop_night
    with fade

    "The city hums sixteen floors below you."
    "Maya stands on the rooftop of her apartment building, phone in hand."
    "The message arrived three minutes ago, from a number she doesn't recognise."

    maya "Follow the signal. Midnight. Don't bring anyone."

    "Below, the streetlights flicker — once, twice — then steady again."
    "Her phone buzzes. Same number. One word: NOW."

    maya "This is either the worst idea I've ever had..."
    maya "...or the best."

    menu:
        "Follow the signal — go to the rooftop edge":
            jump follow_signal

        "Delete the message and go back inside":
            jump ignore_signal


# ──────────────────────────────────────────────────────────
label follow_signal:

    scene bg_rooftop_edge
    with dissolve

    "Maya walks to the edge of the roof."
    "A small drone hovers at eye level, a package strapped beneath it."
    "A speaker crackles."

    voice "Take it. You've been chosen."

    maya "Chosen for what, exactly?"

    voice "Open the package."

    "Inside: a key card, a map of the city, and a photograph."
    "The photograph is of Maya. Taken this morning. She was alone."

    maya "Okay. I'm listening."

    "The drone blinks twice — and she understands."
    "Tonight, everything changes."

    jump ending_chosen


# ──────────────────────────────────────────────────────────
label ignore_signal:

    scene bg_apartment
    with dissolve

    "Maya deletes the message."
    "She makes tea. She watches something forgettable on TV."
    "Around 2am, she checks her phone — the number is gone."
    "Not blocked. Gone, as if it never existed."

    maya "Good. Fine. Normal is good."

    "She sleeps deeply for the first time in weeks."
    "In the morning, the rooftop door is sealed with a lock she's never seen."
    "She doesn't try to open it."

    maya "Some things are not mine to know."

    jump ending_ordinary


# ──────────────────────────────────────────────────────────
label ending_chosen:

    scene bg_rooftop_night
    with fade

    "The city looks different from up here now."
    "Not smaller — more connected. Like she can see the threads."
    "She tucks the key card into her pocket."
    "She has until sunrise."

    "                  ~ THE END ~"
    "              The Signal Route"
    "         [tone: wonder, possibility, risk]"

    return


# ──────────────────────────────────────────────────────────
label ending_ordinary:

    scene bg_apartment
    with fade

    "Maya wakes up to sunshine and the smell of her neighbour's coffee."
    "The city is loud and warm and completely normal."
    "She gets on with her day."
    "Whatever it was — it was meant for someone braver."
    "And that is perfectly okay."

    "                  ~ THE END ~"
    "             The Quiet Route"
    "      [tone: peace, self-acceptance, relief]"

    return
