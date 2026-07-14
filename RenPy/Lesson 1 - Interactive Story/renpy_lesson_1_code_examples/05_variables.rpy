# ============================================================
#  STEM THROUGH GAMES — Introduction to RenPy
#  Example 5: Variables & Consequences
#  Concept: Storing player choices so they matter later
# ============================================================
#
#  WHAT THIS TEACHES:
#    - Variables store information (like a memory for your game)
#    - "default" sets a variable's starting value
#    - "$" runs a line of Python code (used to set variables)
#    - "if / elif / else" checks a variable and runs different
#      dialogue depending on its value
#
#  KEY SYNTAX:
#    default my_variable = False      ← starting value
#    $ my_variable = True             ← change the value
#    if my_variable:                  ← check the value
#        "This runs if it's True"
#    else:
#        "This runs if it's False"
#
#  THIS IS THE STEM CONNECTION:
#    Variables and if/else are real programming concepts.
#    Every branching story is powered by logic like this!
#
#  TRY IT:
#    - Add a second variable called "told_truth"
#    - Change the ending based on both variables
# ============================================================

define sam   = Character("Sam",   color="#00c9a7")
define jordan = Character("Jordan", color="#ffd166")

# ── VARIABLES ────────────────────────────────────────────────
# These are the game's "memory". They start with default values.
default helped_stranger = False
default kindness_points = 0


# ── THE STORY ────────────────────────────────────────────────
label start:

    "Sam is walking to the cafeteria when they see someone drop their tray."

    "A student they don't know is scrambling to pick up their food."

    menu:
        "Stop and help them pick it up.":
            $ helped_stranger = True     # store the choice
            $ kindness_points += 1       # add 1 to the counter
            sam "Here, let me help you with that."
            "The stranger smiled gratefully."

        "Keep walking — you'll be late.":
            $ helped_stranger = False    # store the choice
            sam "..."
            "Sam walked past, feeling a little guilty."

    "Sam arrived at the table where Jordan was already eating."

    jordan "Hey! How was your morning?"

    # ── CONSEQUENCE: the story remembers what the player did ──
    if helped_stranger:
        # This only runs if helped_stranger is True
        sam "Pretty good, actually. I helped someone in the hall."
        jordan "That's so you. No wonder everyone likes you."

    else:
        # This runs if helped_stranger is False
        sam "Fine, I guess. I kind of ignored someone who needed help."
        jordan "Oof. You okay?"
        sam "Not really. Maybe I'll apologize tomorrow."

    # ── ANOTHER BRANCH: checking the numeric variable ─────────
    "Later that day, the teacher announced a group project."

    if kindness_points >= 1:
        "The stranger from the hallway ended up in Sam's group."
        "They recognized Sam immediately and grinned."
        sam "Oh! Hi again."
        "It turned out to be a great project."

    else:
        "Sam ended up in a group of people they didn't know at all."
        "It was a little awkward at first."
        sam "(I should really try to be friendlier.)"

    return
