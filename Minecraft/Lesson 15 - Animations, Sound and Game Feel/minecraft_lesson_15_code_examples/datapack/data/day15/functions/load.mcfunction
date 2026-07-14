# =============================================================
# Day 15: load.mcfunction
# Runs ONCE when the datapack is loaded or /reload is called.
# Sets up all the scoreboards we need to track player states.
# =============================================================

# -- MOTION TRACKING --
# Counts how many centimeters the player has walked since last tick.
# Minecraft tracks this automatically — we just read it.
scoreboard objectives add motion minecraft.custom:walk_one_cm

# -- JUMP STATE --
# We set this to 1 when the player is in the air, 0 when grounded.
# This lets us detect the exact tick they first leave the ground.
scoreboard objectives add was_jumping dummy "Jump State"

# -- SNEAK STATE --
# Tracks whether the player was sneaking last tick (for the extension challenge).
scoreboard objectives add was_sneaking dummy "Sneak State"

# -- SOUND COOLDOWN --
# Prevents footstep sounds from playing too frequently.
# Without this, you'd hear a sound every single tick (20x per second)!
scoreboard objectives add step_cooldown dummy "Step Cooldown"

# -- MUSIC STATE --
# Tracks whether background music is currently playing.
# 0 = not playing, 1 = playing
scoreboard objectives add music_playing dummy "Music Playing"

# -- Notify that setup is complete --
tellraw @a [{"text":"[Day 15] ","color":"green"},{"text":"Scoreboards loaded! Sound system ready.","color":"white"}]
