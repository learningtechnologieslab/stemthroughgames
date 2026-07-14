# ============================================================
#  DAY 7 — EXAMPLE 6: Student Starter Template
#  Fill in the blanks to build your own branching story!
#
#  Instructions:
#    1. Replace every  ___  with your own words or label names
#    2. Run it in RenPy after each change to test it
#    3. Add more dialogue lines wherever you like
#    4. When it works, try adding a second menu in one path!
#
#  FILL-IN GUIDE:
#    [YOUR SCENE]   → name of a background image (or leave as bg_room)
#    [YOUR TEXT]    → narration or dialogue — put it in quotes
#    [CHOICE A]     → what the player can pick (e.g. "Run away")
#    [CHOICE B]     → the other option (e.g. "Stand your ground")
#    [LABEL_A]      → a short name for path A, no spaces (e.g. run_path)
#    [LABEL_B]      → a short name for path B (e.g. stand_path)
# ============================================================

# ── Optional: define a character ──────────────────────────
# Uncomment the line below and replace the name + color.
# define hero = Character("___", color="#FF6B6B")


label start:

    # Set the background. Replace bg_room with your scene name.
    scene bg_room
    with fade

    # Opening narration — set the scene for the player.
    "[YOUR OPENING TEXT — describe where the player is]"
    "[Add another line to build atmosphere]"

    # The question / dilemma — what decision must they make?
    "[YOUR DILEMMA — what does the player need to choose?]"

    # ── YOUR MENU ─────────────────────────────────────────
    menu:
        "[CHOICE A]":
            jump path_a         # <-- replace path_a with [LABEL_A]

        "[CHOICE B]":
            jump path_b         # <-- replace path_b with [LABEL_B]


# ── PATH A ────────────────────────────────────────────────
label path_a:       # <-- rename this to match your jump target above

    scene bg_room   # <-- change to a different background if you have one
    with dissolve

    "[What happens when the player picks Choice A?]"
    "[Add more lines — at least 3!]"
    "[Build toward your ending...]"

    jump ending_a


# ── PATH B ────────────────────────────────────────────────
label path_b:       # <-- rename this to match your jump target above

    scene bg_room   # <-- change to a different background if you have one
    with dissolve

    "[What happens when the player picks Choice B?]"
    "[Add more lines — at least 3!]"
    "[Build toward your ending...]"

    jump ending_b


# ── ENDING A ─────────────────────────────────────────────
label ending_a:

    "[Your first ending — 3+ lines]"
    "[What emotion do you want the player to feel?]"
    "[Last line before THE END]"

    "   ~ THE END: [Name your ending] ~"

    return      # <-- don't forget this!


# ── ENDING B ─────────────────────────────────────────────
label ending_b:

    "[Your second ending — make it feel DIFFERENT from ending A]"
    "[Different tone: hopeful vs. sad, exciting vs. calm, etc.]"
    "[Last line before THE END]"

    "   ~ THE END: [Name your ending] ~"

    return      # <-- don't forget this!


# ============================================================
#  CHECKLIST — before you call it done:
#   [ ] Both menu choices work (test each one!)
#   [ ] Each path has at least 3 lines of story
#   [ ] Both endings have a name
#   [ ] Both endings end with  return
#   [ ] The two endings feel emotionally different
#   [ ] No RenPy errors when you launch
# ============================================================
