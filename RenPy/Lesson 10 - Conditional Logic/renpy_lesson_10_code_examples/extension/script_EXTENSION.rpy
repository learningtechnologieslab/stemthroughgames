# =============================================================================
#  DAY 10 EXTENSION CHALLENGE — elif and Combined Conditions
#  STEM Through Games | Ren'Py Unit
# =============================================================================
#
#  You've mastered if/else. Time to level up!
#
#  CHALLENGE 1: Use "elif" to create THREE-WAY branches
#  CHALLENGE 2: Combine TWO variables in one condition using "and" / "or"
#  CHALLENGE 3: Build a scene where past choices stack up
#
#  Read each section, then try the challenges marked with ★
#
# =============================================================================


# -----------------------------------------------------------------------------
#  THREE variables this time — the player can find all, some, or none
# -----------------------------------------------------------------------------

default has_sword      = False     # Found in the armoury
default has_shield     = False     # Found in the storage room
default has_magic_key  = False     # Found by solving a riddle


define narrator = Character(None)
define player   = Character("You")
define guard    = Character("Guard", color="#FF9900")
define wizard   = Character("Wizard", color="#9966FF")


# =============================================================================
#  INTRODUCTION — the player collects items
# =============================================================================

label start:

    scene black with fade

    "You are an adventurer standing before the Gate of Three Locks."
    "The wizard who guards it will only let you pass if you prove yourself worthy."
    "You've been exploring the dungeon and may have found useful items."

    jump collect_items


label collect_items:

    "Before approaching the gate, you check what you found in your travels."

    menu:
        "Search the armoury (you haven't been yet).":
            jump armoury

        "Search the storage room (you haven't been yet).":
            jump storage_room_ext

        "Solve the wizard's riddle (you haven't tried yet).":
            jump riddle_room

        "Approach the Gate of Three Locks.":
            jump gate_of_locks


label armoury:
    "The armoury is mostly stripped bare. But in a rack near the back, you find a fine steel sword."
    menu:
        "Take the sword.":
            $ has_sword = True
            player "A good blade. This might come in handy."
        "Leave it — swords aren't your style.":
            player "You prefer to travel light."
    jump collect_items


label storage_room_ext:
    "The storage room has shelves of rotting supplies. But propped in the corner is a battered shield."
    menu:
        "Take the shield.":
            $ has_shield = True
            player "Heavy, but solid. Defense first."
        "Leave it — too bulky.":
            player "You leave the shield behind."
    jump collect_items


label riddle_room:
    wizard "Ah, a curious one! Answer my riddle and I'll give you something useful."
    wizard "I have cities but no houses. I have mountains but no trees. I have water but no fish. What am I?"
    menu:
        "\"A map.\"":
            wizard "Correct! A keen mind. Take this magic key — it opens things others cannot."
            $ has_magic_key = True
        "\"A painting.\"":
            wizard "An interesting answer, but no. Come back when you've thought more carefully."
        "\"I don't know.\"":
            wizard "Honesty is admirable. But I only reward correct answers."
    jump collect_items


# =============================================================================
#  THE GATE OF THREE LOCKS
#  This scene demonstrates elif and combined "and" conditions.
# =============================================================================

label gate_of_locks:

    "You stand before the Gate of Three Locks. The guard eyes you up and down."

    guard "The gate has three locks. To pass, you must satisfy at least one."
    guard "Lock One requires the sword AND the shield."
    guard "Lock Two requires the magic key."
    guard "Lock Three... well, that one no one has opened in a hundred years."

    # =========================================================================
    #  ELIF EXAMPLE
    #  "elif" = "else if" — runs when the first "if" was False,
    #  but only if THIS condition is True.
    #
    #  You can chain as many elif blocks as you need.
    #  The else at the end catches everything else.
    #
    #  Structure:
    #    if <first condition>:
    #        ...
    #    elif <second condition>:
    #        ...
    #    elif <third condition>:
    #        ...
    #    else:
    #        ...
    # =========================================================================

    if has_sword and has_shield:
        # "and" means BOTH must be True
        guard "The sword and shield — you are a true warrior. Lock One opens for you."
        "The first lock clicks. The gate shudders."
        jump beyond_the_gate

    elif has_magic_key:
        # Only checked if the first condition was False
        guard "The magic key... I haven't seen one of those in years. Lock Two is yours."
        "The second lock dissolves. The gate swings open."
        jump beyond_the_gate

    elif has_sword or has_shield:
        # "or" means AT LEAST ONE must be True
        # This catches players who have one weapon but not both
        guard "You have part of what's needed for Lock One, but not all."
        guard "A warrior must be fully equipped. Come back when you have both."
        player "I need to find the other weapon."
        jump collect_items

    else:
        # Nothing worked — player has none of the items
        guard "Empty-handed? I'm afraid I can't let you through."
        player "I need to find something. Back to the dungeon."
        jump collect_items


label beyond_the_gate:

    "You step through the gate into a golden courtyard."
    "Whatever lay beyond all three locks must remain a mystery — for now."
    "You have proven yourself worthy."
    "              ★  YOU WIN  ★             "

    return


# =============================================================================
#  ★ CHALLENGE 1
#  Add a third path to the gate scene using "and" with all three items:
#
#    if has_sword and has_shield and has_magic_key:
#        "All three items! You open Lock Three — the impossible lock."
#        jump secret_ending
#
#  Add a "secret_ending" label below and write a special ending for it!
# =============================================================================


# =============================================================================
#  ★ CHALLENGE 2
#  What if the game tracked HOW MANY items the player has, not just which ones?
#  Ren'Py can store integers (whole numbers) too!
#
#    default item_count = 0
#
#  When the player picks up an item:
#    $ item_count += 1         # This adds 1 to item_count
#
#  Then in the gate scene:
#    if item_count >= 3:
#        "You have everything!"
#    elif item_count >= 1:
#        "You have some items, but not enough."
#    else:
#        "You have nothing."
#
#  Try adding item_count tracking to this script!
# =============================================================================


# =============================================================================
#  ★ CHALLENGE 3
#  Can you add a character who REMEMBERS what you said to them earlier?
#
#  Example:
#    default was_polite_to_guard = False
#
#    label meet_guard:
#        menu:
#            "\"Good day, sir!\"":
#                $ was_polite_to_guard = True
#                guard "Well, good day to you too!"
#            "\"Get out of my way.\"":
#                guard "How rude."
#
#    # Later, at the gate:
#    if was_polite_to_guard:
#        guard "Oh, it's you! The polite one. I'll give you a hint..."
#    else:
#        guard "You again. Don't expect any favors from me."
#
# =============================================================================
