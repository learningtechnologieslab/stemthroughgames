# ============================================================
#  DAY 7 — EXAMPLE 3: Nested Menus (Choice Inside a Choice)
#  Challenge extension — a second menu inside one path.
#
#  CONCEPTS COVERED:
#    • Nested  menu:  blocks
#    • Three possible endings from one starting scene
#    • How deeper branching creates more player agency
#
#  STORY: You find a mysterious box. What do you do?
#         If you open it, a second choice appears.
# ============================================================

define n = Character(None)          # plain narration
define you = Character("You", color="#FFD166")


label start:

    scene bg_room
    with fade

    n "You find a small wooden box on the doorstep."
    n "There is no note. No return address. Just your name, carved into the lid."

    you "That's... unexpected."

    # ── FIRST CHOICE ──────────────────────────────────────
    menu:
        "Open the box":
            jump open_box

        "Leave the box alone and go inside":
            jump ignore_box


# ──────────────────────────────────────────────────────────
label open_box:

    n "You lift the lid."
    n "Inside: a single key on a red ribbon, and a folded map."
    n "The map shows a building three streets away."
    n "A red X marks a room on the second floor."

    you "Okay. This is either very exciting or very dangerous."

    # ── SECOND (NESTED) CHOICE ────────────────────────────
    # This menu only appears if the player opened the box.
    # The player who chose 'leave it alone' never sees this.
    menu:
        "Follow the map right now":
            jump follow_map

        "Keep the key, but wait until morning":
            jump wait_for_morning


# ──────────────────────────────────────────────────────────
label follow_map:

    scene bg_street_night
    with dissolve

    n "The building is an old theatre, dark and locked."
    n "Your key fits the side door perfectly."
    n "Inside, someone has left a single spotlight burning on an empty stage."
    n "And on the stage: a letter addressed to you."

    you "I have so many questions."

    n "The letter contains answers to questions you haven't even thought to ask yet."
    n "Your life is about to get very strange — and very interesting."

    "           ~ THE END: The Key Route ~"
    return


# ──────────────────────────────────────────────────────────
label wait_for_morning:

    n "You place the box on your bedside table and try to sleep."
    n "You mostly fail."
    n "At sunrise you go to the building."
    n "The side door is standing open. The room upstairs is empty."
    n "Only a folded note remains: 'You almost made it in time.'"

    you "...Great."

    n "Some mysteries are not patient."

    "           ~ THE END: The Waiting Route ~"
    return


# ──────────────────────────────────────────────────────────
label ignore_box:

    n "You step around the box and go inside."
    n "You make tea. You read a book. You go to bed."
    n "In the morning, the box is gone."
    n "So is the front garden — replaced by a door to somewhere else entirely."

    you "I probably should have opened it."

    n "Probably."

    "           ~ THE END: The Cautious Route ~"
    return
