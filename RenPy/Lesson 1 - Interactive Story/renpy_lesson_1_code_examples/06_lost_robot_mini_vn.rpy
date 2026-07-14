# ============================================================
#  STEM THROUGH GAMES — Introduction to RenPy
#  Example 6: The Lost Robot  (Complete Mini Visual Novel)
#  Concept: Everything from Examples 1–5 working together
# ============================================================
#
#  THIS EXAMPLE USES:
#    ✓ Characters with names and colors       (Example 2)
#    ✓ Narration and dialogue                 (Example 1 & 2)
#    ✓ A player choice menu                  (Example 3)
#    ✓ Labels and jumps for branching paths  (Example 4)
#    ✓ Variables that track decisions        (Example 5)
#    ✓ if/else to create lasting consequences (Example 5)
#
#  STORY SUMMARY:
#    You are a student who finds a small robot in the schoolyard.
#    Your choices determine whether you keep it, return it, or
#    report it — and the ending changes based on what you did.
#
#  FOR TEACHERS:
#    This is a good "putting it all together" demo for Day 2-3.
#    Ask students to map out the story branches on paper first,
#    then show how the map translates to RenPy code.
#
#  CHALLENGE FOR STUDENTS:
#    - Add a fourth choice in the first menu
#    - Create a secret "best ending" that requires two specific choices
#    - Add a character called "principal" who appears in the ending
# ============================================================

# ── CHARACTERS ───────────────────────────────────────────────
define you    = Character("You",    color="#00c9a7")
define robo   = Character("Robo",   color="#a78bfa")  # the robot!
define priya  = Character("Priya",  color="#ffd166")
define teacher = Character("Mr. Santos", color="#f97316")

# ── VARIABLES ────────────────────────────────────────────────
default kept_robot    = False
default told_someone  = False
default robot_trust   = 0     # goes up when you're kind to Robo


# ================================================================
#  ACT 1 — THE DISCOVERY
# ================================================================
label start:

    "It's a Tuesday morning. You're cutting across the schoolyard."

    "You almost trip over something small and metallic half-buried in the mud."

    "You look down."

    "It's a robot — about the size of a lunchbox — blinking up at you."

    robo "...Hello. Are you a friend?"

    you "Uh."

    robo "My sensors indicate you are surprised. That is a normal human response."

    menu:
        "\"Yes, I'm a friend.\"":
            $ robot_trust += 2
            you "Yes! I'm a friend. Don't worry."
            robo "Trust level updated. Thank you."
            jump act2_friendly

        "\"What ARE you?\"":
            $ robot_trust += 1
            you "What are you? Where did you come from?"
            robo "I am Robo. My origin point is... unclear."
            jump act2_curious

        "Back away slowly.":
            $ robot_trust += 0
            you "Okay. Okay. This is fine."
            robo "Your heart rate suggests otherwise."
            jump act2_cautious


# ================================================================
#  ACT 2 — THREE APPROACHES
# ================================================================

label act2_friendly:
    "You pick up Robo carefully. It feels warm."
    robo "You are gentle. I like that."
    you "What do you need? Are you lost?"
    robo "I believe so. But I feel less lost now."
    jump act3_the_choice

label act2_curious:
    "You crouch down and examine Robo closely."
    you "You're incredible. Did someone build you?"
    robo "Affirmative. But I do not know who."
    you "We'll figure it out together."
    robo "Together. I like that word."
    jump act3_the_choice

label act2_cautious:
    "You stand at a distance, watching Robo blink."
    robo "You do not need to be afraid. I am very small."
    you "It's not that... Okay, it's a little that."
    robo "That is acceptable. I will wait."
    "Something about its patience makes you feel bad."
    $ robot_trust += 1
    jump act3_the_choice


# ================================================================
#  ACT 3 — THE CHOICE
# ================================================================
label act3_the_choice:

    "Your friend Priya comes running across the yard."

    priya "There you are! Why are you staring at the— OH MY GOSH IS THAT A ROBOT?"

    you "Keep it down!"

    priya "Sorry, sorry. What are you going to do with it?"

    menu:
        "Keep Robo a secret for now.":
            $ kept_robot = True
            $ told_someone = False
            you "I'm going to keep it quiet until I know more."
            priya "That's either very smart or very illegal."
            jump act4_secret

        "Tell a teacher right away.":
            $ kept_robot = False
            $ told_someone = True
            you "We should tell Mr. Santos. This is too big for us."
            priya "Responsible. I like it."
            jump act4_report

        "Ask Robo what IT wants.":
            $ kept_robot = False
            $ told_someone = False
            you "Hey Robo — what do YOU want us to do?"
            robo "I want... to find where I belong."
            you "Then we'll help you find that."
            $ robot_trust += 2
            jump act4_search


# ================================================================
#  ACT 4 — THE PATHS
# ================================================================

label act4_secret:
    "You hide Robo in your backpack. It fits perfectly."
    robo "It is dark in here. But I do not mind."
    "You spend the whole school day distracted."
    "By lunch, half the grade seems to know anyway."
    jump ending

label act4_report:
    "Mr. Santos stares at Robo for a very long time."
    teacher "I... see. This is unprecedented."
    robo "Hello, adult human. I mean no harm."
    teacher "...I believe you."
    "The school called the local university. Scientists were very excited."
    jump ending

label act4_search:
    "You and Priya spend the day searching for clues."
    priya "There's a maker fair at the community center last weekend!"
    robo "Maker fair. Cross-referencing... match found."
    "A little kid had left Robo there by accident."
    "You returned Robo that afternoon."
    jump ending


# ================================================================
#  ENDING — changes based on what the player did
# ================================================================
label ending:

    "A week later, things have settled down."

    # ── Check how much trust you built with Robo ──────────────
    if robot_trust >= 4:
        robo "I have sent you a message. Check your email."
        "The message just said: THANK YOU FRIEND."
        "You smiled for the rest of the day."

    elif robot_trust >= 2:
        "You got a postcard in the mail."
        "It had a small drawing of a robot waving."
        "No return address."

    else:
        "You never heard from Robo again."
        "Sometimes you wondered if it had really happened at all."

    # ── Check the major story choice ──────────────────────────
    if told_someone:
        "Your photo ended up in the school newsletter."
        teacher "\"Student Acts Responsibly in Unusual Situation.\""
        you "I am never living this down."
        priya "Worth it."

    elif kept_robot:
        "No one officially knew what happened."
        "You were okay with that."

    else:
        "You learned something important that week:"
        you "\"Asking what someone else needs is usually the right move.\""

    # ── Final line ────────────────────────────────────────────
    "And somewhere out there, a small robot kept blinking."

    return
