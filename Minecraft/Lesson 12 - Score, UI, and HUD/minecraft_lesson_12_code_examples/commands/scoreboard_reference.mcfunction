# ============================================================
# STEM Through Games — Day 12: Score, UI & HUD
# FILE: commands/scoreboard_reference.mcfunction
#
# QUICK REFERENCE: All /scoreboard commands used in Day 12.
# Print this page as a student reference card.
# ============================================================

# ── CREATING OBJECTIVES ──────────────────────────────────────
# Format: /scoreboard objectives add <name> <type> <display_label>

/scoreboard objectives add score  dummy Score
/scoreboard objectives add health dummy Health
/scoreboard objectives add timer  dummy Timer

# ── DISPLAY MODES ────────────────────────────────────────────
# Show an objective on the right sidebar (one at a time):
/scoreboard objectives setdisplay sidebar score
/scoreboard objectives setdisplay sidebar health
/scoreboard objectives setdisplay sidebar timer

# Hide the sidebar:
/scoreboard objectives setdisplay sidebar

# Show below player names (visible in-world):
/scoreboard objectives setdisplay belowname score

# ── SETTING VALUES ───────────────────────────────────────────
# @p = nearest player    @a = all players    @s = yourself

# Set a specific value:
/scoreboard players set @p score 0
/scoreboard players set @p health 20
/scoreboard players set @p timer 60

# Add to current value:
/scoreboard players add @p score 10
/scoreboard players add @p score -5

# Remove from current value:
/scoreboard players remove @p health 5

# ── READING VALUES ───────────────────────────────────────────
# List all scores for a player:
/scoreboard players list @p

# Test if a player's score meets a condition (for command blocks):
# execute if score @p score matches 100.. run say "Score is 100 or more!"
# execute if score @p health matches ..0  run say "Player is dead!"

# ── REMOVING OBJECTIVES ──────────────────────────────────────
# Remove a single objective (also removes it from display):
/scoreboard objectives remove score

# Remove ALL objectives (use with caution!):
# /scoreboard objectives list  ← first check what exists

# ── PLAYER SELECTORS CHEAT SHEET ─────────────────────────────
# @p   Nearest player to where the command is run
# @a   ALL players in the world
# @s   The entity running the command (yourself in chat)
# @r   A RANDOM player
# @e   ALL entities (players + mobs)

# Target a specific player by name:
/scoreboard players set Steve score 100

# Target players within 10 blocks:
/scoreboard players set @a[r=10] score 0

# Target players with score >= 50:
# execute as @a[scores={score=50..}] run say "I have 50+ points!"

# ── COMMON ERRORS ────────────────────────────────────────────
# Error: "An objective already exists by that name"
#   → The objective was created before. Use /scoreboard objectives list
#     to see what exists, or /scoreboard objectives remove <name> first.
#
# Error: "No targets matched selector"
#   → @p found no player nearby, or @a has no players in the world.
#     Make sure you're in the world and close to where the command runs.
#
# Nothing appears on sidebar:
#   → Run /scoreboard objectives setdisplay sidebar <name>
#   → Run /scoreboard players set @p <name> 0 to register the player.
#      Players don't appear until they have at least one score entry.
