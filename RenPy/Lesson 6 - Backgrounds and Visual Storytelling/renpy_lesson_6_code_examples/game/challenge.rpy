# =============================================================================
#  DAY 6 STUDENT CHALLENGE: Fill In the Backgrounds!
#  STEM through Games — Middle School RenPy Unit
#
#  YOUR JOB:
#    This story is written — but it has no backgrounds yet.
#    Read each scene carefully, then fill in the scene command
#    with a background that MATCHES the mood.
#
#  HOW TO PLAY:
#    1. Find every line that says:   scene ???
#    2. Replace ??? with a background name from the list below
#    3. Launch the project and see how your choices feel!
#    4. Swap them around. Try the "wrong" background on purpose.
#       What happens to the story?
#
#  AVAILABLE BACKGROUNDS (defined for you at the bottom of this file):
#    classroom    — cool blue, ordinary school day
#    hallway      — dark purple-gray, tense and private
#    cafeteria    — warm cream, busy and social
#    park_day     — bright green, hopeful and open
#    park_night   — deep navy, mysterious and lonely
#    storm        — heavy gray, threatening
#    library      — warm brown, cozy and thoughtful
#
#  AVAILABLE TRANSITIONS (use after "with"):
#    dissolve     — smooth blend (most common)
#    fade         — goes black first, then reveals (dramatic)
#    pixellate    — glitchy, digital feel
#    move         — slide in from the side
#
#  EXAMPLE:
#    scene park_day with dissolve
#
# =============================================================================

define m = Character("Maya",  color="#6B5CE7")
define k = Character("Kai",   color="#1D9E75")
define n = Character("Narrator")

# --- placeholder images (same as main script) ---
image classroom   = Solid("#D4E8F0")
image hallway     = Solid("#2C2C3E")
image cafeteria   = Solid("#F5F0E8")
image park_day    = Solid("#A8D5A2")
image park_night  = Solid("#0D1B2A")
image storm       = Solid("#3D3D3D")
image library     = Solid("#C8A882")


label start:

    # -------------------------------------------------------------------------
    #  SCENE 1
    #  Maya finds out she made the school's robotics team.
    #  She's excited. It's a big deal. Where is she when she hears the news?
    # -------------------------------------------------------------------------

    scene ???                   # <-- REPLACE ??? with your background choice

    n "The list was posted outside the gym."
    m "I made it. I actually made it!"
    k "I KNEW you would. I literally told you."
    m "I can't believe it. This changes everything."


    # -------------------------------------------------------------------------
    #  SCENE 2
    #  Maya has to tell her best friend she won't have time for their
    #  usual Friday hangouts anymore. This is an awkward, sad moment.
    # -------------------------------------------------------------------------

    scene ??? with dissolve     # <-- REPLACE ???

    m "So... I need to tell you something."
    k "That sounds serious."
    m "Practice is Fridays. Every Friday."
    k "Oh."
    m "I'm really sorry."
    k "No, it's — it's okay. I get it."

    n "It didn't feel okay."


    # -------------------------------------------------------------------------
    #  SCENE 3
    #  Maya's first practice goes terribly. She messes up in front
    #  of the whole team. She's embarrassed and wants to disappear.
    # -------------------------------------------------------------------------

    scene ??? with ???          # <-- REPLACE both ???s (background AND transition)

    m "I don't know what happened. My hands just froze."
    k "What did the coach say?"
    m "Nothing. That was almost worse."
    k "You're still on the team."
    m "For now."


    # -------------------------------------------------------------------------
    #  SCENE 4
    #  Late at night. Maya can't sleep. She's sitting outside
    #  thinking about whether to quit the team.
    # -------------------------------------------------------------------------

    scene ??? with ???          # <-- REPLACE both ???s

    n "It was the kind of quiet that makes you think too much."
    m "Maybe I'm just not good enough."
    m "Maybe I only got in because there weren't enough applicants."


    # -------------------------------------------------------------------------
    #  SCENE 5
    #  The next day, Kai tracks Maya down and gives her a pep talk.
    #  This is a warm, turning-point moment. Things feel better.
    # -------------------------------------------------------------------------

    scene ??? with ???          # <-- REPLACE both ???s

    k "You're not quitting."
    m "You don't know that."
    k "You've wanted this since fifth grade. I was THERE."
    m "What if I fail in front of everyone again?"
    k "Then you fail. And then you do it again until you don't."
    m "...That's actually kind of good advice."
    k "I have my moments."


    # -------------------------------------------------------------------------
    #  CHALLENGE EXTENSION:
    #  Write a Scene 6 yourself!
    #  Pick a background, write 3-5 lines of dialogue, and think about
    #  what mood you want the audience to feel at the end of this story.
    # -------------------------------------------------------------------------

    # scene ???
    #
    # n ""
    # m ""
    # k ""

    return
