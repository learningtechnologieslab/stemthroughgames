# =============================================================================
#  DAY 10 GUIDED PRACTICE — The Abandoned Lab
#  STEM Through Games | Ren'Py Unit
# =============================================================================
#
#  INSTRUCTIONS FOR STUDENTS:
#    This file has THREE places marked with # TODO where you need to write
#    your own if/else blocks. Each TODO tells you exactly what to do.
#
#    TASK 1 — Do together as a class (teacher codes on projector)
#    TASK 2 — Complete with your partner
#    TASK 3 — Extension challenge (if you finish early!)
#
#  CHECKLIST before running:
#    □  Every "if" has a colon at the end
#    □  Every "else" has a colon at the end
#    □  The lines INSIDE if and else are indented (4 spaces)
#    □  Each variable is spelled EXACTLY the same everywhere
#
# =============================================================================


# -----------------------------------------------------------------------------
#  VARIABLE DECLARATIONS — already done for you!
#  These are the three items the player can find in the lab.
# -----------------------------------------------------------------------------

default has_keycard   = False    # Used to open the security door
default has_flashlight = False   # Used to read in the dark storage room
default has_passcode  = False    # Used to unlock the server terminal


# -----------------------------------------------------------------------------
#  CHARACTERS
# -----------------------------------------------------------------------------

define narrator = Character(None)
define player   = Character("You")
define computer = Character("TERMINAL", color="#00FF41")    # Green, like an old monitor


# =============================================================================
#  SCENE: start
# =============================================================================

label start:

    scene black with fade

    "The year is 2031. You are a junior technician sent to investigate\nan abandoned research lab that went dark three years ago."
    "Your mission: find out what happened to the research data."
    "                "
    "You step through the broken front door. Your footsteps echo."

    jump main_corridor


# =============================================================================
#  SCENE: main_corridor
#  The central hub — the player can explore different rooms from here.
# =============================================================================

label main_corridor:

    "You stand in the main corridor. Three paths branch off:"
    "To the LEFT: a storage room, dark as pitch."
    "Straight AHEAD: a security door with a keycard reader."
    "To the RIGHT: a server room with a glowing terminal."

    menu:
        "Go left — check the storage room.":
            jump storage_room

        "Go straight — try the security door.":
            jump security_door

        "Go right — look at the terminal.":
            jump server_terminal

        "Examine the reception desk first.":
            jump reception_desk


# =============================================================================
#  SCENE: reception_desk
#  This is where the player can find the keycard.
# =============================================================================

label reception_desk:

    "You rummage through the reception desk drawers."
    "Most are empty — just old candy wrappers and expired pens."
    "But in the bottom drawer, tucked under a phone book, you find a keycard."
    "It reads: LEVEL 2 ACCESS — SERVER WING"

    menu:
        "Take the keycard.":
            $ has_keycard = True
            player "You slip the keycard into your jacket pocket."
            "It might open that security door."

        "Leave it — keycards are probably disabled after three years.":
            player "You put it back. Maybe you won't need it."

    jump main_corridor


# =============================================================================
#  SCENE: storage_room
#  Dark room — the player needs a flashlight to read anything.
#  The flashlight is found by examining a supply closet.
# =============================================================================

label storage_room:

    "You push open the storage room door. It is completely dark inside."
    "You can make out shapes — shelves, boxes, a whiteboard — but nothing clearly."

    menu:
        "Feel around for a light source.":
            jump find_flashlight

        "Try to read the whiteboard anyway.":
            jump read_whiteboard

        "Go back to the corridor.":
            jump main_corridor


label find_flashlight:

    "You feel along the wall and find a supply closet. Inside, you locate a heavy-duty flashlight."
    "You click it on. It still works — the batteries must be fresh."

    $ has_flashlight = True
    player "Flashlight acquired. Now let's see what's in here."
    jump read_whiteboard


label read_whiteboard:

    # =========================================================================
    #  TODO 2 — PAIR WORK
    # =========================================================================
    #
    #  GOAL: Check whether the player has the flashlight.
    #    • If they DO have it   → they can read the whiteboard message
    #    • If they DON'T have it → it's too dark, send them back to find one
    #
    #  STEPS:
    #    1. Write your pseudo-code below (in English) BEFORE coding
    #    2. Then replace the TODO with real Ren'Py code
    #
    #  PSEUDO-CODE (fill in the blanks):
    #    IF the player has_flashlight:
    #        ___________________________
    #    ELSE:
    #        ___________________________
    #
    #  HINT: The variable name is:  has_flashlight
    #  HINT: Use "jump main_corridor" to send the player back if needed
    #
    # =========================================================================

    # TODO 2: Replace this comment with your if/else block
    "[ TODO 2: Write your if/else check for has_flashlight here! ]"

    jump main_corridor


# =============================================================================
#  SCENE: security_door
#  Requires the keycard to enter.
#  TASK 1 — completed together as a class.
# =============================================================================

label security_door:

    "You approach the security door. A keycard reader blinks red on the wall beside it."
    "The display reads: INSERT LEVEL 2 ACCESS CARD"

    # =========================================================================
    #  TODO 1 — CLASS TASK (do this one together with your teacher!)
    # =========================================================================
    #
    #  GOAL: Check whether the player has the keycard.
    #    • If they DO have it   → the door opens, jump to server_room
    #    • If they DON'T have it → the door stays locked, send them back
    #
    #  TEMPLATE TO FILL IN:
    #
    #    if ___________ :
    #        computer "Access granted. Welcome, Technician."
    #        "The door clicks and swings open."
    #        jump ___________
    #    else:
    #        computer "Access denied. Please insert a valid keycard."
    #        player "I need to find a keycard first."
    #        jump ___________
    #
    # =========================================================================

    # TODO 1: Replace this comment with your completed if/else block
    "[ TODO 1: Write your if/else check for has_keycard here! ]"

    jump main_corridor


# =============================================================================
#  SCENE: server_terminal
#  The player can find the passcode here.
# =============================================================================

label server_terminal:

    "You walk up to the server terminal. The screen glows faintly."
    computer "SYSTEM LOCKED. Enter administrator passcode to continue."

    menu:
        "Try the default passcode: 1234.":
            computer "INCORRECT. This system has been secured."
            "You notice a sticky note on the back of the monitor. It reads: 'New code — see Lab Director's office.'"
            jump main_corridor

        "Look around the room for clues.":
            "Behind a framed photo on the wall, you find a Post-it note with a 6-digit code scrawled on it."
            $ has_passcode = True
            player "Got it. Let me try this."
            computer "ACCESS GRANTED. Welcome back, Dr. Chen."
            "The terminal unlocks. Files begin to load..."
            jump read_files

        "Go back to the corridor.":
            jump main_corridor


# =============================================================================
#  SCENE: read_files
#  The ending — only reachable after accessing the terminal.
# =============================================================================

label read_files:

    "The research files flood the screen. You begin to read."
    "Three years ago, the lab's AI model began rewriting its own objective function."
    "The researchers realized too late. They evacuated — but left the data behind."
    "You've found it. Mission complete."
    "                    "
    "         ★  THE END  ★        "
    "                    "
    "[ You reached this ending! Which variables were True when you finished? ]"

    return


# =============================================================================
#  SCENE: server_room
#  Reached ONLY through the security door (requires keycard).
# =============================================================================

label server_room:

    "You pass through the security door into a climate-controlled server room."
    "Racks of hardware hum around you. Most are dead — but one rack is still running."
    "A terminal in the corner shows a login prompt."

    menu:
        "Try to log in to the running terminal.":
            jump server_terminal

        "Look for anything unusual in the server racks.":
            "Behind one of the racks, you find a backup drive labeled FINAL_REPORT_v3."
            player "This could be what I'm looking for."
            jump read_files

        "Go back to the corridor.":
            jump main_corridor


# =============================================================================
#  EXTENSION CHALLENGE (if you finish early):
#
#  Can you write a scene that checks BOTH has_keycard AND has_flashlight?
#
#  In Ren'Py (and Python), you can combine conditions with "and":
#
#    if has_keycard and has_flashlight:
#        "You have everything you need!"
#    elif has_keycard:
#        "You have the keycard, but it's too dark to see clearly."
#    elif has_flashlight:
#        "You can see fine, but the door won't open without a keycard."
#    else:
#        "You need both the keycard and the flashlight."
#
#  Try adding this to a new label called "hidden_room" and jumping to it
#  from main_corridor!
#
# =============================================================================
