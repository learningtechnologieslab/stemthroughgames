# =============================================================================
# SCRIPT 5 — FIXED VERSION  (CHALLENGE)
# Bug Type: Multiple Mixed Bugs (3 bugs fixed)
#
# ── FIX #1: Variable used before initialization ──────────────────────────────
#   Added:   $ clues_found = 0   at the top of label start
#   The += operator means "add to the existing value." If there's no existing
#   value, RenPy throws a NameError: name 'clues_found' is not defined.
#
# ── FIX #2: Typo in label name ───────────────────────────────────────────────
#   Changed:  jump interveiw_witness   (e and i were swapped)
#   To:       jump interview_witness
#   This causes a "Label 'interveiw_witness' not found" error at runtime.
#
# ── FIX #3: Missing closing quote on dialogue line ───────────────────────────
#   Changed:  d "Was there anything unusual about them?
#   To:       d "Was there anything unusual about them?"
#   Missing quotes confuse the parser — it keeps reading until it finds a
#   quote, causing a cascade of confusing error messages on nearby lines.
# =============================================================================

define d = Character("Detective Alex", color="#264653")
define w = Character("Witness", color="#E9C46A")
define s = Character("Suspect", color="#E76F51")
define n = Character("Narrator", color="#888888", what_italic=True)

label start:
    $ clues_found = 0    # FIXED #1: Initialize the variable before using it

    n "A mystery has unfolded at Maplewood Academy. Detective Alex is on the case."
    d "Alright. Three suspects, one missing trophy. Let's figure this out."

    $ clues_found += 1

    d "First, I'll check the scene of the crime."
    jump examine_scene

label examine_scene:
    n "The trophy case sits open. The lock wasn't forced."
    d "Interesting. Someone had a key, or knew the combination."

    menu:
        "Look for fingerprints":
            $ clues_found += 1
            d "I found a partial print on the glass. Could be useful."
            jump interview_witness

        "Check the security log":
            $ clues_found += 1
            d "The log shows the case was opened at 7:42 PM."
            jump interview_witness

        "Look for footprints":
            $ clues_found += 1
            d "There's a muddy footprint near the window. Size 9 shoe."
            jump interview_witness    # FIXED #2: 'interveiw' → 'interview'

label interview_witness:
    w "I saw someone near the trophy case around 7:30. Couldn't see who."
    d "Was there anything unusual about them?"    # FIXED #3: Added missing closing quote
    w "They were wearing a red jacket. That's all I noticed."

    menu:
        "Thank the witness and move on":
            jump confront_suspect
        "Ask a follow-up question":
            w "Actually... I think they dropped something near the gym door."
            $ clues_found += 1
            jump confront_suspect

label confront_suspect:
    if clues_found >= 3:
        d "I have enough evidence now. Time to make my case."
        jump accusation_strong
    else:
        d "I need more evidence before I can be sure."
        jump accusation_weak

label accusation_strong:
    d "I know exactly what happened, and I can prove it."
    s "How did you figure it out?!"
    d "The clues were there for anyone paying attention."
    jump ending

label accusation_weak:
    d "I have a theory, but I need to look a little longer."
    s "You can't prove anything."
    d "Not yet. But I will."
    jump ending

label ending:
    n "Whether solved or not, Detective Alex will be back tomorrow."
    d "Every mystery has an answer. You just have to know how to look."
    return
