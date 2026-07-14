# ============================================================
#  STEM THROUGH GAMES — Introduction to RenPy
#  Example 3: Player Choices
#  Concept: The "menu" block — the heart of a visual novel
# ============================================================
#
#  WHAT THIS TEACHES:
#    - The "menu:" block creates a choice screen for the player
#    - Each choice is a string followed by a colon
#    - The code INDENTED under a choice runs when it is picked
#    - After a choice block, the story continues from the same place
#
#  KEY SYNTAX:
#    menu:
#        "Choice text A":
#            <code that runs for A>
#        "Choice text B":
#            <code that runs for B>
#
#  IMPORTANT — INDENTATION:
#    RenPy (like Python) uses spaces to know what belongs where.
#    The menu: keyword is indented 4 spaces inside "label start".
#    Each choice label is indented 4 more spaces inside "menu:".
#    The lines under each choice are indented 4 more spaces again.
#
#  TRY IT:
#    - Add a third choice option
#    - Change what each character says for each choice
# ============================================================

define maya = Character("Maya", color="#00c9a7")
define leo  = Character("Leo",  color="#ffd166")


label start:

    "Maya and Leo are walking home after school."

    maya "There's a shortcut through the old park, or we can take the long way."

    leo "Hmm. What should we do?"

    # ── THE PLAYER CHOICE ────────────────────────────────────
    menu:

        "Take the shortcut through the park.":
            # This block runs ONLY if the player picks this option
            leo "Let's go through the park — it'll be faster."
            maya "Good call. I'm starving."
            "They took the shortcut. It was indeed much faster."

        "Take the long way home.":
            # This block runs ONLY if the player picks this option
            leo "Let's just take the long way. I'm not in a hurry."
            maya "Okay, but you're carrying my backpack then."
            leo "...Deal."
            "They walked the long way. It was peaceful."

    # ── STORY CONTINUES HERE FOR BOTH CHOICES ────────────────
    # No matter which option the player picked, they both reach this line.
    "Eventually, they both made it home safely."

    maya "Same time tomorrow?"

    leo "Same time tomorrow."

    return
