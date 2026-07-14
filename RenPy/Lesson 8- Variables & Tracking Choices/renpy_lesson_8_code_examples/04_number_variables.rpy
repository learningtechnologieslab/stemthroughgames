## ============================================================
##  DAY 8 — EXAMPLE 4: Number Variables & Counters
##  STEM Through Games · Ren'Py Programming
## ============================================================
##
##  CONCEPT:  Integer variables — storing counts, scores, and
##            amounts that go up and down during the story.
##
##  NEW SKILLS:
##    •  default gold = 0          declare a number variable
##    •  $ gold += 10              add to a number
##    •  $ gold -= 5               subtract from a number
##    •  if gold >= 50:            compare with >= (greater than or equal)
##    •  if attempts > 2:          compare with >  (strictly greater than)
##    •  Showing numbers in dialogue with [square brackets]
##
##  This example follows a merchant encounter: the player can earn
##  gold through choices and spend it to unlock a shortcut.
##
## ============================================================

# ── CHARACTER DEFINITIONS ─────────────────────────────────────
define e  = Character("Explorer", color="#5EC8E5")
define m  = Character("Merchant", color="#E5C85E")
define g  = Character("Guard",    color="#E5A85E")
define v  = Character("Voice",    kind=nvl)


# ── VARIABLE DECLARATIONS ─────────────────────────────────────
default gold     = 0    # How many gold coins the player carries
default attempts = 0    # How many times the player has tried the gate
default has_key  = False


# ── MAIN STORY ────────────────────────────────────────────────
label start:

    scene bg bg_town with fade

    e "I arrive in a dusty market town."
    e "My coin purse is empty — I have [gold] gold."

    # ── EARN GOLD: TASK 1 ─────────────────────────────────────
    v "A merchant is struggling to carry heavy crates."

    menu:
        "Help carry the crates.":
            $ gold += 20                  # += adds 20 to whatever gold is now
            m "Bless you! Here — take this for your trouble."
            e "I earned 20 gold. I now have [gold] gold."

        "Walk past without stopping.":
            e "I don't have time to stop."
            e "Still at [gold] gold."

    # ── EARN GOLD: TASK 2 ─────────────────────────────────────
    v "A notice board offers a small reward for news from the road."

    menu:
        "Share what you know for a fee.":
            $ gold += 15
            e "The town clerk pays me. I now have [gold] gold."

        "Share it for free — be generous.":
            e "I share the news freely. Still [gold] gold, but it felt right."

    # ── SPEND GOLD: MERCHANT ──────────────────────────────────
    v "The same merchant is now selling items."

    e "I check my purse. I have [gold] gold."

    menu:
        "Buy the iron key (costs 30 gold).":

            # Only process the purchase if the player can afford it
            if gold >= 30:
                $ gold -= 30              # -= subtracts 30
                $ has_key = True
                m "Pleasure doing business! One iron key."
                e "Spent 30 gold. I now have [gold] gold and a key."
            else:
                # Player chose to buy but can't afford it
                m "I'm sorry — that costs 30 gold. You only have [gold]."
                e "I'll have to find another way."

        "Save your gold.":
            e "I keep my coins. Still [gold] gold."

    jump castle_gate


# ── CASTLE GATE — with attempt counter ───────────────────────
label castle_gate:

    scene bg bg_castle_gate with fade

    $ attempts += 1          # Count how many times we reach this label

    # The guard's greeting changes after repeated visits
    if attempts == 1:
        g "Halt! State your business."
    elif attempts == 2:
        g "You again? I already told you — no key, no entry."
    else:
        g "I'm starting to recognise your face. The answer is still no."

    # ── THE GATE CHECK ────────────────────────────────────────
    #
    #   Three conditions, checked in order:
    #     1. Has the iron key?    → best outcome
    #     2. Has 50+ gold?        → can bribe the guard
    #     3. Neither?             → turned away

    if has_key:
        g "Is that... the master key? Well. You may pass."
        jump inside_castle

    elif gold >= 50:
        # Player didn't buy the key but saved enough gold to bribe
        g "No key... but you look like someone with gold to spare."
        g "Fifty gold and I'll look the other way."

        menu:
            "Pay the bribe — 50 gold.":
                $ gold -= 50
                g "Wise choice. In you go."
                e "I hand over the coins. Down to [gold] gold."
                jump inside_castle

            "Refuse to pay.":
                g "Then turn around."
                e "I'm not giving this guard my savings."
                jump try_again

        # Note: the jump inside "elif" means we only reach
        # "turned_away" through the else branch or try_again.

    else:
        g "Nothing to offer? Come back when you have something."
        jump turned_away


# ── TRY AGAIN LOOP ────────────────────────────────────────────
label try_again:

    scene bg bg_town with fade

    e "I head back to town to think."

    # After 3 failed attempts, the player gets a special hint
    if attempts >= 3:
        v "A child tugs at your sleeve."
        v "\"The key to the castle was lost in the old forest.\""
        v "\"People say it glints like gold in the morning light.\""
        e "So there IS a key out there. I'd better search more carefully."

    menu:
        "Search the forest path again.":
            $ has_key = True
            e "After a long search, I spot something half-buried in the roots."
            e "The iron key! I've got it now."
            jump castle_gate

        "Return to the gate and try reasoning.":
            jump castle_gate

        "Give up and explore elsewhere.":
            jump alternate_ending


# ── ENDINGS ───────────────────────────────────────────────────
label inside_castle:

    scene bg bg_inside_castle with fade

    e "I'm inside at last. It took [attempts] attempt(s) to get here."

    if gold > 0:
        e "And I still have [gold] gold in my pocket. Not bad."
    else:
        e "My purse is completely empty. Worth it."

    e "The adventure continues..."
    return


label turned_away:
    e "The gate stays shut. I need a different plan."
    jump try_again


label alternate_ending:
    scene bg bg_forest with fade
    e "Sometimes the destination matters less than the journey."
    e "I head off into the forest — who knows what I'll find."
    return


## ============================================================
##  TEACHER NOTES
## ============================================================
##
##  ARITHMETIC OPERATORS used in this file:
##    +=    add to a variable          $ gold += 20
##    -=    subtract from a variable   $ gold -= 30
##    =     set to an exact value      $ gold = 0
##
##  COMPARISON OPERATORS used in conditions:
##    ==    equal to                   if attempts == 1:
##    >=    greater than or equal      if gold >= 50:
##    >     strictly greater than      if attempts > 2:
##    <=    less than or equal         if gold <= 0:
##    !=    not equal to               if mood != "happy":
##
##  DISCUSSION QUESTIONS:
##    1. What is the maximum amount of gold the player can earn
##       if they make every "earn" choice? (Answer: 20 + 15 = 35)
##    2. Can the player afford to buy the key AND have 50 gold
##       to bribe the guard? (Answer: No — max is 35 gold)
##    3. What happens if "attempts" reaches 100?
##       Is there any way that could happen in this script?
##    4. What would you change to make the bribe cost only 20 gold?
##       (Find the one number and change it — that's the power
##       of using a variable instead of typing "50" everywhere!)
##
## ============================================================
