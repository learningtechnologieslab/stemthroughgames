# ============================================================
# Day 9 — Quick Reference: Operators & Syntax
# STEM Through Games | Minecraft Education Edition
# ============================================================
# Keep this file open as a reference while you code!
# ============================================================


# ============================================================
# COMPARISON OPERATORS
# ============================================================
# Each one compares two values and returns True or False.

x = 10

print(x == 10)   # True  — equal to
print(x != 5)    # True  — not equal to
print(x < 20)    # True  — less than
print(x > 5)     # True  — greater than
print(x <= 10)   # True  — less than or equal to
print(x >= 10)   # True  — greater than or equal to


# ============================================================
# BOOLEAN LOGIC OPERATORS
# ============================================================

health = 75
score = 12
is_game_over = False

# and — BOTH must be True
print(health > 0 and score >= 10)    # True  (both are true)
print(health > 0 and score >= 20)    # False (score is not >= 20)

# or — EITHER can be True
print(health < 10 or score >= 10)    # True  (score condition saves it)
print(health < 10 or score >= 20)    # False (neither is true)

# not — flips the value
print(not is_game_over)   # True  (game is NOT over)
print(not True)           # False
print(not False)          # True


# ============================================================
# IF / ELIF / ELSE STRUCTURE
# ============================================================

# Template — fill in your own conditions and actions:
#
# if <first_condition>:
#     <action if True>
# elif <second_condition>:
#     <action if first was False but this is True>
# else:
#     <action when ALL above are False>


# Example — health check:
health = 45

if health <= 0:
    player.say("Game Over!")
elif health < 30:
    player.say("Warning: Low health!")
else:
    player.say("Health OK: " + str(health))


# ============================================================
# MINECRAFT EDUCATION BUILT-INS USED IN DAY 9
# ============================================================

# player.say(message)
#   Displays a message in the Minecraft chat.
#   Example: player.say("Hello, world!")

# agent.stop()
#   Stops the Agent from moving.
#   Example: agent.stop()

# agent.move(direction, blocks)
#   Moves the Agent a number of blocks in a direction.
#   Example: agent.move(FORWARD, 3)

# mobs.spawn(mob_type, position)
#   Spawns a mob at the given coordinates.
#   Example: mobs.spawn(ZOMBIE, pos(0, 0, 0))

# pos(x, y, z)
#   Creates a world position (coordinates).
#   Example: pos(0, 0, 0) is the world origin.


# ============================================================
# GLOBAL KEYWORD
# ============================================================
# When you want to CHANGE a variable that lives outside
# your function, you must declare it as global first.

score = 0

def add_points(n):
    global score      # ← without this, score won't update!
    score += n

add_points(5)
print(score)   # 5


# ============================================================
# COMMON MISTAKES TO AVOID
# ============================================================

# ❌ Using = instead of == in a condition
# if score = 10:       # WRONG — this is assignment, not comparison
#     player.say("ten")

# ✅ Correct comparison
# if score == 10:      # RIGHT — double equals for comparison
#     player.say("ten")

# ❌ Forgetting 'global' when modifying a variable in a function
# def bad_example():
#     health -= 10     # This will cause an error!

# ✅ Correct — declare global first
# def good_example():
#     global health
#     health -= 10

# ❌ Missing colon after if / elif / else
# if health <= 0      # WRONG — Python requires the colon
#     player.say("...")

# ✅ Correct
# if health <= 0:     # RIGHT
#     player.say("...")

# ❌ Inconsistent indentation (Python is strict about this!)
# if health <= 0:
# player.say("...")   # WRONG — must be indented

# ✅ Correct — 4 spaces of indentation
# if health <= 0:
#     player.say("...")  # RIGHT
