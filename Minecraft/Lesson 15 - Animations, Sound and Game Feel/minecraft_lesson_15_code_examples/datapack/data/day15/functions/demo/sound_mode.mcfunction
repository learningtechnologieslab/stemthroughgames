# =============================================================
# Day 15: demo/sound_mode.mcfunction
#
# Re-enables all custom sounds for the "Version 2" comparison demo.
# Used during the Warm-Up Activity: Silent vs. Sound.
#
# Usage: /function day15:demo/sound_mode
# =============================================================

# Remove the silent tag so sound functions activate again
tag @a remove silent

# Restart background music
function day15:music/play

tellraw @a [{"text":"[Demo] ","color":"green","bold":true},{"text":"VERSION 2: Full Audio Mode\n","color":"white","bold":true}]
tellraw @a [{"text":"Custom sounds enabled. Walk, jump, and collect coins to hear the difference!\n","color":"gray"}]
tellraw @a [{"text":"Discussion: ","color":"yellow"},{"text":"What specifically felt different? List 3 things.","color":"white"}]
