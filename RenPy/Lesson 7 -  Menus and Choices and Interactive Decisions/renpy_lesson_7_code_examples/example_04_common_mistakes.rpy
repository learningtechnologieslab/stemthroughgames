# ============================================================
#  DAY 7 — EXAMPLE 4: Common Mistakes & How to Fix Them
#
#  This file shows BROKEN code alongside the FIXED version.
#  Read it — don't run it as-is (the broken sections are
#  commented out so they won't crash RenPy).
#
#  MISTAKES COVERED:
#    1. Wrong indentation in menu:
#    2. Forgetting the colon after a choice string
#    3. jump target that doesn't exist
#    4. Forgetting  return  at the end of a label
#    5. Text on the same line as  menu:
# ============================================================


# ────────────────────────────────────────────────────────────
#  MISTAKE 1: Wrong indentation
# ────────────────────────────────────────────────────────────
#
#  BROKEN — choices are at the same level as menu:
#  RenPy expects choices to be indented INSIDE the menu block.
#
#   menu:
#   "Go left":          <-- should be indented 8 spaces
#       jump left
#   "Go right":         <-- should be indented 8 spaces
#       jump right
#
#  FIXED — each choice is indented 8 spaces (two tab-stops):

label mistake_1_fixed:

    menu:
        "Go left":          # 8 spaces
            jump ml_left    # 12 spaces

        "Go right":         # 8 spaces
            jump ml_right   # 12 spaces

label ml_left:
    "You went left. Correct indentation!"
    return

label ml_right:
    "You went right. Correct indentation!"
    return


# ────────────────────────────────────────────────────────────
#  MISTAKE 2: Missing colon after choice text
# ────────────────────────────────────────────────────────────
#
#  BROKEN:
#   menu:
#       "Go left"           <-- missing : at the end
#           jump left
#
#  FIXED: every choice string must end with a colon.

label mistake_2_fixed:

    menu:
        "Go left":          # <-- colon is required!
            jump m2_left
        "Go right":
            jump m2_right

label m2_left:
    "Left path — colon fixed!"
    return

label m2_right:
    "Right path — colon fixed!"
    return


# ────────────────────────────────────────────────────────────
#  MISTAKE 3: jump to a label that doesn't exist
# ────────────────────────────────────────────────────────────
#
#  BROKEN:
#   menu:
#       "Go to the castle":
#           jump castel        <-- typo! label is "castle" not "castel"
#
#  RenPy error: "could not find label 'castel'"
#
#  FIXED: make sure the label name in jump matches EXACTLY.

label mistake_3_fixed:

    menu:
        "Go to the castle":
            jump castle         # correct spelling

label castle:
    "You arrive at the castle."
    return


# ────────────────────────────────────────────────────────────
#  MISTAKE 4: Forgetting return at the end of a label
# ────────────────────────────────────────────────────────────
#
#  BROKEN:
#   label forest:
#       "You enter the forest."
#       "It is dark."
#       # <-- no return! RenPy keeps running into whatever comes next
#
#  This causes the game to fall through into the next label,
#  which is almost never what you want.
#
#  FIXED: always end every story label with return.

label mistake_4_fixed:

    "You enter the forest."
    "It is dark and quiet."

    return      # <-- stops the story here; game goes to main menu


# ────────────────────────────────────────────────────────────
#  MISTAKE 5: Text on the same line as menu:
# ────────────────────────────────────────────────────────────
#
#  BROKEN:
#   menu: "What do you do?"       <-- can't put text here in RenPy
#       "Run":
#           jump run
#
#  FIXED: put any "prompt" text as a separate dialogue line
#  BEFORE the menu block.

label mistake_5_fixed:

    "What do you do?"   # <-- prompt goes here, before menu:

    menu:               # <-- menu: has nothing after the colon
        "Run away":
            jump m5_run
        "Stand your ground":
            jump m5_stand

label m5_run:
    "You run. Fast."
    return

label m5_stand:
    "You stand firm."
    return


# ────────────────────────────────────────────────────────────
#  QUICK REFERENCE: Correct menu structure
# ────────────────────────────────────────────────────────────
#
#   [narration or dialogue before the menu]
#   "Prompt text — what is the player deciding?"
#
#   menu:
#       "Choice one text":        <- 8 spaces, quoted, colon
#           jump label_one        <- 12 spaces
#
#       "Choice two text":        <- 8 spaces, quoted, colon
#           jump label_two        <- 12 spaces
#
#
#   label label_one:
#       [story continues here]
#       return
#
#   label label_two:
#       [story continues here]
#       return
# ────────────────────────────────────────────────────────────
