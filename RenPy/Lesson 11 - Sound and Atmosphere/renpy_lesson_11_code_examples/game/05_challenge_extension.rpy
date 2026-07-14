## =============================================================================
## DAY 11 – SOUND & ATMOSPHERE
## FILE: 05_challenge_extension.rpy
## PURPOSE: Extension challenges for advanced / fast-finishing students
##
## These go BEYOND the main lesson. Students who finish early can explore:
##
##   CHALLENGE A — Queue music (seamless track transitions)
##   CHALLENGE B — Volume control (quieter music under tense dialogue)
##   CHALLENGE C — Player-controlled audio (let the player choose the mood)
##   CHALLENGE D — Emotional contrast (intentionally mismatched music)
##
## Each challenge is self-contained — students pick whichever interests them.
## =============================================================================

define narrator = Character(None)
define echo     = Character("Echo",  color="#C87BB5")
define finn     = Character("Finn",  color="#7BC8A4")


## =============================================================================
## CHALLENGE A: Queue Music
## Goal: Learn to line up tracks so they play back-to-back seamlessly
## =============================================================================
##
## queue music lines up the NEXT track to play immediately when the current
## one ends. Great for: intro stingers → main theme, or building tension
## across multiple tracks without any gap.

label challenge_a_queue:

    narrator "CHALLENGE A: Queue Music"
    narrator "Watch for the seamless transition between two tracks."

    ## First track plays immediately
    play music "audio/theme.mp3"

    scene bg_town

    finn "We're heading into town."

    echo "I hear it's been quiet lately. Too quiet."

    narrator "The road stretched ahead."

    ## Queue the second track — it plays the moment theme.mp3 ends
    ## No gap. No fade. Just a seamless switch.
    queue music "audio/mystery_ambient.mp3"

    finn "Something feels different today."

    narrator "The second track will start automatically when the first one finishes."
    narrator "Try looping a short track into a longer one — or a tense intro into a calm theme."

    stop music fadeout 2.0
    return


## =============================================================================
## CHALLENGE B: Volume Control
## Goal: Fade music under intense dialogue moments
## =============================================================================
##
## You can set the music volume temporarily lower during important dialogue,
## then bring it back up. This is called "ducking" in professional audio.
##
## In Ren'Py, use: set music volume 0.3  (0.0 = silent, 1.0 = full volume)

label challenge_b_volume:

    narrator "CHALLENGE B: Volume Ducking"
    narrator "Notice how the music gets quieter during the important line."

    play music "audio/tense_strings.mp3" fadein 1.0

    scene bg_street_night

    echo "I found something in the alley."

    finn "What was it?"

    ## Fade music DOWN — so the next line really hits
    set music volume 0.2 delay 0.5    ## 0.2 = very quiet, fades over 0.5 seconds

    echo "It was a photograph. Of us. From last year."

    narrator "The quiet makes that line land harder, right?"

    ## Bring it back up
    set music volume 1.0 delay 1.0

    finn "That's not possible. Nobody knew we were there."

    stop music fadeout 2.0

    narrator "Try this in your own project: pick one BIG reveal line."
    narrator "Duck the music just before it. See if it feels more dramatic."

    return


## =============================================================================
## CHALLENGE C: Player-Controlled Mood
## Goal: Let the player CHOOSE the music — an interactive audio design choice
## =============================================================================
##
## This is a more advanced concept: giving the player agency over the atmosphere.
## Some games let you choose your playlist. This is a simple version of that.

label challenge_c_player_choice:

    narrator "CHALLENGE C: Let the player choose the mood."

    scene bg_living_room

    narrator "You settle in for the evening. What kind of night is it?"

    menu:
        "A peaceful night — soft music please":
            play music "audio/cozy_interior.mp3" fadein 2.0
            narrator "The room feels warm and safe."
            echo "Tonight, everything is fine."
            jump challenge_c_end

        "A restless night — something feels off":
            play music "audio/mystery_ambient.mp3" fadein 2.0
            narrator "The shadows feel heavier than usual."
            echo "Tonight... I'm not so sure."
            jump challenge_c_end

        "A tense night — danger is close":
            play music "audio/tense_strings.mp3" fadein 1.0
            narrator "Every sound makes you jump."
            echo "Tonight, something is wrong."
            jump challenge_c_end

label challenge_c_end:

    narrator "Notice: the STORY was the same. The player's EMOTION was different."
    narrator "You gave the player control over their own mood. That's advanced design."

    stop music fadeout 2.0
    return


## =============================================================================
## CHALLENGE D: Emotional Contrast (Ironic/Comic Use of Music)
## Goal: Use MISMATCHED music intentionally for ironic or comic effect
## =============================================================================
##
## Mismatched music isn't always a mistake. Sometimes it's a TOOL:
##   - Happy music during a sad scene = haunting, disturbing
##   - Dramatic music during something trivial = comedy
##   - Lullaby during a tense scene = eerie, unsettling
##
## This technique is used in horror films and dark comedies all the time.

label challenge_d_contrast:

    narrator "CHALLENGE D: Intentional Mismatch."
    narrator "This scene is stressful. But listen to the music choice..."

    ## Happy, upbeat music during a tense scene
    play music "audio/cozy_interior.mp3" fadein 1.0

    scene bg_abandoned_building

    finn "The building is on fire."

    echo "I know."

    finn "Should we... do something?"

    echo "Probably."

    narrator "Neither of them moved."

    play sound "audio/door_slam.wav"

    finn "That was the last exit."

    echo "Yep."

    narrator "They looked at each other."
    narrator "The cheerful music continued."

    stop music fadeout 2.0

    narrator "Did the mismatch make it feel funny? Disturbing? Both?"
    narrator "THAT feeling — that tension between sound and image — is a design tool."
    narrator "Use it carefully. Use it intentionally."

    return


## =============================================================================
## HOW TO RUN THESE CHALLENGES
## =============================================================================
##
## Add a menu in your script.rpy to jump to any challenge:
##
##   label start:
##       menu:
##           "Challenge A — Queue Music":
##               jump challenge_a_queue
##           "Challenge B — Volume Ducking":
##               jump challenge_b_volume
##           "Challenge C — Player Choice":
##               jump challenge_c_player_choice
##           "Challenge D — Emotional Contrast":
##               jump challenge_d_contrast
##
## Or just jump directly to the one you want to explore.
## =============================================================================
