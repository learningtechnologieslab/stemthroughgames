# =============================================================================
#  DAY 6 EXAMPLE: Backgrounds & Visual Storytelling
#  STEM through Games — Middle School RenPy Unit
#
#  HOW TO USE THIS FILE:
#    1. Copy this entire "renpy_examples" folder into your RenPy projects folder
#    2. Open RenPy Launcher and click "Launch Project"
#    3. Read through each section — the comments explain what's happening!
#
#  WHAT THIS COVERS:
#    - The scene command
#    - Transitions (dissolve, fade, pixellate)
#    - How the same words feel different with different backgrounds
#    - Color and mood
#    - Multiple scene changes in one story
# =============================================================================


# =============================================================================
#  CHARACTERS
#  Define who is speaking. "color" sets the name tag color in the dialogue box.
# =============================================================================

define a = Character("Alex",   color="#1D9E75")   # teal
define j = Character("Jordan", color="#E8940A")   # amber
define n = Character("Narrator")


# =============================================================================
#  IMAGES
#
#  RenPy looks for images in the /game/images/ folder.
#  The filename (without the extension) becomes the scene name.
#
#  For this example we use color fills so you don't need image files.
#  See images/README.txt for instructions on swapping in real backgrounds.
#
#  Examples of what the real filenames would look like:
#    game/images/classroom.png    →    scene classroom
#    game/images/hallway.png      →    scene hallway
#    game/images/cafeteria.png    →    scene cafeteria
#    game/images/park_day.png     →    scene park_day
#    game/images/park_night.png   →    scene park_night
# =============================================================================

# Color-fill placeholder backgrounds (so this script runs without image files)
# Each "image" keyword defines a name RenPy can use with the scene command.
# Solid colors let you see the mood effect even without real artwork.

image classroom   = Solid("#D4E8F0")   # cool blue — calm, ordinary school day
image hallway     = Solid("#2C2C3E")   # dark purple-gray — tense, ominous
image cafeteria   = Solid("#F5F0E8")   # warm cream — busy, social, comfortable
image park_day    = Solid("#A8D5A2")   # bright green — hopeful, free, open
image park_night  = Solid("#0D1B2A")   # deep navy — mysterious, lonely
image storm       = Solid("#3D3D3D")   # heavy gray — threatening, dangerous
image library     = Solid("#C8A882")   # warm brown — cozy, thoughtful, safe


# =============================================================================
#  START
# =============================================================================

label start:

    # -------------------------------------------------------------------------
    #  SECTION 1: THE scene COMMAND — BASICS
    # -------------------------------------------------------------------------

    # The scene command sets the background.
    # Anything that was on screen before gets cleared.

    scene classroom

    n "Welcome to the classroom. Notice the background color — cool blue."
    n "Cool blues often feel calm, ordinary, or a little sad."
    n "This is where our story begins."

    a "Morning. Another Monday."
    j "Did you finish the science project?"
    a "...I forgot."


    # -------------------------------------------------------------------------
    #  SECTION 2: TRANSITIONS — Adding with dissolve and with fade
    # -------------------------------------------------------------------------

    # "with dissolve" smoothly blends from the old background to the new one.
    # Without it, the change is instant (jarring).
    # Try removing "with dissolve" below and see what happens!

    scene hallway with dissolve

    n "The hallway. Same characters, same conversation — but notice how the mood shifted."
    n "Dark backgrounds feel heavier. More private. A little dangerous."

    a "I can't believe I forgot. The project is 30 percent of our grade."
    j "..."
    j "I'll cover for you. Tell Ms. Rivera your printer broke."

    a "You'd do that?"


    # -------------------------------------------------------------------------
    #  SECTION 3: THE SAME WORDS, TWO DIFFERENT BACKGROUNDS
    #
    #  This is the big lesson: visuals change meaning.
    #  Read both versions and notice how you FEEL differently
    #  even though the dialogue is identical.
    # -------------------------------------------------------------------------

    scene cafeteria with dissolve

    n "=== VERSION A: Bright cafeteria ==="
    n "Same words coming up. Watch how the bright background changes the feeling."

    a "I need to tell you something."
    j "What is it?"
    a "I think I made a mistake."
    j "We can fix it. Whatever it is."

    # Now the exact same dialogue — different background
    scene hallway with fade

    n "=== VERSION B: Dark hallway ==="
    n "Same words. Different background. Same story — different FEELING."

    a "I need to tell you something."
    j "What is it?"
    a "I think I made a mistake."
    j "We can fix it. Whatever it is."

    n "Did you notice the difference? The words didn't change."
    n "The background did all the work."


    # -------------------------------------------------------------------------
    #  SECTION 4: COLOR AND MOOD — A Visual Tour
    #
    #  Each scene below has a short description of what that color communicates.
    #  Try changing the colors in the image definitions at the top of this file!
    # -------------------------------------------------------------------------

    scene park_day with dissolve

    n "GREEN — Natural, hopeful, open, free."
    n "Stories that take place outside during the day often feel like things could go right."

    a "Maybe it'll be okay. It's a nice day."
    j "Yeah. Come on — let's think this through."


    scene park_night with dissolve

    n "DEEP NAVY — Mysterious, lonely, uncertain, a little scary."
    n "The same park. The same bench. But everything feels different at night."

    a "I keep thinking about what I should have done."
    j "Hey. You're okay. We're still here."


    scene storm with dissolve

    n "HEAVY GRAY — Danger, tension, pressure, no easy way out."
    n "A storm background makes even quiet dialogue feel urgent."

    a "She's going to find out."
    j "I know."
    a "What do we do?"


    scene library with dissolve

    n "WARM BROWN — Cozy, thoughtful, safe, focused."
    n "The library changes the energy. Problems feel solvable here."

    a "Okay. I'm going to talk to Ms. Rivera. Tell her the truth."
    j "That's the right call."
    a "Will you come with me?"
    j "Obviously."


    # -------------------------------------------------------------------------
    #  SECTION 5: TRANSITIONS — A Comparison
    #
    #  Try each transition and notice what it feels like.
    # -------------------------------------------------------------------------

    scene classroom with dissolve

    n "=== TRANSITION COMPARISON ==="
    n "You just saw 'with dissolve' — a gentle blend."
    n "Now watch 'with fade' — goes to black first, then reveals."

    scene hallway with fade

    n "That was 'with fade.' More dramatic. Feels like time passed."
    n "Now 'with pixellate' — a glitchy, digital effect."

    scene cafeteria with pixellate

    n "That was 'with pixellate.' Fun, techy, a bit disorienting."
    n "Use transitions to match the emotion of the moment."
    n "A sad goodbye might use 'fade.' A dream sequence might use 'pixellate.'"


    # -------------------------------------------------------------------------
    #  SECTION 6: REFERENCING THE SETTING IN DIALOGUE
    #
    #  Good visual storytelling connects what characters SAY
    #  to what the BACKGROUND shows. Don't let the visuals be invisible.
    # -------------------------------------------------------------------------

    scene library with dissolve

    n "Notice how the dialogue below mentions the setting."
    n "This makes the background feel intentional, not just decoration."

    a "I've been hiding in here all week."
    j "The library?"
    a "It's the only place that doesn't feel like everything's falling apart."
    j "You know they're going to restack those shelves you've been sitting behind."
    a "I have maybe three more days."


    scene park_day with dissolve

    n "Final scene. The resolution."
    n "We're back to green — hope, relief, moving forward."

    a "She was actually really understanding."
    j "See? I told you."
    a "I still have to redo the whole project by Thursday."
    j "I'll help. We'll get it done."

    a "Thanks for being here. This whole week."
    j "Always."

    n "The end."
    n ""
    n "--- WHAT TO TRY NEXT ---"
    n "1. Change the color values in the 'image' definitions at the top."
    n "2. Swap in real PNG files from your images folder."
    n "3. Try telling a 3-scene story using ONLY background changes — no dialogue."
    n "4. Take one scene and play it with 3 different backgrounds. Which fits best?"

    return
