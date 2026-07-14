## ============================================================
##  DAY 8 — EXAMPLE 5: Multiple Variables Working Together
##  STEM Through Games · Ren'Py Programming
## ============================================================
##
##  CONCEPT:  Using several variables at once to track a
##            relationship meter AND a morality score.
##            This is how real RPGs create the feeling that
##            "the world remembers everything you did."
##
##  VARIABLES IN THIS FILE:
##    trust       Integer   How much the companion trusts the player (0–100)
##    honesty     Integer   How honest the player has been (0–100)
##    found_map   Boolean   Whether the player found a hidden map
##    companion   String    The companion's name (set by player choice)
##
##  NEW SKILLS:
##    • Checking TWO conditions at once:  if trust >= 50 and honesty > 30:
##    • Using  or  :                      if trust >= 80 or found_map:
##    • Setting a string variable from a menu choice
##    • Displaying variable values mid-dialogue
##    • A final ending that varies based on multiple factors
##
## ============================================================

# ── CHARACTER DEFINITIONS ─────────────────────────────────────
define e  = Character("Explorer",  color="#5EC8E5")
define p  = Character("???",       color="#D4A5FF")     # name set later
define n  = Character(None, kind=nvl)


# ── VARIABLE DECLARATIONS ─────────────────────────────────────
default trust       = 30    # Companion trust level — starts at a neutral 30
default honesty     = 50    # Player honesty score  — starts at a neutral 50
default found_map   = False # Whether the player found the hidden map
default companion   = "???" # Companion's name, chosen by the player


# ── ACT 1: MEETING THE COMPANION ─────────────────────────────
label start:

    scene bg bg_crossroads with fade

    e "I reach a crossroads deep in the forest."
    e "A figure sits on a stone milestone, studying a tattered scroll."

    $ p = Character(companion, color="#D4A5FF")
    # ^ We update the Character object to use the companion variable.
    #   Right now it still shows "???" — we'll fix that soon.

    p "Oh! A traveller. Are you lost too?"
    e "Maybe. Are you?"
    p "Completely. I'm looking for the Crystal Vale. Have you heard of it?"

    # ── NAME CHOICE ───────────────────────────────────────────
    #
    #   Storing a String in a variable means dialogue can use it.
    #   We also redefine the Character object so the name appears
    #   correctly in the dialogue box from this point on.

    e "What's your name?"

    menu:
        "\"I'm travelling with Mira.\"":
            $ companion = "Mira"
        "\"I'm travelling with Rolan.\"":
            $ companion = "Rolan"
        "\"I'm travelling with Ash.\"":
            $ companion = "Ash"

    $ p = Character(companion, color="#D4A5FF")    # Update the display name

    p "That's me! [companion]. Pleased to meet you."
    e "Nice to meet you, [companion]. I'm heading toward the mountains."
    p "Same direction! Mind if I travel with you?"

    jump act2_trust_building


# ── ACT 2: TRUST-BUILDING CHOICES ────────────────────────────
label act2_trust_building:

    scene bg bg_forest_path with dissolve

    n "--- Later that afternoon ---"

    # ── CHOICE 1: Share your food ──────────────────────────────
    p "I haven't eaten since morning. This walk is taking longer than I expected."

    menu:
        "Share your last bread roll.":
            $ trust   += 20        # Generous action → trust goes up
            $ honesty += 10        # Honest/kind action → honesty goes up
            p "Oh, thank you! You didn't have to do that."
            e "We can share. It's only a bread roll."

        "\"Sorry, it's my last one.\"":
            # Telling the truth but not helping → small trust dip
            $ trust   -= 5
            $ honesty += 15        # Honest (even if unhelpful)
            p "Oh. That's... okay. I understand."
            e "I feel a little guilty but I was honest."

        "Pretend you don't have any food.":
            $ trust   += 0         # They don't know, so trust unchanged...
            $ honesty -= 20        # ...but honesty drops for the deception
            e "Uh... I don't have anything. Sorry."
            p "Right. Okay."
            n "You lie. The bread roll sits in your pocket."

    n "Trust: [trust] / 100    Honesty: [honesty] / 100"

    # ── CHOICE 2: Hidden fork in the road ─────────────────────
    scene bg bg_forest_path with dissolve

    e "We reach a fork. One path looks quick but risky. The other is safe but slow."

    menu:
        "Take the quick path without telling [companion] it's dangerous.":
            $ trust   -= 10
            $ honesty -= 15
            p "This path feels wrong. Did you know about the risks?"
            e "...I should have said something."

        "Tell [companion] about both options and decide together.":
            $ trust   += 15
            $ honesty += 20
            p "I appreciate you being upfront. Let's take the safe route."
            e "We take the longer path. [companion] seems pleased."

        "Let [companion] choose.":
            $ trust   += 10
            p "Really? Okay — safe path. I don't like taking chances."
            e "Fine by me."

    n "Trust: [trust] / 100    Honesty: [honesty] / 100"

    # ── CHOICE 3: Discover a hidden map ───────────────────────
    scene bg bg_ruins with dissolve

    e "We pass some old ruins. Something catches my eye in the crumbling wall."

    menu:
        "Investigate the ruins.":
            $ found_map = True
            e "Hidden inside a hollow stone — an old map!"
            p "That could show us the way to Crystal Vale!"

        "Keep walking — no time for detours.":
            e "I almost stop, but we're making good time. I walk on."

    jump act3_finale


# ── ACT 3: THE FINALE ─────────────────────────────────────────
label act3_finale:

    scene bg bg_mountain_pass with fade

    n "--- The mountain pass ---"
    n "Trust: [trust] / 100    Honesty: [honesty] / 100"

    p "We've made it to the mountain pass."

    # ── MULTI-VARIABLE ENDING CHECK ───────────────────────────
    #
    #   The ending is determined by COMBINING variables.
    #   "and" means BOTH conditions must be True.
    #   "or"  means AT LEAST ONE condition must be True.

    if trust >= 70 and honesty >= 60:
        # Best outcome: high trust AND high honesty
        p "[companion] stops and faces you."
        p "I want to say something. I haven't trusted many travellers."
        p "But you've been kind and honest with me this whole journey."
        p "I hope we find Crystal Vale together — and more after that."
        e "I feel like I've made a real friend."
        jump ending_best

    elif trust >= 50 or found_map:
        # Good outcome: decent trust, OR the map helped bridge the gap
        if found_map:
            p "This map you found... I think I can find my way from here."
        p "You've been a decent travelling companion, [companion] says."
        p "I hope our paths cross again."
        e "A solid friendship, even if not a deep one."
        jump ending_good

    elif honesty >= 70:
        # Honest but cold: the player was truthful but not warm
        p "You haven't always been easy to travel with."
        p "But I'll say this — you've never lied to me."
        p "That counts for something."
        e "Honest, at least. That's something."
        jump ending_honest

    else:
        # Low trust and low honesty
        p "I'm going to find my own way from here."
        p "No offence — we just never quite clicked."
        e "I understand. Safe travels, [companion]."
        jump ending_alone


# ── ENDINGS ───────────────────────────────────────────────────
label ending_best:
    scene bg bg_crystal_vale with fade
    e "We find Crystal Vale together."
    e "Final stats: Trust [trust], Honesty [honesty]."
    return

label ending_good:
    scene bg bg_mountain_pass with fade
    e "A good journey, even if not a perfect one."
    e "Final stats: Trust [trust], Honesty [honesty]."
    return

label ending_honest:
    scene bg bg_crossroads with fade
    e "Honest but cold. There are worse ways to be remembered."
    e "Final stats: Trust [trust], Honesty [honesty]."
    return

label ending_alone:
    scene bg bg_forest_path with fade
    e "I continue alone. The mountains wait."
    e "Final stats: Trust [trust], Honesty [honesty]."
    return


## ============================================================
##  TEACHER NOTES
## ============================================================
##
##  LOGIC OPERATORS introduced in this file:
##    and   — BOTH conditions must be True
##    or    — AT LEAST ONE condition must be True
##    not   — flips True to False and vice versa
##
##  EXAMPLES:
##    if trust >= 70 and honesty >= 60:   # strict best ending
##    if trust >= 50 or found_map:        # flexible good ending
##    if not has_key:                     # same as  if has_key == False:
##
##  VARIABLE TRACE EXERCISE (classroom activity):
##    Have students predict the ending BEFORE running the game
##    by writing down trust/honesty after each choice.
##    Then run the game to verify.
##
##  DISCUSSION: "Real game" connections
##    • Mass Effect     — Paragon/Renegade morality bars
##    • Undertale       — Pacifist/Genocide route tracking
##    • Dragon Age      — Companion approval ratings (like "trust" here)
##    • Firewatch       — Relationship tone with Delilah through choices
##
##  EXTENSION: Ask students to add a third variable —
##    default courage = 50  — that goes up when the player
##    takes risky choices and down for safe ones.
##    How would they add it to the ending check?
##
## ============================================================
