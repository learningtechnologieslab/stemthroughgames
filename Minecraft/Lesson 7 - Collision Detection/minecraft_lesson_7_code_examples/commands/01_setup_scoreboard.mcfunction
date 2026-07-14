# ─────────────────────────────────────────────────────────────────────────────
# 01_setup_scoreboard.mcfunction
# STEM Through Games — Day 7: Collision Detection
# ─────────────────────────────────────────────────────────────────────────────
#
# PURPOSE
#   Run these commands ONCE at the start of your Minecraft world to create
#   the scoreboard objectives the rest of the lesson depends on.
#
# HOW TO USE
#   Option A — Type each command into the chat bar one at a time.
#   Option B — Paste into a one-time Command Block (Impulse, Unconditional,
#              Needs Redstone) and power it with a button.
#
# ─────────────────────────────────────────────────────────────────────────────

# Create the main score objective and show it on the sidebar
/scoreboard objectives add score dummy "Coins Collected"
/scoreboard objectives setdisplay sidebar score

# (Extension) Create a separate objective for dangerous zones
/scoreboard objectives add damage dummy "Danger Hits"

# Set all players' starting score to 0
/scoreboard players set @a score 0
/scoreboard players set @a damage 0

# Confirm setup with a message visible to all players
/title @a title "World Ready!"
/title @a subtitle "Collect the coins!"
