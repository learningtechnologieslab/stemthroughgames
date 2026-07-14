## =============================================================================
## DAY 11 – SOUND & ATMOSPHERE
## FILE: 01_warmup_demo.rpy
## PURPOSE: Teacher warm-up demo — "The Silence Game"
##
## HOW TO USE IN CLASS:
##   1. Show label scene_no_sound first (no music, project on screen)
##   2. Ask: "What do you feel? What's missing?"
##   3. Then jump to scene_with_sound
##   4. Ask: "What changed? What did the music tell you?"
##
## This file has NO audio on purpose for the first run.
## The teacher jumps to scene_with_sound manually (or students call it).
## =============================================================================

## ── Characters ────────────────────────────────────────────────────────────────
define narrator = Character(None, what_style="narrator_text")
define alex = Character("Alex", color="#7BBDC8")
define morgan = Character("Morgan", color="#C87BA0")


## ── SCENE: No Sound (Show this first) ─────────────────────────────────────────
label scene_no_sound:

    ## No play music command here — complete silence

    scene bg_forest            ## A dark forest background

    narrator "A forest at night. Somewhere in the distance, an owl calls."

    alex "Did you hear that?"

    morgan "I didn't hear anything."

    alex "That's what worries me."

    narrator "The trees stand perfectly still."

    ## Pause here and ask the class:
    ##   "How does this feel? What word describes the mood?"
    ##   Let a few students answer before continuing.

    menu:
        "Continue to the same scene WITH music...":
            jump scene_with_sound


## ── SCENE: With Sound (Show this second) ──────────────────────────────────────
label scene_with_sound:

    ## Now we add music — same scene, completely different feel
    play music "audio/theme.mp3" fadeout 1.0 fadein 1.5

    scene bg_forest

    narrator "A forest at night. Somewhere in the distance, an owl calls."

    alex "Did you hear that?"

    morgan "I didn't hear anything."

    alex "That's what worries me."

    narrator "The trees stand perfectly still."

    ## Now ask:
    ##   "How does this feel DIFFERENT?"
    ##   "What emotion does the music add?"
    ##   "Did the story change? Did your FEELING change?"

    stop music fadeout 2.0

    narrator "~ End of warm-up demo ~"

    return
