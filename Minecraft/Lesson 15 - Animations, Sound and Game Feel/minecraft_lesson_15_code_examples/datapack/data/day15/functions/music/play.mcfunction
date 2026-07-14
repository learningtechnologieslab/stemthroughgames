# =============================================================
# Day 15: music/play.mcfunction
#
# Starts background music for all players.
# Call this with: /function day15:music/play
#
# The "music" category makes it respect the player's music volume slider.
# "master" plays at full volume regardless of category settings.
# =============================================================

playsound custom.theme music @a ~ ~ ~ 0.4 1.0
scoreboard players set @a music_playing 1
tellraw @a [{"text":"♪ ","color":"green"},{"text":"Background music started.","color":"gray","italic":true}]
