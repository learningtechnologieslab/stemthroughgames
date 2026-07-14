# =============================================================
# Day 15: demo/silent_mode.mcfunction
#
# Disables all custom sounds for the "Version 1" comparison demo.
# Used during the Warm-Up Activity: Silent vs. Sound.
#
# Usage: /function day15:demo/silent_mode
# =============================================================

# Stop background music
stopsound @a music

# Disable the datapack's sound functions by tagging players
# with a "silent" tag — the sound functions check for this tag.
tag @a add silent

tellraw @a [{"text":"[Demo] ","color":"red","bold":true},{"text":"VERSION 1: Silent Mode\n","color":"white","bold":true}]
tellraw @a [{"text":"All custom sounds disabled. This is what your world sounds like without audio design.\n","color":"gray"}]
tellraw @a [{"text":"Run ","color":"yellow"},{"text":"/function day15:demo/sound_mode","color":"aqua"},{"text":" to switch to Version 2.","color":"yellow"}]
