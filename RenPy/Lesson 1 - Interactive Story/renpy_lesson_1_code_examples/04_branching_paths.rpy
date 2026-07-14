# ============================================================
#  STEM THROUGH GAMES — Introduction to RenPy
#  Example 4: Branching Paths
#  Concept: Choices that lead to COMPLETELY different story paths
# ============================================================
#
#  WHAT THIS TEACHES:
#    - "label" creates a named location in your story
#    - "jump" sends the story to a different label
#    - This is how you build a TRUE branching narrative —
#      different choices lead to different scenes, not just
#      different lines of dialogue
#
#  KEY SYNTAX:
#    label my_scene_name:
#        <story lines>
#        jump another_scene
#
#  STORY MAP:
#
#    [start]
#       |
#    [choice]
#      /     \
#  [path_a] [path_b]
#      \     /
#    [ending]
#
#  TRY IT:
#    - Add a third label called "path_c" with its own story
#    - Add a third menu option that jumps to "path_c"
#    - Create two DIFFERENT ending labels instead of one shared one
# ============================================================

define alex = Character("Alex", color="#a78bfa")
define river = Character("River", color="#f97316")


# ── SCENE 1: THE SETUP ───────────────────────────────────────
label start:

    "Alex finds an old, locked box in the school storage room."

    alex "Whoa. I wonder what's inside this thing."

    river "We should probably leave it alone."

    alex "Or... we could try to open it."

    menu:
        "Try to open the box.":
            jump path_open        # ← jumps to the label below

        "Leave the box alone.":
            jump path_leave       # ← jumps to a different label


# ── PATH A: Open the box ─────────────────────────────────────
label path_open:

    "Alex pries the box open. Inside is a stack of old photographs."

    alex "These look like they're from the 1980s..."

    river "Is that... our principal? When she was our age?!"

    alex "She looks so different!"

    "They spent the next hour going through the photos, laughing."

    # After this path, jump to the shared ending
    jump ending


# ── PATH B: Leave the box alone ──────────────────────────────
label path_leave:

    river "Good call. It's probably just old junk anyway."

    alex "You're right. Let's head to class."

    "They left the storage room. Alex glanced back once at the box."

    alex "I'm still kind of curious though."

    river "You're always curious."

    # After this path, jump to the shared ending
    jump ending


# ── SHARED ENDING ─────────────────────────────────────────────
label ending:

    "The school day ended like any other."

    alex "Hey River — same time tomorrow?"

    river "Always."

    "But somewhere in the storage room, the box sat waiting."

    return
