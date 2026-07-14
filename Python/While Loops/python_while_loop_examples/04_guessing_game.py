# ============================================================
#  04_guessing_game.py  —  Number Guessing Game
#  Middle School Python · Unit 4 · Lesson 4.2
# ============================================================
#
#  A complete mini-project using:
#    • while loop with a max-attempts limit
#    • break to exit when the player wins
#    • User input inside a loop
#    • Tracking score across multiple rounds
# ============================================================

import random

print("=" * 50)
print("  🎮  NUMBER GUESSING GAME  🎮")
print("=" * 50)

# ------------------------------------------------------------
# Helper function — play one round
# ------------------------------------------------------------
def play_round(max_guesses):
    """
    Plays one round of the guessing game.
    Returns True if the player won, False if they ran out of guesses.
    """
    secret = random.randint(1, 20)
    guesses_used = 0

    print(f"\nI'm thinking of a number between 1 and 20.")
    print(f"You have {max_guesses} guess(es).\n")

    while guesses_used < max_guesses:
        # Get a valid guess from the player
        try:
            guess = int(input("Your guess: "))
        except ValueError:
            print("Please enter a whole number!")
            continue         # skip the comparison and ask again

        guesses_used += 1
        guesses_left = max_guesses - guesses_used

        if guess == secret:
            print(f"🎉 Correct! You got it in {guesses_used} guess(es)!")
            return True      # player wins — exit the function
        elif guess < secret:
            hint = "Too low! ⬆️"
        else:
            hint = "Too high! ⬇️"

        if guesses_left > 0:
            print(f"  {hint}  ({guesses_left} guess(es) left)")
        else:
            print(f"  {hint}")

    # Ran out of guesses
    print(f"\n💀 Out of guesses! The number was {secret}.")
    return False

# ------------------------------------------------------------
# Choose difficulty
# ------------------------------------------------------------
print("\nChoose difficulty:")
print("  1. Easy   (10 guesses)")
print("  2. Medium ( 5 guesses)")
print("  3. Hard   ( 3 guesses)")

difficulty = ""
while difficulty not in ("1", "2", "3"):
    difficulty = input("Enter 1, 2, or 3: ")

max_guesses_map = {"1": 10, "2": 5, "3": 3}
MAX_GUESSES = max_guesses_map[difficulty]

# ------------------------------------------------------------
# Main game loop — keep playing rounds until the player quits
# ------------------------------------------------------------
wins = 0
losses = 0
rounds = 0

play_again = "y"
while play_again.lower() == "y":
    rounds += 1
    won = play_round(MAX_GUESSES)

    if won:
        wins += 1
    else:
        losses += 1

    print(f"\n  Scoreboard: {wins} win(s) / {losses} loss(es) in {rounds} round(s)")
    play_again = input("\nPlay again? (y/n): ")

# ------------------------------------------------------------
# Final summary
# ------------------------------------------------------------
print("\n" + "=" * 50)
print("  FINAL RESULTS")
print("=" * 50)
print(f"  Rounds played : {rounds}")
print(f"  Wins          : {wins}")
print(f"  Losses        : {losses}")

if rounds > 0:
    win_rate = (wins / rounds) * 100
    print(f"  Win rate      : {win_rate:.1f}%")

if wins == rounds:
    print("\n  Perfect score! You're a guessing legend! 🏆")
elif wins > losses:
    print("\n  Nice work — more wins than losses! 👍")
elif wins == losses:
    print("\n  Dead even! Play one more to break the tie.")
else:
    print("\n  Keep practicing — you'll get better! 💪")

print("\nThanks for playing!")
