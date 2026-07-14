# =============================================================================
# SCRIPT 5 — BUGGY VERSION  (CHALLENGE)
# Bug Type: Multiple Mixed Bugs (3 bugs total)
# Difficulty: Challenge
#
# STUDENT CHALLENGE:
#   This is the hardest script. It has THREE separate bugs:
#
#   Bug #1 — Somewhere in this file, a variable is incremented but
#             was never initialized. Find where 'clues_found' is used
#             before it's defined.
#
#   Bug #2 — One of the branching paths jumps to a label with a
#             subtle typo. Play carefully through every path.
#
#   Bug #3 — One line of dialogue has a missing closing quote.
#             RenPy's parser will get confused and report an error
#             somewhere nearby (not always on the exact broken line!).
#
# STRATEGY:
#   1. Read the error console first — what does it say?
#   2. Look at ALL jump statements and verify the label names exist.
#   3. Check every dialogue line for matching opening and closing quotes.
#   4. Trace the variable 'clues_found' from top to bottom.
# =============================================================================

define d = Character("Detective Alex", color="#264653")
define w = Character("Witness", color="#E9C46A")
define s = Character("Suspect", color="#E76F51")
define n = Character("Narrator", color="#888888", what_italic=True)

label start:
    n "A mystery has unfolded at Maplewood Academy. Detective Alex is on the case."
    d "Alright. Three suspects, one missing trophy. Let's figure this out."

    # Bug #1: 'clues_found' is used here but never initialized above this point
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
            jump interveiw_witness    # <-- Bug #2: typo! 'interveiw' not 'interview'

label interview_witness:
    w "I saw someone near the trophy case around 7:30. Couldn't see who."
    d "Was there anything unusual about them?
    w "They were wearing a red jacket. That's all I noticed."   # <-- Bug #3: missing closing quote on line above

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
