# ============================================================
# Day 9 — Example 2: Health System with if / elif / else
# STEM Through Games | Minecraft Education Edition
# ============================================================
#
# WHAT THIS DEMONSTRATES:
#   A complete health tracking system using three-branch
#   conditionals: if, elif, and else. This is the main
#   coding activity for Day 9.
#
# KEY CONCEPTS:
#   - Variables to store game state (health, score)
#   - if / elif / else to branch based on conditions
#   - Comparison operators: <=, <
#   - player.say() to give feedback in-world
#   - mobs.spawn() as a visual "Game Over" signal
#
# HOW TO RUN:
#   1. Press C to open Code Builder → select Python
#   2. Paste this code and click Run
#   3. Change the take_damage() call at the bottom to test
#      different amounts (e.g. 50, 80, 100)
# ============================================================

# ----------------------------------------------------------
# STEP 1 — Set up player state variables
# ----------------------------------------------------------
# These variables TRACK the current state of the game.
# Conditionals will CHECK these values and REACT to them.

health = 100   # Player starts with full health
score = 0      # Player starts with no score


# ----------------------------------------------------------
# STEP 2 — Define the take_damage function
# ----------------------------------------------------------
# This function is called every time the player takes damage.
# The 'amount' parameter tells us how much damage was dealt.

def take_damage(amount):
    global health   # 'global' lets us modify the variable above

    health -= amount   # Subtract the damage from current health
                       # Math connection: health = health - amount

    # BRANCH 1: Is the player dead?
    if health <= 0:
        player.say("Game Over! Health reached zero.")
        mobs.spawn(ZOMBIE, pos(0, 0, 0))   # Spawn a Zombie as a visual signal

    # BRANCH 2: Is the player in danger? (only runs if BRANCH 1 was False)
    elif health < 30:
        player.say("Warning: Low health! Only " + str(health) + " remaining.")

    # BRANCH 3: Normal gameplay (runs when ALL above conditions are False)
    else:
        player.say("Health remaining: " + str(health))


# ----------------------------------------------------------
# STEP 3 — Test the function
# ----------------------------------------------------------
# Uncomment ONE line at a time to test different damage amounts.
# Watch how the output changes depending on health value.

take_damage(50)    # Health → 50 → "Health remaining: 50"
# take_damage(80)  # Health → 20 → "Warning: Low health!"
# take_damage(100) # Health →  0 → "Game Over!" + Zombie spawns


# ----------------------------------------------------------
# HOW THE BRANCHES WORK (code walk-through)
# ----------------------------------------------------------
#
#   health -= amount   Subtract damage. Links to math: subtraction.
#
#   if health <= 0:    First check: is player dead?
#                      <= means "less than OR equal to"
#                      Returns True or False (Boolean value)
#
#   elif health < 30:  Only runs if the if-check above was False.
#                      < means "strictly less than"
#
#   else:              Catch-all — runs when ALL above are False.
#                      Normal gameplay continues.
#
#   mobs.spawn(...)    Minecraft built-in: spawns a mob at coordinates.
#                      We use this as our visual "Game Over" state.
# ============================================================
