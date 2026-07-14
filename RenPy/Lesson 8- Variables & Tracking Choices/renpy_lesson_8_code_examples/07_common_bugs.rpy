## ============================================================
##  DAY 8 — EXAMPLE 7: Common Bugs & How to Fix Them
##  STEM Through Games · Ren'Py Programming
## ============================================================
##
##  PURPOSE:  This file shows THE MOST COMMON MISTAKES students
##            make with variables in Ren'Py, and how to fix each one.
##
##  HOW TO USE IN CLASS:
##    Show each "BUGGY VERSION" section to the class and ask:
##      "What's wrong? What would happen if we ran this?"
##    Then reveal the "FIXED VERSION" and explain why it works.
##
##  NOTE: The buggy code is inside COMMENTS (starting with ##)
##        so the file still runs correctly. Only the fixed versions
##        are actual working code.
##
## ============================================================

define e = Character("Explorer", color="#5EC8E5")
define g = Character("Guard",    color="#E5A85E")


# ══════════════════════════════════════════════════════════════
#  BUG #1 — Lowercase true / false
# ══════════════════════════════════════════════════════════════
#
#  Python's Boolean values MUST be capitalised.
#  "true" and "false" are not the same as "True" and "False".
#
#  BUGGY VERSION:
##   default has_key = false      ← NameError: name 'false' not defined
##   $ has_key = true              ← NameError: name 'true' not defined
#
#  FIXED VERSION:

default has_key = False           # ✓  Capital F
#                                 # ✓  Capital T when setting to True below


# ══════════════════════════════════════════════════════════════
#  BUG #2 — Forgetting the $ sign
# ══════════════════════════════════════════════════════════════
#
#  Inside a Ren'Py story block, Python assignments MUST start
#  with a $ sign. Without it, Ren'Py reads it as a character name
#  trying to say something — and crashes with a confusing error.
#
#  BUGGY VERSION (inside label):
##   has_key = True               ← Ren'Py sees this as: character "has_key" says "True"
##   gold = gold + 10              ← Same problem — it's not dialogue!
#
#  FIXED VERSION:
#    $ has_key = True             ← ✓  $ prefix tells Ren'Py "this is Python"
#    $ gold = gold + 10           ← ✓


# ══════════════════════════════════════════════════════════════
#  BUG #3 — "default" inside a label
# ══════════════════════════════════════════════════════════════
#
#  "default" must be written at the TOP LEVEL of the file,
#  OUTSIDE any label. If you put it inside "label start:",
#  Ren'Py will throw a syntax error or the variable won't be
#  available for save/load to work correctly.
#
#  BUGGY VERSION:
##  label start:
##      default gold = 0          ← SyntaxError: "default" inside a block
##      e "Hello!"
#
#  FIXED VERSION:
#
#  default gold = 0              ← ✓  Top level, before any label
#
#  label start:
#      e "Hello!"

default gold = 0                  # ✓  Correct placement


# ══════════════════════════════════════════════════════════════
#  BUG #4 — Typo in variable name creates a SECOND variable
# ══════════════════════════════════════════════════════════════
#
#  Python and Ren'Py are case-sensitive and exact.
#  A typo in the variable name doesn't cause an error — it
#  silently creates a brand new variable, which is ALWAYS False/0.
#  This is one of the hardest bugs to spot.
#
#  BUGGY VERSION:
##  default has_key = False
##  ...
##  $ Has_Key = True              ← TYPO: capital H and K create a NEW variable
##                                    "has_key" is still False!
##  if has_key:                   ← This checks the ORIGINAL variable, still False
##      g "Come in!"              ← This NEVER runs
#
#  FIXED VERSION — consistency is everything:
##  default has_key = False
##  $ has_key = True              ← ✓ exact same spelling and case
##  if has_key:                   ← ✓ checks the variable we just set


# ══════════════════════════════════════════════════════════════
#  BUG #5 — = versus == (assignment vs comparison)
# ══════════════════════════════════════════════════════════════
#
#  =   means "store this value in the variable" (assignment)
#  ==  means "check if these two values are equal" (comparison)
#
#  Using one where you need the other causes either a crash
#  or a logic error that's hard to trace.
#
#  BUGGY VERSION:
##  if gold = 50:                 ← SyntaxError: can't assign inside "if"
##      e "You have exactly 50!"
#
##  $ gold == gold + 10           ← Does nothing! == just compares; + is lost
#
#  FIXED VERSION:
##  if gold == 50:                ← ✓ compare with ==
##      e "You have exactly 50!"
#
##  $ gold = gold + 10            ← ✓ assign with =


# ══════════════════════════════════════════════════════════════
#  BUG #6 — Indentation errors
# ══════════════════════════════════════════════════════════════
#
#  Ren'Py uses Python-style indentation (spaces, not tabs).
#  Every line inside a label must be indented by 4 spaces.
#  Lines inside an "if" block must be indented 4 more spaces.
#  A misaligned line causes an IndentationError.
#
#  BUGGY VERSION:
##  label start:
##  e "Hello!"                    ← IndentationError: not indented inside label
##
##  label locked_gate:
##      if has_key:
##      g "Come in!"              ← IndentationError: should be under "if"
#
#  FIXED VERSION:
##  label start:
##      e "Hello!"                ← ✓ 4 spaces in
##
##  label locked_gate:
##      if has_key:
##          g "Come in!"          ← ✓ 8 spaces in (4 for label, 4 for if)


# ══════════════════════════════════════════════════════════════
#  WORKING DEMO — all bugs avoided
# ══════════════════════════════════════════════════════════════

label start:

    scene bg bg_town with fade

    # Bug 2 fixed: $ before the assignment
    $ gold = 25
    $ has_key = False

    e "I start with [gold] gold and no key."

    # Bug 5 fixed: == for comparison, = for assignment
    if gold == 25:
        e "Gold is exactly 25."

    # Bug 1 fixed: True with capital T
    $ has_key = True

    # Bug 4 fixed: same spelling every time
    if has_key:
        e "I have the key!"
    else:
        e "No key found."

    # Bug 5 fixed: = to update gold
    $ gold = gold + 10
    e "After earning 10 more, I have [gold] gold."

    jump locked_gate


label locked_gate:

    scene bg bg_castle_gate with fade

    g "State your business."

    # Bug 6 fixed: correct indentation throughout
    if has_key:
        g "The master key! You may enter."
    elif gold >= 50:
        g "Fifty gold to enter. Deal?"
        $ gold -= 50
        e "I pay up. Down to [gold] gold."
    else:
        g "Nothing to offer. Move along."

    return


## ============================================================
##  TEACHER NOTES
## ============================================================
##
##  RECOMMENDED ACTIVITY:
##    Give students a SHORT script with one deliberate bug in it.
##    Have them find and fix it before running.
##    Good bugs to plant:
##      • "default" inside a label
##      • Missing $ on an assignment line
##      • Lowercase true or false
##      • has_Key instead of has_key (capitalisation typo)
##
##  ERROR MESSAGE DECODER:
##    "NameError: name 'true' is not defined"
##       → Student wrote  true  instead of  True
##    "IndentationError: unexpected indent"
##       → A line is indented when it shouldn't be
##    "IndentationError: expected an indented block"
##       → A line that SHOULD be indented (under if/label) isn't
##    "I'm not seeing my if branch run!"
##       → Check for typos in the variable name (Bug #4)
##       → Check that $ was used to SET it (Bug #2)
##
## ============================================================
