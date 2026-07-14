# =============================================================
# Day 15: sounds/land.mcfunction
#
# Plays a landing "thud" sound when the player hits the ground
# after being in the air.
#
# This is the companion to jump.mcfunction.
# We detect the transition: was_jumping=1 → now OnGround:1b
#
# DISCUSSION QUESTION FOR CLASS:
#   Why does adding a land sound make movement feel more "complete"?
#   What is different about a game with jump sound only vs. jump + land?
# =============================================================

# Detect: Player just landed (on ground NOW, but was_jumping flag is still 1)
execute as @a[nbt={OnGround:1b}, scores={was_jumping=1}] at @s run playsound custom.land player @s ~ ~ ~ 0.7 0.95

# The was_jumping flag is cleared in jump.mcfunction on the same tick.
# Order matters — tick.mcfunction calls jump.mcfunction first, which handles the flag reset.
