# ============================================================
# Day 9 — Example 5: Challenge — Win Condition
# STEM Through Games | Minecraft Education Edition
# ============================================================
#
# WHAT THIS DEMONSTRATES:
#   The Day 9 challenge: a score-based win condition that
#   stops the Agent and celebrates when the player wins.
#   Includes all four extension challenges.
#
# HOW TO TEST:
#   Call add_score() with different values at the bottom.
#   Try reaching exactly 10, then try reaching 20.
# ============================================================

health = 100
score = 0


# ----------------------------------------------------------
# BASE CHALLENGE: Win when score reaches 10
# ----------------------------------------------------------

def add_score(points):
    global score

    score += points   # Add points to current score
                      # Math: score = score + points

    if score >= 10:
        player.say("You Win! Final score: " + str(score))
        agent.stop()   # Stop the Agent from moving — game over state
    else:
        player.say("Score: " + str(score) + " — keep going!")


# ----------------------------------------------------------
# EXTENSION 1: Two win tiers using elif
# ----------------------------------------------------------
# "Perfect Score" tier added for score >= 20

def add_score_tiered(points):
    global score

    score += points

    if score >= 20:
        player.say("PERFECT SCORE! Amazing — " + str(score) + " points!")
        agent.stop()
    elif score >= 10:
        player.say("You Win! Score: " + str(score))
        agent.stop()
    else:
        player.say("Score: " + str(score) + " — keep going!")


# ----------------------------------------------------------
# EXTENSION 2: Win only if BOTH score and health are good
# ----------------------------------------------------------
# Combining conditions with 'and' — player must be alive to win

def add_score_requires_health(points):
    global score

    score += points

    if score >= 10 and health > 0:
        player.say("You Win! Score: " + str(score) + ", Health: " + str(health))
        agent.stop()
    elif score >= 10 and health <= 0:
        player.say("Score reached 10, but you didn't survive. Game Over!")
    else:
        player.say("Score: " + str(score) + " — keep going!")


# ----------------------------------------------------------
# EXTENSION 3: "Close Call" message — win but barely alive
# ----------------------------------------------------------

def add_score_close_call(points):
    global score

    score += points

    if score >= 10 and health > 0 and health < 10:
        player.say("CLOSE CALL! You won with only " + str(health) + " health left!")
        agent.stop()
    elif score >= 10 and health > 0:
        player.say("You Win! Score: " + str(score))
        agent.stop()
    elif score >= 10:
        player.say("Score reached — but you didn't survive!")
    else:
        player.say("Score: " + str(score))


# ----------------------------------------------------------
# EXTENSION 4: Custom game states using a variable
# ----------------------------------------------------------
# Instead of just True/False, we track a named state string.
# This is the foundation of a real game state machine!

game_state = "PLAYING"   # Possible values: PLAYING, LEVEL_COMPLETE,
                          #                  PAUSED, BONUS_ROUND, GAME_OVER

def update_game_state(new_state):
    global game_state

    game_state = new_state

    if game_state == "PLAYING":
        player.say("Game running — play on!")
    elif game_state == "LEVEL_COMPLETE":
        player.say("Level Complete! Preparing next level...")
        agent.move(FORWARD, 5)   # Agent walks forward as celebration
    elif game_state == "PAUSED":
        player.say("Game Paused.")
        agent.stop()
    elif game_state == "BONUS_ROUND":
        player.say("BONUS ROUND! Double points active!")
    elif game_state == "GAME_OVER":
        player.say("Game Over. Better luck next time!")
        mobs.spawn(ZOMBIE, pos(0, 0, 0))
    else:
        player.say("Unknown state: " + game_state)


# ----------------------------------------------------------
# TEST IT — uncomment lines one at a time and re-run
# ----------------------------------------------------------

# --- Base challenge ---
add_score(5)
# add_score(5)   # Run twice to reach 10 and trigger win

# --- Tiered win ---
# add_score_tiered(15)    # triggers "You Win!"
# add_score_tiered(10)    # triggers "PERFECT SCORE!" (score becomes 25)

# --- Requires health ---
# add_score_requires_health(10)   # wins because health > 0

# --- Close call (set health = 5 at top first) ---
# add_score_close_call(10)

# --- Custom states ---
# update_game_state("LEVEL_COMPLETE")
# update_game_state("BONUS_ROUND")
# update_game_state("GAME_OVER")
