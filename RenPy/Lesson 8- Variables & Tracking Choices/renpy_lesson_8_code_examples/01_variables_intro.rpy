## ============================================================
##  DAY 8 — EXAMPLE 1: What Is a Variable?
##  STEM Through Games · Ren'Py Programming
## ============================================================
##
##  CONCEPT: The "default" keyword, reading a variable's value,
##           and changing it with $ inside the story.
##
##  HOW TO USE THIS FILE:
##    1. Open your Ren'Py project folder.
##    2. Replace the contents of "script.rpy" with this file,
##       OR paste it into a new file called "example1.rpy".
##    3. Click "Launch Project" in the Ren'Py launcher.
##
##  WHAT TO NOTICE:
##    • The "default" line sits ABOVE "label start:" — that's
##      the right place for all your variable declarations.
##    • The $ sign at the start of a line means "run Python here"
##      — it's how you change a variable's value mid-story.
##    • Variables can store True/False (Boolean), numbers, or text.
##
## ============================================================

# ── CHARACTER DEFINITIONS ─────────────────────────────────────
define narrator = Character(None, kind=nvl)   # narrator, no name shown
define alex = Character("Alex", color="#5EC8E5")

# ── VARIABLE DECLARATIONS ─────────────────────────────────────
#
#   Syntax:   default  <name>  =  <starting value>
#
#   These run ONCE when the game starts and set the initial value.
#   Think of each one as labelling an empty box before the story begins.

default player_name   = "Traveler"   # String  — stores text
default score         = 0            # Integer — stores a whole number
default has_lantern   = False        # Boolean — True or False only
default mood          = "neutral"    # String  — can be any word you choose


# ── MAIN STORY ────────────────────────────────────────────────
label start:

    scene bg black with fade

    # ── READING a variable ────────────────────────────────────
    #
    #   Put the variable name inside [square brackets] inside
    #   dialogue text and Ren'Py will swap in the current value.

    alex "Hello, [player_name]. Ready to learn about variables?"
    alex "Right now your score is [score] and your lantern is [has_lantern]."

    # ── CHANGING a variable ───────────────────────────────────
    #
    #   Use  $ variable_name = new_value  to update the box.
    #   The old value is thrown away; the new one takes its place.

    $ score = 10
    alex "I just set score to 10. Let's check: your score is now [score]."

    $ score = score + 5
    alex "I added 5 to score. Now it's [score]."

    # Shortcut: += means "add to itself"
    $ score += 5
    alex "I used += 5. Now score is [score]."

    $ has_lantern = True
    alex "I set has_lantern to True. It is now: [has_lantern]."

    $ player_name = "Hero"
    alex "I changed your name to 'Hero'. Hello, [player_name]!"

    $ mood = "happy"
    alex "Mood changed to [mood]. Variables can store words too."

    alex "That's the basics! A variable is just a labelled box"
    alex "that holds a value — and you can change that value any time."

    return


## ============================================================
##  TEACHER NOTES
## ============================================================
##
##  KEY VOCABULARY introduced in this file:
##    default   — declare a variable and set its starting value
##    $         — prefix that lets you write Python in a story line
##    Boolean   — a value that is only ever True or False
##    Integer   — a whole number (no decimals)
##    String    — text wrapped in "double quotes"
##    [varname] — show the variable's current value inside dialogue
##
##  DISCUSSION QUESTIONS:
##    1. What happens if you change player_name BEFORE the first
##       dialogue line? Try it!
##    2. What do you think happens if you write  $ score = score
##       (assign it to itself)? Run it and find out.
##    3. Can you add TWO variables together?  Try $ score += score
##
##  COMMON ERRORS to watch for:
##    • Writing  true  instead of  True  (capital T required)
##    • Forgetting the $  before a variable assignment in the story
##    • Putting the "default" line INSIDE "label start:" — it must
##      be outside and above it.
##
## ============================================================
