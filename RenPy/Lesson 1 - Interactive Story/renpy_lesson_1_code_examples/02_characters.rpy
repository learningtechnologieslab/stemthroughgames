# ============================================================
#  STEM THROUGH GAMES — Introduction to RenPy
#  Example 2: Characters
#  Concept: Defining characters and giving them dialogue
# ============================================================
#
#  WHAT THIS TEACHES:
#    - The "define" keyword creates a character
#    - Characters have a name and a color for their name tag
#    - Characters "say" lines by putting their variable before quotes
#    - The narrator (no character) uses plain quotes
#
#  KEY SYNTAX:
#    define <variable> = Character("<Name>", color="<hex color>")
#    <variable> "<what they say>"
#
#  TRY IT:
#    - Change the name inside the quotes
#    - Change the color hex code (e.g., "#ff0000" is red)
#    - Add a third character called "stranger"
# ============================================================

# ── CHARACTER DEFINITIONS ────────────────────────────────────
# These go at the TOP of the file, before "label start"

define maya = Character("Maya", color="#00c9a7")   # teal name tag
define leo  = Character("Leo",  color="#ffd166")   # gold name tag


# ── THE STORY ────────────────────────────────────────────────
label start:

    # The narrator sets the scene (plain quotes = no speaker name)
    "It was a quiet afternoon in the school library."

    # Maya speaks — her name appears above the text box
    maya "I can't believe we have to write a five-page essay by Friday."

    # Leo responds
    leo "Five pages? I thought it was three!"

    maya "Nope. Ms. Chen changed it this morning."

    leo "..."

    # Narrator again
    "Leo stared at the ceiling for a long moment."

    leo "Okay. I guess we're staying late today."

    maya "That's the spirit."

    return
