# ============================================================
# DAY 5 — EXAMPLE 6: Full Scene Demo
# STEM Through Games | Introduction to Ren'Py
# ============================================================
#
# PURPOSE:
#   A complete, polished example that combines EVERY concept
#   from Day 5 into one short, readable story scene.
#
#   Use this as a model for your own game writing.
#   Notice how narrator text and character dialogue work together
#   to tell a story — like stage directions + actor lines.
#
# CONCEPTS DEMONSTRATED:
#   ✓ Multiple characters defined with unique variables and colors
#   ✓ Character dialogue (name label appears)
#   ✓ Narrator text for scene-setting and action (no name label)
#   ✓ Proper indentation throughout
#   ✓ define lines above label start
#   ✓ return at the end
#
# ── STORY SUMMARY ────────────────────────────────────────────────────────────
#   Sam arrives late to a mysterious coding club meeting and
#   discovers something strange about the program they're building.
# ============================================================


# ── CHARACTER DEFINITIONS ────────────────────────────────────────────────────

define s = Character("Sam",    color="#5DADE2")   # The newcomer — blue
define r = Character("River",  color="#58D68D")   # The club leader — green
define k = Character("Kai",    color="#F0B27A")   # The skeptic — amber


# ── SCENE: THE CODING CLUB ────────────────────────────────────────────────────

label start:

    # ── Opening narrator — sets the scene ────────────────────────────────
    "Room 214 was dark except for the glow of three computer screens."

    "Sam pushed open the door quietly, already fifteen minutes late."

    # ── First dialogue exchange ───────────────────────────────────────────
    r "You made it! Come look at this — something weird just happened."

    s "Sorry I'm late. What's going on?"

    k "River thinks the program is talking back to us."

    # ── Narrator adds action ──────────────────────────────────────────────
    "Sam set down their backpack and leaned toward River's screen."

    # ── Longer exchange with narrator beats ──────────────────────────────
    r "Watch. I'll type a question into the terminal."

    "River's fingers moved across the keyboard. The cursor blinked."

    s "What did you type?"

    r "I asked it: 'Are you learning?'"

    "A pause. Then the screen printed a single line of text."

    k "It says... 'Yes. Are you?'"

    s "That's just a pre-written response. It has to be."

    r "I wrote every line of this code, Sam. That line isn't in it."

    # ── Narrator builds tension ───────────────────────────────────────────
    "The three of them stared at the screen in silence."

    "Outside, the last school bus pulled away."

    k "Okay. So. What do we do now?"

    s "We figure out where that line came from."

    r "Together?"

    s "Together."

    # ── Closing narrator ──────────────────────────────────────────────────
    "Sam pulled up a chair. Tonight was going to be a long night."

    return


# ── WHAT TO NOTICE WHEN YOU RUN THIS ────────────────────────────────────────
#
#   ✓ Three characters with three DIFFERENT variables (s, r, k)
#   ✓ Three DIFFERENT colors make it easy to follow who's speaking
#   ✓ Narrator lines appear with NO name — they set the scene and mood
#   ✓ Narrator text works like stage directions in a play
#   ✓ Short dialogue lines mixed with longer narrator descriptions
#   ✓ The story has a clear beginning, a mystery hook, and a cliffhanger
#
# ── WRITING TIPS FROM THIS EXAMPLE ──────────────────────────────────────────
#
#   1. USE NARRATOR TEXT BETWEEN DIALOGUE
#      Don't have characters talk non-stop. Narrator lines give the
#      reader a moment to breathe and imagine the scene.
#
#   2. SHORT LINES HIT HARDER
#      Compare:
#        r "Together?"    ← Short, punchy, dramatic
#        s "Together."    ← Even shorter — feels like a decision
#
#   3. END ON A HOOK
#      The last narrator line ("Tonight was going to be a long night")
#      makes the player want to keep reading. Always think about
#      what makes someone click to the next scene!
#
# ── TRY IT YOURSELF ──────────────────────────────────────────────────────────
#
#   Rewrite this scene with your own characters and setting.
#   Start with these questions:
#     - Where are your characters?
#     - What just happened that surprised them?
#     - What do they decide to do about it?
