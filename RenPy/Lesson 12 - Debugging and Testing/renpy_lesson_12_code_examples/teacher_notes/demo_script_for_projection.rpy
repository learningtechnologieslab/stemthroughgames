# =============================================================================
# TEACHER DEMO SCRIPT
# Used during: Direct Instruction / Demo segment (Slides 5–6)
# Time: ~5 minutes
#
# PURPOSE:
#   Project this on screen. Deliberately introduce the bug LIVE in front of
#   students, launch RenPy, show the error console, then fix it together.
#   This is more powerful than showing a pre-broken script because students
#   see the bug being created AND fixed in real time.
#
# SUGGESTED FLOW:
#   1. Show this working script — launch it, demonstrate it runs.
#   2. DELETE the colon from "label start:" live on screen.
#   3. Try to launch. Show the error console together.
#   4. Ask students: "What does the error say? What line?"
#   5. Fix it, save, relaunch. Celebrate together.
#
# THEN: Add a second live bug — delete the indentation from line under menu.
#       Let students diagnose it this time.
# =============================================================================

define a = Character("Alex", color="#2E86AB")
define b = Character("Billie", color="#A23B72")

# ── WORKING VERSION (show this first) ──────────────────────────────────────

label start:
    a "Hey Billie, did you finish the science project?"
    b "Almost! I just need to write the conclusion."
    a "Want me to read it when you're done?"

    menu:
        "Yes, please proofread it":
            b "That would be so helpful, thanks!"
            jump helped

        "No thanks, I'll figure it out":
            b "Fair enough. I'll let you know how it goes."
            jump solo

label helped:
    a "Okay, I read it. It's really good — just fix the last paragraph."
    b "You're the best. I owe you one."
    return

label solo:
    b "Turned it in. Fingers crossed!"
    a "I'm sure you did great."
    return


# =============================================================================
# BROKEN VERSION (for reference — DO NOT show students this file)
# Below is what the script looks like after introducing Bug #1 live:
#
#   label start       ← missing colon
#       a "Hey Billie..."
#
# And after introducing Bug #2 live:
#
#   menu:
#   "Yes, please..."  ← missing indentation (should be 8 spaces in)
# =============================================================================
