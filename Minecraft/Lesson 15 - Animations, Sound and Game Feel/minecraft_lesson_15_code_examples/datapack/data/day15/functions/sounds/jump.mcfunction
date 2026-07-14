# =============================================================
# Day 15: sounds/jump.mcfunction
#
# Plays a jump sound on the exact tick the player leaves the ground.
#
# CONCEPT: The tricky part is "edge detection" — we only want to
# play the sound ONCE when they first jump, not every tick they're
# in the air. We use a "was_jumping" flag to track this.
#
# STATE MACHINE LOGIC:
#   If player is airborne AND was_jumping = 0  → just jumped! Play sound, set flag to 1.
#   If player is airborne AND was_jumping = 1  → already in the air, do nothing.
#   If player is grounded AND was_jumping = 1  → just landed! (handled in land.mcfunction)
#   If player is grounded AND was_jumping = 0  → standing still, do nothing.
# =============================================================

# Detect: Player is in the air (OnGround tag is false = OnGround:0b in NBT)
# AND this is the first tick they're airborne (was_jumping = 0)
execute as @a[nbt={OnGround:0b}, scores={was_jumping=0}] at @s run playsound custom.jump player @s ~ ~ ~ 0.8 1.1

# Set the flag so we know they're currently in the air
execute as @a[nbt={OnGround:0b}] run scoreboard players set @s was_jumping 1

# Clear the flag when they land (back on the ground)
execute as @a[nbt={OnGround:1b}] run scoreboard players set @s was_jumping 0
