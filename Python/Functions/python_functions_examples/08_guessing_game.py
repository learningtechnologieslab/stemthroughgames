# ============================================================
#  08_guessing_game.py  —  Number Guessing Game with Functions
#  Middle School Python · Unit 6 · Lesson 6.1
# ============================================================
#
#  A complete mini-project that uses functions for EVERY task.
#  This demonstrates:
#    • Breaking a program into named, reusable pieces
#    • Parameters controlling behavior
#    • Return values carrying information back
#    • Function composition (functions calling functions)
#    • The DRY principle throughout
#
#  Run this file and follow the prompts!
# ============================================================

import random

# ════════════════════════════════════════════════════════
# HELPER FUNCTIONS  (small, single-purpose)
# ════════════════════════════════════════════════════════

def print_banner(text, width=50, char="="):
    """Print a centered banner line."""
    print(char * width)
    print(f"  {text}")
    print(char * width)


def get_int_input(prompt, min_val=None, max_val=None):
    """
    Prompt the user for an integer; keep asking until valid.

    Parameters
    ----------
    prompt  : str — what to ask the user
    min_val : int — minimum acceptable value (or None)
    max_val : int — maximum acceptable value (or None)
    """
    while True:
        try:
            value = int(input(prompt))
            if min_val is not None and value < min_val:
                print(f"  Please enter a number >= {min_val}.")
                continue
            if max_val is not None and value > max_val:
                print(f"  Please enter a number <= {max_val}.")
                continue
            return value
        except ValueError:
            print("  That's not a whole number. Try again.")


def generate_secret(low=1, high=20):
    """Return a random integer between low and high (inclusive)."""
    return random.randint(low, high)


def give_hint(guess, secret):
    """
    Return a hint string based on how close the guess is.

    Returns "correct", "too high", or "too low".
    """
    if guess == secret:
        return "correct"
    elif guess > secret:
        return "too high"
    else:
        return "too low"


def format_hint(hint, guesses_left):
    """Return a formatted hint message with emoji."""
    if hint == "correct":
        return "🎉 Correct!"
    elif hint == "too high":
        emoji = "⬇️ " if guesses_left > 1 else "⬇️ "
        return f"{emoji} Too high!  ({guesses_left} guess(es) left)"
    else:
        return f"⬆️  Too low!  ({guesses_left} guess(es) left)"


def choose_difficulty():
    """
    Ask the player to choose a difficulty level.
    Returns the number of allowed guesses.
    """
    print("\nChoose difficulty:")
    print("  1. Easy   — 10 guesses")
    print("  2. Medium —  5 guesses")
    print("  3. Hard   —  3 guesses")

    choice = get_int_input("Enter 1, 2, or 3: ", min_val=1, max_val=3)

    difficulty_map = {1: 10, 2: 5, 3: 3}
    return difficulty_map[choice]


def rate_performance(guesses_used, max_guesses):
    """
    Return a performance rating string based on efficiency.
    """
    ratio = guesses_used / max_guesses
    if guesses_used == 1:
        return "🏆 LEGENDARY — first try!"
    elif ratio <= 0.33:
        return "⭐⭐⭐ Excellent!"
    elif ratio <= 0.66:
        return "⭐⭐ Good job!"
    else:
        return "⭐ Keep practicing!"


# ════════════════════════════════════════════════════════
# GAME FUNCTIONS  (medium-level logic)
# ════════════════════════════════════════════════════════

def play_round(max_guesses, low=1, high=20):
    """
    Play one round of the guessing game.

    Returns True if the player won, False if they ran out.
    Uses: generate_secret, get_int_input, give_hint, format_hint.
    """
    secret = generate_secret(low, high)
    guesses_used = 0
    won = False

    print(f"\n  I'm thinking of a number between {low} and {high}.")
    print(f"  You have {max_guesses} guess(es).\n")

    while guesses_used < max_guesses:
        guess = get_int_input(f"  Guess: ", min_val=low, max_val=high)
        guesses_used += 1
        guesses_left = max_guesses - guesses_used

        hint = give_hint(guess, secret)                      # get hint
        message = format_hint(hint, guesses_left)            # format it
        print(f"  {message}")

        if hint == "correct":
            rating = rate_performance(guesses_used, max_guesses)
            print(f"  You got it in {guesses_used} guess(es)!  {rating}")
            won = True
            break

    if not won:
        print(f"\n  💀 Out of guesses! The number was {secret}.")

    return won


def play_game():
    """
    Run the full game loop: title → difficulty → rounds → score.
    This is the TOP-LEVEL function — it calls everything else.
    """
    print_banner("🎮  NUMBER GUESSING GAME  🎮")

    max_guesses = choose_difficulty()

    wins = 0
    losses = 0
    rounds = 0

    play_again = "y"
    while play_again.lower() == "y":
        rounds += 1
        print(f"\n  ─── Round {rounds} ───")

        if play_round(max_guesses):
            wins += 1
        else:
            losses += 1

        print(f"\n  Scoreboard: {wins}W / {losses}L  ({rounds} round(s))")
        play_again = input("\n  Play again? (y/n): ").strip()

    # Final summary
    print_banner("FINAL RESULTS", char="─")
    print(f"  Rounds played : {rounds}")
    print(f"  Wins          : {wins}")
    print(f"  Losses        : {losses}")

    if rounds > 0:
        pct = (wins / rounds) * 100
        print(f"  Win rate      : {pct:.1f}%")

    if wins == rounds:
        print("\n  🏆 Perfect score! Undefeated!")
    elif wins > losses:
        print("\n  👍 More wins than losses — solid!")
    elif wins == losses:
        print("\n  ⚖️  Dead even — play one more to break the tie!")
    else:
        print("\n  💪 Keep practicing — you'll improve!")

    print("\nThanks for playing!\n")


# ════════════════════════════════════════════════════════
# FUNCTION MAP  (printed before the game starts)
# ════════════════════════════════════════════════════════
print("""
  HOW THIS PROGRAM IS STRUCTURED:

  play_game()                ← you only need to call THIS
      ├── print_banner()
      ├── choose_difficulty()
      │       └── get_int_input()
      └── play_round()
              ├── generate_secret()
              ├── get_int_input()
              ├── give_hint()
              ├── format_hint()
              └── rate_performance()

  Every task has its own function. No copy-paste anywhere.
""")

# ════════════════════════════════════════════════════════
# RUN THE GAME
# ════════════════════════════════════════════════════════
play_game()
