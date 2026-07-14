# =============================================================================
#  DAY 10 INDEPENDENT PRACTICE — Scaffolded Template
#  STEM Through Games | Ren'Py Unit
# =============================================================================
#
#  This template is for students who want a little extra structure.
#  Fill in every blank marked with  ___________
#  Then run the game and make sure BOTH branches work!
#
#  YOUR STORY SETUP:
#    You can change the theme to anything you like — a spaceship, a haunted
#    house, a sports locker room, a fantasy dungeon... your choice!
#    Just keep the structure: one Boolean item, one locked moment.
#
# =============================================================================


# STEP 1 — Declare your Boolean variable
# Pick a name for the item your player can find.
# Examples: has_sword / has_badge / has_ticket / has_map / has_password

default ___________ = False        # ← replace ___ with your variable name


# STEP 2 — Name your characters (optional: change the names)
define narrator = Character(None)
define player   = Character("You")


# =============================================================================
#  SCENE: start
#  Set the scene. Where does your story take place?
# =============================================================================

label start:

    scene black with fade

    # Describe where the player is. Write 2–3 lines of narration.
    "___________"
    "___________"

    jump find_item_scene


# =============================================================================
#  SCENE: find_item_scene
#  The player discovers the item and chooses whether to take it.
# =============================================================================

label find_item_scene:

    # Describe what the player finds. What does the item look like?
    "___________"

    menu:

        # Write the "yes, take it" choice text here:
        "___________":
            $ ___________ = True        # ← same variable name as line 23
            player "___________"        # What does the player say or think?
            "___________"               # One line of narration

        # Write the "no, leave it" choice text here:
        "___________":
            player "___________"        # What does the player say?

    jump locked_moment_scene


# =============================================================================
#  SCENE: locked_moment_scene
#  The moment that REQUIRES the item. This is where your if/else lives!
# =============================================================================

label locked_moment_scene:

    # Set up the locked moment. What is the player trying to do?
    "___________"

    # -------------------------------------------------------------------------
    #  YOUR if/else BLOCK — fill in every blank
    #
    #  REMINDERS:
    #    • Colon after "if ___________"
    #    • Colon after "else"
    #    • 4 spaces of indent inside each block
    #    • At least 3 lines of dialogue in EACH branch
    # -------------------------------------------------------------------------

    if ___________:                     # ← your variable name

        # Branch A: player HAS the item — write 3+ lines
        player "___________"
        "___________"
        "___________"
        jump success_scene

    else:

        # Branch B: player does NOT have the item — write 3+ lines
        player "___________"
        "___________"
        "___________"
        jump find_item_scene            # Send them back to try again


# =============================================================================
#  SCENE: success_scene
#  The reward — the player made it! Write a satisfying ending.
# =============================================================================

label success_scene:

    "___________"
    "___________"
    "___________"

    "              ★  THE END  ★             "

    return


# =============================================================================
#  SELF-CHECK QUESTIONS before you show your teacher:
#
#    1. Does "default ___ = False" appear at the top of the file?
#    2. Does the menu have exactly 2 choices?
#    3. Does one choice set your variable to True with $ ___ = True ?
#    4. Does your if/else block have colons after both "if ___" and "else"?
#    5. Are the lines inside if and else indented by 4 spaces?
#    6. Do both branches have at least 3 lines of dialogue?
#    7. Have you run the game and tested BOTH paths?
#
# =============================================================================
