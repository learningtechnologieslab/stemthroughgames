## ============================================================
##  DAY 8 — EXAMPLE 2: The Key Mystery  (STARTER FILE)
##  STEM Through Games · Ren'Py Programming
## ============================================================
##
##  CONCEPT: Using a Boolean variable to track a player choice,
##           then checking it with  if / else  to change the story.
##
##  YOUR JOB:
##    This file has TWO places marked  # TODO  where code is missing.
##    Find them and fill them in.
##
##    TODO 1 — Line ~67:  Set has_key to True when the player
##             chooses to pick up the object.
##
##    TODO 2 — Line ~87:  Write an  if / else  block so the guard
##             reacts differently depending on whether the player
##             has the key.
##
##  HOW TO TEST:
##    Run the game twice:
##      ✓ First time: pick up the key  → guard should let you in.
##      ✓ Second time: ignore it       → guard should turn you away.
##
## ============================================================

# ── CHARACTER DEFINITIONS ─────────────────────────────────────
define e = Character("Explorer", color="#5EC8E5")
define g = Character("Guard",    color="#E5A85E")


# ── VARIABLE DECLARATIONS ─────────────────────────────────────
#
#   has_key starts as False — the player does NOT have the key yet.
#   It will become True only if the player chooses to pick it up.

default has_key = False


# ── MAIN STORY ────────────────────────────────────────────────
label start:

    scene bg bg_forest with fade

    e "I wake up at the edge of a strange forest."
    e "The trees are twisted and the sky is an odd shade of purple."
    e "Ahead of me, a stone path leads toward a castle gate."

    scene bg bg_forest with dissolve

    e "As I take my first step, something catches the light."
    e "There's a small object half-buried in the dirt."

    # ── PLAYER CHOICE ────────────────────────────────────────
    #
    #   The menu keyword creates a choice for the player.
    #   Each option is indented under "menu:" with a colon at the end.
    #   The code under each option runs only if that option is chosen.

    menu:

        "Pick up the glinting object.":

            # ╔══════════════════════════════════════════════╗
            # ║  TODO 1                                      ║
            # ║  Write one line here to set has_key to True. ║
            # ║  Remember: use the $ sign before the         ║
            # ║  variable name.                              ║
            # ║                                              ║
            # ║  Hint:  $ has_key = True                     ║
            # ╚══════════════════════════════════════════════╝

            e "I brush off the dirt. It's an old iron key!"
            e "The teeth are worn but it looks like it might still work."
            e "I slip it into my pocket."

        "Ignore it and keep walking.":

            e "Probably just a bottle cap. No time to stop."
            e "I keep moving toward the castle."

    # After the menu, both paths continue here.
    jump locked_gate


# ── LOCKED GATE SCENE ─────────────────────────────────────────
label locked_gate:

    scene bg bg_castle_gate with fade

    g "Halt! This gate is sealed."
    g "No one enters without authorisation."

    # ── CHECKING THE VARIABLE ────────────────────────────────
    #
    #   Here we need to look inside the has_key variable and
    #   react differently based on what's stored there.
    #
    #   Structure:
    #       if <condition>:
    #           (code if condition is TRUE)
    #       else:
    #           (code if condition is FALSE)

    # ╔══════════════════════════════════════════════════════════╗
    # ║  TODO 2                                                  ║
    # ║  Replace this comment with an if / else block.           ║
    # ║                                                          ║
    # ║  IF the player has the key:                              ║
    # ║     • Guard is surprised and lets the player in          ║
    # ║     • Jump to label "inside_castle"                      ║
    # ║                                                          ║
    # ║  ELSE (player does NOT have the key):                    ║
    # ║     • Guard turns the player away                        ║
    # ║     • Jump to label "turned_away"                        ║
    # ╚══════════════════════════════════════════════════════════╝

    # (This line runs until you fill in TODO 2 — remove it then.)
    jump turned_away


# ── ENDINGS ───────────────────────────────────────────────────
label inside_castle:

    scene bg bg_inside_castle with fade

    e "The gate groans and swings open."
    e "I step inside the castle courtyard."
    e "Torches flicker on the stone walls."
    e "My adventure truly begins..."

    jump ending


label turned_away:

    scene bg bg_forest with fade

    e "I stare at the locked gate."
    e "There must be another way in — or something I missed."
    e "I turn back toward the forest."

    jump ending


label ending:

    e "Whatever happens next... that's a story for another day."
    return


## ============================================================
##  TEACHER NOTES
## ============================================================
##
##  EXPECTED COMPLETED CODE for TODO 1 (inside "Pick up" branch):
##
##      $ has_key = True
##
##  EXPECTED COMPLETED CODE for TODO 2 (after guard dialogue):
##
##      if has_key:
##          g "Wait — is that the master key?!"
##          g "I haven't seen one of those in years. Go right ahead."
##          jump inside_castle
##      else:
##          g "No key, no entry. Come back when you have authorisation."
##          jump turned_away
##
##  EXTENSION TASKS (for students who finish early):
##
##    ★ Extension A:  Add a second variable  default has_badge = False
##      Give the player a chance to earn a badge earlier in the story.
##      Add an  elif has_badge:  branch at the gate — the guard
##      salutes them and lets them in, but notes the missing key.
##
##    ★★ Extension B:  Add  default attempts = 0
##      Each time the player is turned away, do  $ attempts += 1
##      and jump back to locked_gate.  After 2 attempts, the guard
##      recognises them: "You again! I've told you three times now..."
##
## ============================================================
