# ============================================================
# BUG 3 – COMMAND BLOCK SILENT FAIL  (FIXED VERSION)
# Minecraft Education Edition – Command Block content
# ============================================================
#
# THE FIXES:
#   1. "titl"       → "title"         (spelling)
#   2. "summom"     → "summon"        (spelling)
#   3. "diamond_swrod" → "diamond_sword"  (spelling)
#
# KEY CONCEPT:
#   Commands in Minecraft must match exactly — one wrong
#   character causes total silence. No partial execution.
#   Unlike GDScript/Python, Minecraft commands don't print
#   a helpful error: they just do nothing.
#
# COMMAND BLOCK SETUP CHECKLIST:
#   Mode:      IMPULSE (fires once when powered)
#              REPEAT  (fires every game tick while powered)
#              CHAIN   (fires after the previous block fires)
#   Condition: UNCONDITIONAL (always runs)
#              CONDITIONAL   (only runs if previous block succeeded)
#   Needs Redstone: ON  = only fires when powered
#                   OFF = runs always (Always Active)
#
# DEBUGGING STRATEGY USED:
#   Each command was tested manually in the chat bar with /
#   prefixed. Commands 1 and 4 threw errors immediately.
#   Command 2 also failed. Command 3 worked — proving the
#   block setup was fine and only the text was wrong.
# ============================================================


# --- COMMAND BLOCK 1: Announce the battle ---
# ✅ FIXED: "title" spelled correctly
title @a title {"rawtext":[{"text":"§c⚔ BOSS BATTLE BEGINS ⚔"}]}


# --- COMMAND BLOCK 2: Spawn the boss ---
# ✅ FIXED: "summon" spelled correctly
# Spawns zombie 2 blocks in front of player, 1 block up
summon zombie ~ ~1 ~2


# --- COMMAND BLOCK 3: Set difficulty ---
# ✅ This was already correct
difficulty hard


# --- COMMAND BLOCK 4: Give player a sword ---
# ✅ FIXED: "diamond_sword" spelled correctly
give @p diamond_sword 1


# ============================================================
# COMMAND BLOCK CHAINING EXAMPLE:
#
#   [Impulse Block] → [Chain Block] → [Chain Block] → ...
#         ↓                 ↓               ↓
#     title @a...      summon...       difficulty hard
#
#   Wire them left-to-right with redstone, or place them
#   facing the same direction and the chain connects automatically.
# ============================================================
