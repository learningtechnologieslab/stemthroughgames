# ============================================================
# Day 9 — Example 6: Complete Game — All Concepts Together
# STEM Through Games | Minecraft Education Edition
# ============================================================
#
# WHAT THIS DEMONSTRATES:
#   Every Day 9 concept working together in one script:
#     ✓ Variables for game state
#     ✓ if / elif / else branches
#     ✓ Comparison operators (<=, <, >=, ==)
#     ✓ Boolean logic (and, or, not)
#     ✓ Multiple game states
#     ✓ player.say() feedback
#     ✓ agent.stop() and mobs.spawn() for game events
#
# This is what a real (simple) Minecraft Education game
# script looks like when all the pieces fit together.
# ============================================================


# ============================================================
# SECTION 1 — Game State Variables
# ============================================================
# All game data lives here. Conditionals read these values
# and decide what to do.

health = 100
score = 0
has_key = False
game_state = "PLAYING"   # PLAYING | LOW_HEALTH | GAME_OVER | WIN | BONUS_ROUND


# ============================================================
# SECTION 2 — Helper: Update Game State
# ============================================================
# Centralizing state changes makes the code easier to follow.

def set_state(new_state):
    global game_state
    game_state = new_state
    player.say(">>> State changed to: " + game_state)


# ============================================================
# SECTION 3 — Take Damage
# ============================================================

def take_damage(amount):
    global health

    if game_state == "GAME_OVER" or game_state == "WIN":
        player.say("Game already ended — ignoring damage.")
        return   # Stop the function early

    health -= amount

    if health <= 0:
        health = 0   # Clamp so we don't go negative
        set_state("GAME_OVER")
        player.say("Game Over! You took too much damage.")
        mobs.spawn(ZOMBIE, pos(0, 0, 0))

    elif health < 30:
        set_state("LOW_HEALTH")
        player.say("WARNING: Low health! Only " + str(health) + " HP left.")

    else:
        player.say("Took " + str(amount) + " damage. Health: " + str(health))


# ============================================================
# SECTION 4 — Collect Item (gives score and optionally a key)
# ============================================================

def collect_item(item_type):
    global score, has_key

    if game_state == "GAME_OVER":
        player.say("Can't collect — game is over.")
        return

    if item_type == "diamond":
        score += 3
        player.say("Diamond collected! +" + str(3) + " points. Score: " + str(score))

    elif item_type == "emerald":
        score += 5
        player.say("Emerald collected! +" + str(5) + " points. Score: " + str(score))

    elif item_type == "key":
        has_key = True
        player.say("Key collected! You can now unlock the door.")

    else:
        score += 1
        player.say("Item collected. Score: " + str(score))

    # Check win condition after every collection
    check_win()


# ============================================================
# SECTION 5 — Win Condition Check
# ============================================================

def check_win():
    global game_state

    # Player must have enough score AND be alive to win
    if score >= 10 and health > 0 and not game_state == "GAME_OVER":

        # Close call: won but barely survived
        if health < 10:
            player.say("CLOSE CALL WIN! Score: " + str(score) + " | Health: " + str(health))
        # Perfect run: won with full health
        elif health == 100:
            player.say("PERFECT WIN! Full health, score " + str(score) + "!")
        # Normal win
        else:
            player.say("YOU WIN! Score: " + str(score) + " | Health: " + str(health))

        set_state("WIN")
        agent.stop()


# ============================================================
# SECTION 6 — Try to Open a Locked Door
# ============================================================

def try_open_door():
    if has_key and health > 0:
        player.say("Door unlocked! Both conditions met: alive AND has key.")
        set_state("BONUS_ROUND")
        player.say("BONUS ROUND unlocked — double points!")
    elif not has_key:
        player.say("Door locked. You need a key first.")
    elif health <= 0:
        player.say("You can't open the door — you're defeated!")
    else:
        player.say("Something unexpected happened.")


# ============================================================
# SECTION 7 — Status Report
# ============================================================
# Prints a full summary of all game state variables.

def status():
    player.say("=== STATUS ===")
    player.say("State:   " + game_state)
    player.say("Health:  " + str(health))
    player.say("Score:   " + str(score))
    player.say("Has Key: " + str(has_key))


# ============================================================
# SECTION 8 — Run a Sample Game Sequence
# ============================================================
# Uncomment blocks one at a time to play through scenarios.

# --- Scenario A: Normal win ---
status()
collect_item("diamond")    # score → 3
collect_item("emerald")    # score → 8
take_damage(20)            # health → 80
collect_item("diamond")    # score → 11 → WIN!
status()

# --- Scenario B: Game Over before winning ---
# status()
# take_damage(40)   # health → 60
# take_damage(40)   # health → 20 → LOW HEALTH
# take_damage(30)   # health → 0  → GAME OVER
# collect_item("diamond")   # blocked: game is over
# status()

# --- Scenario C: Use a key to unlock bonus round ---
# collect_item("key")
# try_open_door()
# status()

# --- Scenario D: Close call win (set health = 5 first) ---
# health = 5
# collect_item("emerald")
# collect_item("emerald")
# status()
