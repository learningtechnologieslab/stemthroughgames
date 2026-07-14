# ============================================================
# DAY 5 — EXAMPLE 5: Extension — Character Name Colors
# STEM Through Games | Introduction to Ren'Py
# ============================================================
#
# PURPOSE:
#   For students who finish early or want to go further.
#   Learn how to give each character's name a different color
#   in the dialogue box — just like in professional visual novels!
#
# CONCEPTS COVERED:
#   - The "color" parameter inside Character()
#   - Hex color codes (#RRGGBB format)
#   - How parameters work in Ren'Py functions
#
# NEW SYNTAX:
#
#   define a = Character("Alex", color="#00BFFF")
#                                 └─ Parameter name
#                                          └─ Hex color code (with # prefix)
#
# NOTE: In Ren'Py's Character(), hex colors DO use the # symbol.
#       This is different from some other parts of Ren'Py!
#
# ── HEX COLOR QUICK REFERENCE ────────────────────────────────────────────────
#
#   #FF0000 = Red          #00FF00 = Green        #0000FF = Blue
#   #FFFF00 = Yellow       #FF00FF = Magenta       #00FFFF = Cyan
#   #FFFFFF = White        #000000 = Black         #FFA500 = Orange
#   #00BFFF = Sky Blue     #9B59B6 = Purple        #2ECC71 = Emerald
#   #E74C3C = Soft Red     #F39C12 = Amber         #1ABC9C = Teal
#
#   Tip: Search "hex color picker" in any browser to find any color!
# ============================================================


# ── CHARACTERS WITH COLORS ───────────────────────────────────────────────────

# Alex's name will appear in sky blue
define a = Character("Alex", color="#00BFFF")

# Jordan's name will appear in soft orange
define j = Character("Jordan", color="#FFA500")

# Maya's name will appear in emerald green
define m = Character("Maya", color="#2ECC71")

# The narrator has no color because it uses no variable
# (plain strings are always the default text color)


# ── THE SCRIPT ───────────────────────────────────────────────────────────────

label start:

    "Three friends met in the school library after class."

    a "Has anyone started the science project yet?"

    j "I made a list of ideas, but I haven't picked one."

    m "I was thinking — what if we built a weather station?"

    a "That sounds amazing! We could put sensors outside."

    j "And track the data over a whole month!"

    m "Exactly. Each of us could handle a different part."

    "They leaned over the table, already sketching out their plan."

    a "This is going to be our best project yet."

    return


# ── WHAT TO NOTICE WHEN YOU RUN THIS ────────────────────────────────────────
#
#   ✓ Each character's name appears in a DIFFERENT color above the text box
#   ✓ This makes it much easier to follow who is speaking at a glance
#   ✓ Narrator text stays the default color (no variable = no color setting)
#   ✓ Three define lines — one per character, each with a unique variable
#
# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
#
#   1. Change the color codes to your favorite colors
#   2. Rename the characters to your own original names
#   3. Rewrite the dialogue to fit your own story idea
#   4. Try adding a 4th character with yet another color!
#
# ── DESIGN TIP ───────────────────────────────────────────────────────────────
#
#   Choose colors that:
#     - Are bright enough to read on a dark background
#     - Feel right for each character's personality
#       (e.g., a cold villain might get icy blue, a cheerful friend gets yellow)
#     - Are different enough from each other that players can tell them apart
