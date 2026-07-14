# ─────────────────────────────────────────────────────────────────────────────
# 04_display_score.mcfunction
# STEM Through Games — Day 7: Collision Detection
# ─────────────────────────────────────────────────────────────────────────────
#
# PURPOSE
#   Commands to display the player's current score in different ways.
#   Run these at any time from chat, or add them to your Command Block chain.
#
# ─────────────────────────────────────────────────────────────────────────────


# ── Option 1: Sidebar display (always visible, like a scoreboard overlay) ───
#
#   Shows scores for ALL players on the right side of the screen.
#   Run once to activate. Run with "clear" to turn off.
#
/scoreboard objectives setdisplay sidebar score
# To turn off: /scoreboard objectives setdisplay sidebar


# ── Option 2: Show score as a title on screen ────────────────────────────────
#
#   Use this in a chain block to flash the score whenever a coin is collected.
#   The §e color code makes the number gold-yellow.
#
/title @a title "Score: "
/title @a subtitle "Check the sidebar!"


# ── Option 3: Actionbar — shows score at bottom of screen ───────────────────
#
#   Great for a heads-up display that doesn't interrupt gameplay.
#   Put this in a REPEAT chain block to update every tick.
#
#   NOTE: You cannot directly embed a scoreboard value in /title in
#   Minecraft Education Edition without an add-on.  Use the sidebar instead,
#   or display a congratulations message at score thresholds (see below).
#
/title @a actionbar "Coins collected — check sidebar!"


# ── Option 4: Trigger a message when score reaches a milestone ───────────────
#
#   /scoreboard players test checks whether a score falls within a range.
#   Use this in a REPEAT + CONDITIONAL chain to fire when score hits 3.
#
#   Put in a REPEAT block (Unconditional, Always Active):
/scoreboard players test @a score 3 3
#
#   Then in a CONDITIONAL chain block after it:
/title @a title "ALL COINS FOUND!"
/title @a subtitle "Great work!"
/playsound random.levelup @a


# ── Useful score management commands ─────────────────────────────────────────

# Reset one player's score (replace Steve with actual player name)
# /scoreboard players set Steve score 0

# Reset ALL players' scores
# /scoreboard players set @a score 0

# View scores in chat (teacher use)
# /scoreboard players list
