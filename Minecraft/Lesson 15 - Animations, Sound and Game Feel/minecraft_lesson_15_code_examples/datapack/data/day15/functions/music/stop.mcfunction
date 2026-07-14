# =============================================================
# Day 15: music/stop.mcfunction
#
# Stops background music for all players.
# Call this with: /function day15:music/stop
#
# Used during the "Silent vs. Sound" comparison activity.
# =============================================================

stopsound @a music custom.theme
scoreboard players set @a music_playing 0
tellraw @a [{"text":"♪ ","color":"gray"},{"text":"Background music stopped.","color":"gray","italic":true}]
