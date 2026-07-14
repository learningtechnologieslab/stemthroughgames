# =============================================================
# Day 15: tick.mcfunction
# This runs EVERY TICK — 20 times per second.
# It's the "game loop" that checks player states and fires sounds.
#
# Think of this like _physics_process() in Godot, but for Minecraft.
# =============================================================

# Step 1: Run all our state checks
function day15:sounds/footstep
function day15:sounds/jump
function day15:sounds/land
function day15:sounds/collect

# Step 2: Tick down all cooldown timers
# Any score above 0 gets decremented by 1 each tick.
scoreboard players remove @a[scores={step_cooldown=1..}] step_cooldown 1

# Step 3: Reset the motion tracker for the next tick
# IMPORTANT: This must happen AFTER we check it, not before!
scoreboard players set @a motion 0
