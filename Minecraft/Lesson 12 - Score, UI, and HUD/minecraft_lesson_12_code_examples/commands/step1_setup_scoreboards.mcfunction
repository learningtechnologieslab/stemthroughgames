# ============================================================
# STEM Through Games — Day 12: Score, UI & HUD
# FILE: step1_setup_scoreboards.mcfunction
#
# PURPOSE: Create the three scoreboard objectives that form
#          the player's HUD. Run these commands ONE TIME when
#          you first set up your world.
#
# HOW TO USE:
#   Press T to open chat, then type each command below.
#   Or paste this file into a command block set to "repeat".
#
# CONCEPTS COVERED:
#   • Scoreboard objectives
#   • dummy score type
#   • sidebar display
# ============================================================

# --- Create the SCORE objective ---
# "score"   = internal name used by code
# "dummy"   = we update it manually (not from game events)
# "Score"   = display label shown on the sidebar
/scoreboard objectives add score dummy Score

# --- Create the HEALTH objective ---
/scoreboard objectives add health dummy Health

# --- Create the TIMER objective ---
/scoreboard objectives add timer dummy Timer

# --- Show the SCORE on the right side of the screen ---
# Only ONE objective can be displayed in the sidebar at a time.
# Change "score" to "health" or "timer" to display those instead.
/scoreboard objectives setdisplay sidebar score

# --- (Optional) Initialize all values to 0 for the nearest player ---
# Run this after a player joins to avoid blank sidebar entries.
/scoreboard players set @p score 0
/scoreboard players set @p health 20
/scoreboard players set @p timer 60
