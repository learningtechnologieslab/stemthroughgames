## =============================================================================
## DAY 11 – SOUND & ATMOSPHERE
## FILE: 02_guided_practice.rpy
## PURPOSE: Guided Practice (12–22 min) — students follow along with teacher
##
## TEACHER SCRIPT:
##   "Open your project. We're going to add audio step by step together.
##    Find your 'label start:' and follow along as I type on the board."
##
## STUDENT TASK: Add each line as the teacher demonstrates it.
## They should HEAR music after each save + launch.
##
## STEP BY STEP GUIDE (each step is labelled in the code below):
##   Step 1 — Add play music
##   Step 2 — Add a sound effect
##   Step 3 — Add stop music with fadeout
##   Step 4 — Change music for a new scene
## =============================================================================

define narrator = Character(None)
define sam = Character("Sam", color="#7BBDC8")


## ── STEP 1: Add your first play music command ─────────────────────────────────
##
## This is the FIRST thing students add. Run it. Hear it. Celebrate!
##
## Try it: Save, launch the game. Do you hear music?

label guided_step1:

    ## STEP 1: Add this line at the very start of your scene
    play music "audio/theme.mp3"

    scene bg_town             ## A daytime town background

    sam "Wow, there's music now!"

    narrator "Notice: the music started playing before any dialogue appeared."
    narrator "That's because play music goes BEFORE the dialogue lines."

    jump guided_step2


## ── STEP 2: Add a sound effect ────────────────────────────────────────────────
##
## Sound effects use play sound — they play ONCE and stop automatically.
## Great for: footsteps, door slams, alerts, button clicks, thunder.

label guided_step2:

    narrator "Now let's add a sound effect..."

    ## STEP 2: Add this when something dramatic happens
    play sound "audio/thunder.wav"

    sam "Whoa! Did you hear that thunder?!"

    narrator "See how play sound fired once and stopped?"
    narrator "The background music kept going — two channels at the same time!"

    jump guided_step3


## ── STEP 3: Stop music with a smooth fadeout ──────────────────────────────────
##
## Never just cut music abruptly — it sounds jarring.
## Always use fadeout when ending a track.

label guided_step3:

    narrator "When we leave this scene, we'll fade the music out smoothly."

    ## STEP 3: Before a scene change, stop the music gracefully
    stop music fadeout 2.0    ## 2.0 = 2 seconds to fade out

    narrator "Hear how it faded instead of cutting off? Much smoother!"
    narrator "The number after fadeout is the time in seconds."

    jump guided_step4


## ── STEP 4: New scene, new music ──────────────────────────────────────────────
##
## Different scenes should have different music to signal a mood change.
## Stop the old track, then play a new one.

label guided_step4:

    ## STEP 4: New scene gets fresh music
    play music "audio/cozy_interior.mp3" fadein 1.0

    scene bg_cabin            ## A warm, cozy cabin interior

    narrator "Now we're inside. The mood is completely different."

    sam "It feels so much safer in here..."

    narrator "Same story. Different location. Different music = different emotion."

    stop music fadeout 1.5

    narrator "~ End of guided practice ~"
    narrator "Try adding play music to YOUR project now!"

    return
