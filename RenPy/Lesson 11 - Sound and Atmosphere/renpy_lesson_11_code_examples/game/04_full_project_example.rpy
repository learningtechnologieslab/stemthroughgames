## =============================================================================
## DAY 11 – SOUND & ATMOSPHERE
## FILE: 04_full_project_example.rpy
## PURPOSE: Complete example — all audio techniques in a real short story
##
## This is the REFERENCE EXAMPLE students can study and remix.
## It shows EVERY audio technique taught today in context:
##
##   ✓  play music          — background music for a scene
##   ✓  play sound          — one-shot sound effect
##   ✓  stop music fadeout  — smooth transition between scenes
##   ✓  Different music for different moods
##   ✓  Silence used intentionally as a design choice
##   ✓  Music that matches character emotion
##   ✓  Overlapping music + sound effects
##
## STORY: "The Message" — a short mystery in three scenes.
##   Scene 1: Home (cozy, safe)
##   Scene 2: Outside at night (tense, uncertain)
##   Scene 3: Resolution (relief, then mystery)
##
## Students can:
##   A) Read through and identify every audio technique
##   B) Swap out audio files to change the emotional tone
##   C) Use this as a template for their own project
## =============================================================================

## ── Characters ────────────────────────────────────────────────────────────────
define narrator = Character(None, what_style="narrator_text")
define jamie    = Character("Jamie",    color="#7BBDC8",  image="jamie")
define voice    = Character("???",      color="#C8607B")


## ── Styles ────────────────────────────────────────────────────────────────────
style narrator_text:
    color "#D0EEF2"
    italic True


## =============================================================================
## SCENE 1: HOME — Cozy and safe
## Audio design goal: Warmth, safety, comfort — so the CONTRAST later is bigger
## =============================================================================

label start:

    ## Cozy, warm music starts immediately.
    ## We WANT the player to feel safe here — so the transition to danger lands harder.
    play music "audio/cozy_interior.mp3" fadein 2.0

    scene bg_living_room with dissolve

    narrator "7:42 PM. Jamie's apartment. Warm light. The smell of tea."

    jamie "Finally. A quiet evening."

    ## A gentle sound effect — reinforces the cozy mood
    play sound "audio/kettle_whistle.wav"

    jamie "Perfect timing."

    narrator "Jamie poured a cup and settled in."

    ## Notification sound — something is about to change
    play sound "audio/phone_buzz.wav"

    jamie "Hm?"

    narrator "An unknown number. One message."
    narrator "It said: 'Don't go outside tonight.'"

    ## Silence here — music STOPS to signal danger.
    ## This is intentional. Sudden silence = sudden dread.
    stop music fadeout 0.5    ## Short fade — abrupt feels right here

    jamie "..."

    narrator "The tea went cold."

    menu:
        "Go outside anyway":
            jump scene_outside

        "Stay inside and ignore it":
            jump scene_stay


## =============================================================================
## SCENE 2A: OUTSIDE — Tense and uncertain
## Audio design goal: Build dread. Something is wrong but we don't know what.
## =============================================================================

label scene_outside:

    ## Tense, slow music. Lower register, sparse instruments.
    ## This tells the player: you made a mistake.
    play music "audio/tense_strings.mp3" fadein 1.5

    scene bg_street_night with fade

    narrator "The street was empty. Street lights flickered."

    jamie "Hello?"

    ## Wind ambience — adds texture without drowning the music
    ## Both music and sound play at the same time on different channels
    play sound "audio/wind_ambience.wav"

    narrator "Nobody answered."

    jamie "This was a bad idea."

    narrator "Then, footsteps. Getting closer."

    ## Sudden sound effect for the jump scare moment
    ## The tense music + sudden footsteps = maximum tension
    play sound "audio/footsteps_fast.wav"

    jamie "Who's there?!"

    voice "I left you that message."

    ## New character appears. Music shifts — slightly less threatening.
    ## We still don't trust this person, but immediate danger is lower.
    stop music fadeout 1.0
    play music "audio/mystery_ambient.mp3" fadein 2.0

    voice "You shouldn't be out here. Come with me."

    menu:
        "Follow the stranger":
            jump scene_resolution

        "Run home":
            jump scene_run_home


## =============================================================================
## SCENE 2B: STAY — The safe choice (but is it?)
## Audio design goal: False safety — the cozy music is gone, replaced by unease
## =============================================================================

label scene_stay:

    ## No music here. Silence reinforces isolation and unease.
    ## The player chose "safety" but the silence says: something is still wrong.

    scene bg_living_room with dissolve

    narrator "Jamie locked the door. Drew the curtains."

    jamie "Probably just spam. Some kind of prank."

    narrator "Outside, a car alarm began to wail."

    play sound "audio/car_alarm.wav"

    narrator "Then stopped."

    narrator "Then silence again."

    jamie "..."

    narrator "Jamie didn't sleep that night."

    ## Very quiet, unsettling music — just barely audible
    ## Signals: the mystery isn't over. Just delayed.
    play music "audio/mystery_ambient.mp3" fadein 3.0

    narrator "The phone buzzed one more time."
    narrator "Same number. New message:"
    narrator "'Smart choice. I'll find another way.'"

    stop music fadeout 2.0

    jump scene_ending_questions


## =============================================================================
## SCENE 3A: RESOLUTION — Mystery deepens
## Audio design goal: Ambiguous. Not scary, not safe. Just... unknown.
## =============================================================================

label scene_resolution:

    ## A resolved-but-not-resolved feeling.
    ## Something clarified. Something else got more mysterious.
    stop music fadeout 1.5
    play music "audio/theme.mp3" fadein 2.0

    scene bg_warehouse with fade

    narrator "An old warehouse. Dry. Quiet."

    voice "My name is Reyes. I've been watching this block for weeks."

    voice "Something is wrong with the building on the corner."

    jamie "Wrong how?"

    voice "I don't know yet. That's why I needed someone else to see it."

    narrator "They stood in silence."

    ## Pause music to let the silence breathe — dramatic effect
    stop music fadeout 2.0

    narrator "Jamie looked at the building on the corner."
    narrator "The lights were off."
    narrator "Every single window."

    ## Subtle, slow music returns — questions remain unanswered
    play music "audio/mystery_ambient.mp3" fadein 3.0

    narrator "At exactly midnight, they all turned on."

    ## Sudden end — a cliffhanger needs music to cut with it
    stop music

    narrator "All of them."

    jump scene_ending_questions


## =============================================================================
## SCENE 3B: RUN HOME
## Audio design goal: Brief panic, then uneasy calm
## =============================================================================

label scene_run_home:

    stop music fadeout 0.3    ## Very fast cut — panic
    play sound "audio/footsteps_fast.wav"

    scene bg_street_night with dissolve

    narrator "Jamie ran."

    play music "audio/tense_strings.mp3" fadein 0.5    ## Fast fade-in — urgency

    narrator "Down the block. Up the stairs. Key in the door."

    play sound "audio/door_slam.wav"

    stop music fadeout 1.0

    scene bg_living_room with fade

    narrator "Safe."

    ## Quiet, uncertain music — same track as the "stay" scene
    ## Connects both "safe" outcomes emotionally
    play music "audio/mystery_ambient.mp3" fadein 3.0

    narrator "Or so it felt."

    narrator "The message was still on Jamie's phone."
    narrator "'Don't go outside tonight.'"

    narrator "It was deleted by morning. Like it was never there."

    stop music fadeout 2.0

    jump scene_ending_questions


## =============================================================================
## ENDING: Questions for reflection
## No music — let the player sit with what they felt
## =============================================================================

label scene_ending_questions:

    ## Silence here is intentional.
    ## The story is over. The player should reflect, not be guided.

    narrator "~ THE MESSAGE — End ~"

    narrator "Think about the audio choices in this story:"

    narrator "1. Where did music START that changed how you felt?"

    narrator "2. Where did music STOP — and did the silence feel like a choice?"

    narrator "3. Did any sound effect stand out? What did it do?"

    narrator "4. If you remixed this story, what would you change about the audio?"

    return


## =============================================================================
## AUDIO FILES USED IN THIS EXAMPLE
## =============================================================================
##
## Place all files in:  game/audio/
##
## File                      | Used for
## ─────────────────────────────────────────────────────────────────
## theme.mp3                 | Neutral background / resolution scene
## cozy_interior.mp3         | Scene 1 — warm & safe at home
## tense_strings.mp3         | Scene 2 — outdoor danger
## mystery_ambient.mp3       | Aftermath scenes — unanswered questions
## kettle_whistle.wav        | One-shot SFX — kettle in Scene 1
## phone_buzz.wav            | One-shot SFX — incoming message
## wind_ambience.wav         | Layered SFX — outdoor atmosphere
## footsteps_fast.wav        | One-shot SFX — approaching figure / running
## car_alarm.wav             | One-shot SFX — distant noise
## door_slam.wav             | One-shot SFX — escaping inside
##
## FREE SOURCES for audio files:
##   freemusicarchive.org
##   incompetech.com (Kevin MacLeod — free with attribution)
##   pixabay.com/music
##   freesound.org (for sound effects)
##
## FORMATS: Use .mp3 or .ogg for music, .wav or .ogg for sound effects.
##          Avoid .m4a and .aac — they may not work in all Ren'Py builds.
## =============================================================================
