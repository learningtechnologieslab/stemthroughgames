# =============================================================================
# Day 4 – Project 3: Named Characters (Extension Challenge)
# Introduces the "define" keyword to create speaking characters.
#
# WHAT TO NOTICE:
#   - "define" creates a character object and stores it in a variable
#   - Character("Name") sets the name shown in the dialogue box
#   - To make a character speak, put their variable BEFORE the quoted text
#   - Lines without a variable prefix are still narrator text
#   - You can have as many characters as you like
# =============================================================================

# --- Define our characters up here, before label start ---

define alex = Character("Alex")
define morgan = Character("Morgan")


label start:

    # Narrator sets the scene
    "It was the first day of the STEM through Games program."

    "Two students arrived at the computer lab at exactly the same time."

    # Now our characters speak using their variables
    alex "Whoa — is this the right room? There are so many computers."

    morgan "I think so. The sign on the door says 'Game Design.'"

    alex "I've never made a game before. Have you?"

    morgan "Nope. But how hard can it be?"

    # Narrator again
    "They found seats next to each other."

    "On the screen in front of them, a single window was open."

    "It said: Ren'Py Launcher."

    alex "Okay... I guess we click 'Create New Project'?"

    morgan "Only one way to find out."

    "They clicked the button."

    "And so it began."

    return
