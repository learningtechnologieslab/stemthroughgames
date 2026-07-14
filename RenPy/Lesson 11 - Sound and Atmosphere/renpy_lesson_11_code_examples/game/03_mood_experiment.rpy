## =============================================================================
## DAY 11 – SOUND & ATMOSPHERE
## FILE: 03_mood_experiment.rpy
## PURPOSE: Main Activity — The Mood Experiment (22–38 min)
##
## STUDENT INSTRUCTIONS:
##   You will run the SAME scene THREE times.
##   Each time, different audio plays.
##   After each run, write ONE emotion word on your worksheet.
##
##   Run 1 → label experiment_run1  (no audio)
##   Run 2 → label experiment_run2  (neutral background music)
##   Run 3 → label experiment_run3  (contrasting music — teacher provides file)
##
## TEACHER NOTE:
##   For Run 3, swap "audio/tense_strings.mp3" for whichever contrasting
##   track you downloaded (something very different from theme.mp3 —
##   try something upbeat/cheerful OR something dark/scary).
##   The bigger the contrast, the more powerful the discussion.
##
## WORKSHEET REMINDER:
##   Students fill in their Mood Experiment table in their workbooks
##   after EACH run before moving to the next one.
## =============================================================================

define narrator = Character(None, what_style="narrator_text")
define river  = Character("River",  color="#7BBDC8")
define casey  = Character("Casey",  color="#C8A07B")


## ── The scene itself (used in all three runs) ─────────────────────────────────
##
## This is the EXACT same dialogue for all three runs.
## Only the audio changes. Nothing else.

label the_scene:

    scene bg_abandoned_building

    narrator "An old building. Faded paint. Broken windows."

    river "I don't think we should be here."

    casey "We just need to find the key. Then we leave."

    narrator "A door creaks somewhere deeper inside."

    river "Did you hear that?"

    casey "..."

    narrator "Neither of them moved."

    return


## ── RUN 1: No audio ───────────────────────────────────────────────────────────
##
## STUDENT GOAL: Notice what the ABSENCE of sound does to the scene.
##
## Questions to consider as you watch:
##   - Does silence feel neutral, or does it have its own mood?
##   - Is anything missing? What?

label experiment_run1:

    ## ─ No audio command here. Complete silence. ─

    call the_scene

    ## Write on your worksheet:
    ##   Run 1 emotion: _______________

    narrator "~ End of Run 1 — Write your emotion word on your worksheet ~"

    menu:
        "Continue to Run 2 (with background music)":
            jump experiment_run2


## ── RUN 2: Neutral background music ──────────────────────────────────────────
##
## STUDENT GOAL: Feel how even "background" music changes the scene's tone.
##
## Questions to consider:
##   - Did the same words feel different?
##   - Does the music match the scene, or does it clash?

label experiment_run2:

    ## Background music starts before the scene
    play music "audio/theme.mp3" fadein 1.0

    call the_scene

    stop music fadeout 1.5

    ## Write on your worksheet:
    ##   Run 2 emotion: _______________

    narrator "~ End of Run 2 — Write your emotion word on your worksheet ~"

    menu:
        "Continue to Run 3 (contrasting music)":
            jump experiment_run3


## ── RUN 3: Contrasting music ──────────────────────────────────────────────────
##
## TEACHER: Replace "tense_strings.mp3" with your chosen contrasting track.
##
## Try options like:
##   "audio/upbeat_piano.mp3"   → cheerful/funny, creates ironic contrast
##   "audio/tense_strings.mp3"  → dramatic/scary, amplifies danger
##   "audio/lullaby.mp3"        → gentle/sad, makes the scene feel melancholy
##
## STUDENT GOAL: Compare how a VERY different track changes everything.
##
## Questions to consider:
##   - Was this emotion stronger or weaker than Run 2?
##   - Could you imagine using this music intentionally? Why?

label experiment_run3:

    ## Contrasting music — swap the filename to whatever you chose
    play music "audio/tense_strings.mp3" fadein 1.0

    call the_scene

    stop music fadeout 2.0

    ## Write on your worksheet:
    ##   Run 3 emotion: _______________

    narrator "~ End of Run 3 — Write your emotion word on your worksheet ~"
    narrator "Now: compare your three emotion words."
    narrator "Same words on screen. Three completely different feelings."
    narrator "THAT is the power of sound design."

    jump experiment_reflection


## ── Reflection prompt (after all 3 runs) ─────────────────────────────────────
label experiment_reflection:

    narrator "Think about these questions before the class discussion:"

    narrator "1.  Which run felt the MOST emotional? Why?"

    narrator "2.  Which run felt the LEAST emotional? Surprising?"

    narrator "3.  If YOU were making this game, which track would you choose — and why?"

    narrator "~ Share your answers with a partner, then we'll discuss as a class ~"

    return
