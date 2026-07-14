# =============================================================================
#  DAY 10 GUIDED PRACTICE — ANSWER KEY (Teacher Reference Only)
#  STEM Through Games | Ren'Py Unit
# =============================================================================
#
#  This file shows the completed TODO blocks.
#  Do NOT distribute to students before they attempt the tasks.
#
# =============================================================================

default has_keycard    = False
default has_flashlight = False
default has_passcode   = False

define narrator  = Character(None)
define player    = Character("You")
define computer  = Character("TERMINAL", color="#00FF41")

label start:
    scene black with fade
    "The year is 2031. You are a junior technician sent to investigate an abandoned research lab."
    "Your mission: find out what happened to the research data."
    jump main_corridor

label main_corridor:
    "You stand in the main corridor. Three paths branch off."
    menu:
        "Go left — check the storage room.":
            jump storage_room
        "Go straight — try the security door.":
            jump security_door
        "Go right — look at the terminal.":
            jump server_terminal
        "Examine the reception desk first.":
            jump reception_desk

label reception_desk:
    "In the bottom drawer you find a keycard: LEVEL 2 ACCESS — SERVER WING"
    menu:
        "Take the keycard.":
            $ has_keycard = True
            player "You pocket the keycard."
        "Leave it.":
            player "You put it back."
    jump main_corridor

label storage_room:
    "The storage room is completely dark."
    menu:
        "Feel around for a light source.":
            jump find_flashlight
        "Try to read the whiteboard anyway.":
            jump read_whiteboard
        "Go back.":
            jump main_corridor

label find_flashlight:
    "You find a heavy-duty flashlight in the supply closet. It still works."
    $ has_flashlight = True
    player "Flashlight acquired."
    jump read_whiteboard

label read_whiteboard:

    # =========================================================================
    #  TODO 2 ANSWER
    # =========================================================================

    if has_flashlight:
        player "You sweep the flashlight beam across the whiteboard."
        "The writing is still legible. It reads:"
        "'WARNING — Do not reboot Server 7 without authorization.'"
        "'Rebooting will trigger the AI's self-modification protocol.'"
        player "That sounds ominous."
    else:
        "It is too dark to read anything. You need a light source."
        player "I can't see a thing in here. I should look for a flashlight."
        jump storage_room

    jump main_corridor

label security_door:
    "A keycard reader blinks red beside the security door."
    computer "INSERT LEVEL 2 ACCESS CARD"

    # =========================================================================
    #  TODO 1 ANSWER
    # =========================================================================

    if has_keycard:
        computer "Access granted. Welcome, Technician."
        "The door clicks and swings open."
        jump server_room
    else:
        computer "Access denied. Please insert a valid keycard."
        player "I need to find a keycard first."
        jump main_corridor

label server_terminal:
    computer "SYSTEM LOCKED. Enter administrator passcode to continue."
    menu:
        "Try default passcode: 1234.":
            computer "INCORRECT."
            jump main_corridor
        "Look for clues.":
            "Behind a photo you find a Post-it note with a 6-digit code."
            $ has_passcode = True
            computer "ACCESS GRANTED. Welcome back, Dr. Chen."
            jump read_files
        "Go back.":
            jump main_corridor

label read_files:
    "The research files flood the screen. Mission complete."
    "         ★  THE END  ★        "
    return

label server_room:
    "You enter the climate-controlled server room."
    menu:
        "Try to log in.":
            jump server_terminal
        "Search the server racks.":
            "You find a backup drive labeled FINAL_REPORT_v3."
            jump read_files
        "Go back.":
            jump main_corridor


# =============================================================================
#  EXTENSION ANSWER — hidden_room with combined conditions
# =============================================================================

label hidden_room:

    "You notice a panel in the back wall. There is both a keycard slot and a light sensor."

    if has_keycard and has_flashlight:
        player "You swipe the keycard and shine the flashlight at the sensor simultaneously."
        "The panel slides open."
        "Inside is a single hard drive labeled: THE TRUTH"
        "You've found the real data. But that's a story for another day."
        jump read_files

    elif has_keycard:
        player "You swipe the keycard — it beeps green. But the light sensor doesn't respond."
        "You need a light source to activate it."
        jump main_corridor

    elif has_flashlight:
        player "You shine the flashlight at the sensor — the light activates it."
        "But the panel beeps: KEYCARD REQUIRED."
        jump main_corridor

    else:
        player "You need both a keycard and a flashlight to open this panel."
        jump main_corridor
