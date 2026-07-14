# ============================================================
# BUG 3 – COMMAND BLOCK SILENT FAIL  (BUGGY VERSION)
# Minecraft Education Edition – Command Block content
# ============================================================
#
# WHAT THIS IS SUPPOSED TO DO:
#   A "Boss Battle Start" sequence triggered by redstone:
#     1. Announce the boss battle in chat
#     2. Spawn a zombie named "BOSS" near the player
#     3. Set the game to hard difficulty
#     4. Give the player a sword
#
# WHAT ACTUALLY HAPPENS:
#   The Command Block is powered by redstone but does nothing.
#   No message, no zombie, no change. Total silence.
#
# SETUP IN MINECRAFT:
#   - Place a COMMAND BLOCK
#   - Set mode to: IMPULSE (fires once per power signal)
#   - Set condition to: UNCONDITIONAL
#   - Copy each command below into a separate command block
#     wired in sequence with redstone
#
# YOUR DEBUGGING CHALLENGE:
#   1. Set up the command blocks and power them with redstone
#   2. Nothing happens — start debugging
#   3. Try typing each command manually into the chat bar (/command)
#      Does it work there? If yes: the command is valid, the block
#      is the problem. If no: the command has a syntax error.
#   4. Check the Mode setting on the command block itself
# ============================================================


# --- COMMAND BLOCK 1: Announce the battle ---
# ❌ BUG: "titl" is misspelled — should be "title"
# The command silently fails because Minecraft doesn't recognize "titl"
titl @a title {"rawtext":[{"text":"§c⚔ BOSS BATTLE BEGINS ⚔"}]}


# --- COMMAND BLOCK 2: Spawn the boss ---
# ❌ BUG: "summom" is misspelled — should be "summon"
summom zombie ~ ~1 ~ {"minecraft:entity_tag":{"tags":["boss"]}}


# --- COMMAND BLOCK 3: Set difficulty ---
# ✅ This command is correct — use it to confirm that SOME
#    commands can work, which isolates the problem to commands 1 & 2
difficulty hard


# --- COMMAND BLOCK 4: Give player a sword ---
# ❌ BUG: item name "diamond_swrod" is misspelled — should be "diamond_sword"
give @p diamond_swrod 1


# ============================================================
# HOW TO SPOT COMMAND SYNTAX ERRORS:
#   1. Type the command in the chat bar (add / at the start)
#   2. Minecraft will show a red error if the syntax is wrong
#   3. Or: look for the command block's error indicator light
#      (it turns red on invalid commands in some versions)
# ============================================================
