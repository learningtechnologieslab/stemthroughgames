# ============================================================
#  DAY 7 — EXAMPLE 2: The Crossroads (Lesson Starter Scene)
#  The guided-practice example built together in class.
#
#  CONCEPTS COVERED:
#    • Defining characters with  define
#    • scene  and  with fade / dissolve  transitions
#    • Narration vs character dialogue
#    • menu: + jump  branching
#    • Two separate endings with distinct tones
#
#  ASSETS NEEDED (create solid-color placeholder images if
#  you don't have real backgrounds):
#    images/bg_crossroads.png
#    images/bg_forest_light.png
#    images/bg_river_night.png
# ============================================================

# ── CHARACTER DEFINITIONS ─────────────────────────────────
# define gives a character a name tag and speech-bubble color.
# color uses a hex code — no # symbol needed in RenPy.
define narrator = Character(None, kind=nvl)   # narration box style
define alex = Character("Alex", color="#6C63FF")
define stranger = Character("Stranger", color="#00D4B1")


# ── START ─────────────────────────────────────────────────
label start:

    scene bg_crossroads
    with fade

    "The forest path splits ahead of you."
    "Twilight turns the sky the colour of a bruised peach."
    "You have been walking for hours and your feet ache."

    alex "Two paths. Of course there are two paths."
    alex "There's always a choice when you're already tired."

    "To the left, a warm glow flickers between the trees."
    "To the right, the sound of rushing water — and silence."

    menu:
        "Go left — follow the light":
            jump left_path

        "Go right — follow the sound of water":
            jump right_path


# ── LEFT PATH ─────────────────────────────────────────────
label left_path:

    scene bg_forest_light
    with dissolve

    "The glow grows stronger. Lanterns. Dozens of them."
    "They hang between the trees like captured stars."

    alex "Oh. Oh, this is beautiful."

    "A small village comes into view — warm windows, chimney smoke."
    "A figure waves from the nearest doorway."

    show stranger at left
    stranger "Traveller! You look exhausted. Come in — dinner is almost ready."

    alex "I — yes. Thank you."

    jump ending_village


# ── RIGHT PATH ────────────────────────────────────────────
label right_path:

    scene bg_river_night
    with dissolve

    "The shadows part to reveal a moonlit river."
    "The water is black and silver, impossibly still at the edges."

    "A figure sits on a flat stone, skipping pebbles across the surface."
    "They don't look up."

    show stranger at right
    stranger "I wondered if anyone would come this way tonight."

    alex "You were waiting for someone?"

    stranger "Not waiting. Just... hoping."

    jump ending_river


# ── ENDING A: THE VILLAGE ─────────────────────────────────
label ending_village:

    hide stranger
    scene bg_forest_light
    with fade

    "You spend the night in the village."
    "The soup is thick and the fire is warm."
    "For the first time in weeks, you feel completely at home."
    "Tomorrow the road will still be there."
    "Tonight, you rest."

    "                    ~ THE END ~"
    "                  The Village Route"

    return


# ── ENDING B: THE RIVER ───────────────────────────────────
label ending_river:

    hide stranger
    scene bg_river_night
    with fade

    "The stranger hands you a flat pebble without saying a word."
    "You throw it. It skips five times."
    "They smile — a small, private thing."

    "You sit together until the sky begins to lighten."
    "No names were exchanged. None were needed."
    "Some meetings are complete in themselves."

    "                    ~ THE END ~"
    "                  The River Route"

    return
