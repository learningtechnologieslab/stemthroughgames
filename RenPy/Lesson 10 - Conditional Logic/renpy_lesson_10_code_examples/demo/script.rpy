# =============================================================================
#  DAY 10 TEACHER DEMO — The Door Scene
#  STEM Through Games | Ren'Py Unit
# =============================================================================
#
#  PURPOSE:
#    This is the live-coding demo the teacher types on the projector during
#    Phase 2 (Direct Instruction). Walk through it line by line. Students
#    watch first, then type along on the second pass.
#
#  WHAT THIS DEMONSTRATES:
#    1. Declaring a Boolean variable with "default"
#    2. A player menu that sets has_key = True
#    3. An if/else block that changes the story outcome
#    4. Using "jump" to move between labeled scenes
#
#  HOW TO USE:
#    • Open this file in the Ren'Py launcher, then click "Launch Project"
#    • Play through twice: once picking up the key, once ignoring it
#    • Ask students to predict what will happen before each run
#
# =============================================================================


# -----------------------------------------------------------------------------
#  STEP 1 — Declare our Boolean variable
# -----------------------------------------------------------------------------
#
#  "default" tells Ren'Py: "this variable exists, and starts as False."
#  False = the player does NOT have the key yet.
#  We put ALL default declarations at the very top of the script.
#
#  Syntax:   default <variable_name> = <starting_value>

default has_key = False      # The player starts WITHOUT the key


# -----------------------------------------------------------------------------
#  STEP 2 — Define our characters
# -----------------------------------------------------------------------------

define narrator = Character(None, kind=nvl)     # Narration (no name shown)
define player   = Character("You")              # The player character


# =============================================================================
#  SCENE: start
#  This is always the first label Ren'Py looks for.
# =============================================================================

label start:

    scene black with fade

    # Setting the scene — narration sets the mood
    "You wake up in a dimly lit hallway. The air smells of dust and old wood."
    "A heavy iron door stands at the far end. Beside you is a small wooden table."

    jump examine_table     # Jump to the next scene automatically


# =============================================================================
#  SCENE: examine_table
#  The player discovers a key and decides whether to take it.
# =============================================================================

label examine_table:

    "You walk over to the table. A rusty iron key rests on top of it, half-hidden under a scrap of cloth."

    # -------------------------------------------------------------------------
    #  THE MENU — gives the player a choice
    #  Each choice is indented under "menu:"
    #  The text in quotes is what the player sees and clicks
    # -------------------------------------------------------------------------

    menu:

        "Pick up the key.":
            # ----------------------------------------------------------------
            #  THE ASSIGNMENT — the dollar sign ($) means "run Python here"
            #  This is how we SET a variable inside a scene.
            #
            #  Syntax:   $ <variable_name> = <new_value>
            # ----------------------------------------------------------------
            $ has_key = True          # Now the player HAS the key!

            player "You pocket the key. It feels heavier than it looks."
            "You sense this might be important later."

        "Leave it. It's probably not important.":
            # has_key stays False — we don't need to write anything here
            player "You leave the key on the table and walk away."
            "A small voice in the back of your mind wonders if that was wise."

    jump try_door     # After the menu, always go try the door


# =============================================================================
#  SCENE: try_door
#  This is where the if/else conditional logic lives.
#  The story BRANCHES based on whether has_key is True or False.
# =============================================================================

label try_door:

    "You approach the iron door. There is a large keyhole in the center."

    # -------------------------------------------------------------------------
    #  THE CONDITIONAL — this is the heart of today's lesson!
    #
    #  Syntax:
    #    if <condition>:          ← colon is REQUIRED
    #        <indented code>      ← 4 spaces of indentation REQUIRED
    #    else:                    ← colon is REQUIRED
    #        <indented code>      ← 4 spaces of indentation REQUIRED
    #
    #  When Ren'Py reaches this point:
    #    • It checks: is has_key equal to True?
    #    • If YES  → runs the "if" block
    #    • If NO   → skips to "else" and runs that block instead
    # -------------------------------------------------------------------------

    if has_key:
        # This block runs ONLY if has_key is True
        player "You reach into your pocket and pull out the rusty key."
        "The key slides into the lock with a satisfying click."
        "The door swings open, revealing a staircase leading upward."
        jump inside_room

    else:
        # This block runs ONLY if has_key is False
        player "You grab the door handle and pull. Nothing happens."
        "The door is locked tight. You'll need a key."
        "You remember the table back down the hall..."
        jump examine_table     # Send them back to try again!


# =============================================================================
#  SCENE: inside_room
#  The "good ending" — only reachable if the player had the key.
# =============================================================================

label inside_room:

    scene black with fade

    "You climb the staircase and emerge into a sunlit room."
    "Fresh air rushes past you. You made it."
    "                    "
    "    ★  THE END  ★   "
    "                    "
    "[ This scene was only reachable because has_key was True! ]"

    return     # "return" ends the game / goes back to the main menu


# =============================================================================
#  TEACHER DEBRIEF QUESTIONS (after running):
#
#  1. What was has_key equal to when the game started? (False)
#  2. Which line changed has_key to True? ($ has_key = True)
#  3. What happened when you chose NOT to pick up the key?
#  4. Could you reach inside_room without the key? Why not?
#  5. What would happen if you deleted the "else" block entirely?
#
# =============================================================================
