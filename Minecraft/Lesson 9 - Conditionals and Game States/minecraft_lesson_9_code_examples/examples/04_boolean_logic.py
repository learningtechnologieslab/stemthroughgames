# ============================================================
# Day 9 — Example 4: Boolean Logic (and, or, not)
# STEM Through Games | Minecraft Education Edition
# ============================================================
#
# WHAT THIS DEMONSTRATES:
#   How to COMBINE multiple conditions in a single check
#   using Python's Boolean logic operators: and, or, not.
#
# THE THREE OPERATORS:
#   and   — BOTH conditions must be True
#   or    — EITHER condition can be True (or both)
#   not   — FLIPS a True to False, or False to True
# ============================================================

health = 75
score = 12
has_key = True
is_jumping = False
is_crouching = True
is_game_over = False


# ----------------------------------------------------------
# AND — both conditions must be True to enter the block
# ----------------------------------------------------------
# Real-world equivalent: "You can enter the vault IF
# you are alive AND you have the key."

if health > 0 and has_key:
    player.say("You're alive and have the key — door unlocked!")
else:
    player.say("Can't open the door. Check health and key.")

# Another AND example: win only if BOTH conditions are met
if score >= 10 and health > 0:
    player.say("You Win! Score: " + str(score) + ", Health: " + str(health))
else:
    player.say("Not a win yet — need score >= 10 AND health > 0.")


# ----------------------------------------------------------
# OR — either condition being True is enough
# ----------------------------------------------------------
# Real-world equivalent: "Play the crouch animation IF
# the player is jumping OR crouching."

if is_jumping or is_crouching:
    player.say("Playing movement animation.")
else:
    player.say("Player is standing still.")

# Another OR example: trigger danger music in either bad state
low_health = health < 30
low_time = False   # pretend there's a timer running out

if low_health or low_time:
    player.say("Danger! Playing urgent music.")
else:
    player.say("Conditions normal.")


# ----------------------------------------------------------
# NOT — inverts a Boolean (True → False, False → True)
# ----------------------------------------------------------
# Real-world equivalent: "Only process input IF the game
# is NOT over."

if not is_game_over:
    player.say("Game running — processing player input.")
else:
    player.say("Game is over — ignoring input.")


# ----------------------------------------------------------
# COMBINING all three in one condition
# ----------------------------------------------------------
# "Player wins a bonus ONLY IF score is high, they're alive,
# and the game is NOT over."

if score >= 10 and health > 0 and not is_game_over:
    player.say("BONUS ACHIEVED! All three conditions met.")
else:
    player.say("No bonus this time.")


# ============================================================
# CLASS DISCUSSION CHALLENGE:
#
# How would you write: "Player wins ONLY IF score >= 10
# AND health > 0"?
#
# Answer:
#   if score >= 10 and health > 0:
#       player.say("You Win!")
#
# Try changing health to 0 above and re-running.
# Does the win condition still trigger? Why not?
# ============================================================
