## =============================================================
## STEM Through Games — Day 4
## math_operators.gd  |  Attach to: Node
## =============================================================
## Math Connection section of the lesson.
## Each of the 5 GDScript operators (+  -  *  /  %)
## is shown with a real game mechanics example.
##
## RUN THIS FILE to see all operator examples in the Output panel.
## =============================================================

extends Node


func _ready() -> void:
	_demo_addition()
	_demo_subtraction()
	_demo_multiplication()
	_demo_division()
	_demo_modulo()
	_demo_combined_game_turn()


# ─────────────────────────────────────────────────────────────
# +  ADDITION
# Game uses: collecting coins, gaining XP, restoring health
# Math link: 6.EE.A.2 — evaluating numerical expressions
# ─────────────────────────────────────────────────────────────

func _demo_addition() -> void:
	print("─── + ADDITION ──────────────────────────────────")

	var score = 0
	print("score starts at: ", score)

	score = score + 10    # found a small coin
	print("+ picked up small coin (+10):  score = ", score)

	score = score + 50    # defeated an enemy
	print("+ defeated enemy (+50):        score = ", score)

	score = score + 100   # completed a level
	print("+ completed level (+100):      score = ", score)

	# Health restoration (addition)
	var health = 60
	var potion_heal = 40
	health = health + potion_heal
	print("+ used health potion (+", potion_heal, "): health = ", health)
	print("")


# ─────────────────────────────────────────────────────────────
# -  SUBTRACTION
# Game uses: taking damage, spending coins, using ammo
# ─────────────────────────────────────────────────────────────

func _demo_subtraction() -> void:
	print("─── - SUBTRACTION ───────────────────────────────")

	var health = 100
	print("health starts at: ", health)

	var enemy_damage = 25
	health = health - enemy_damage
	print("- hit by enemy (-", enemy_damage, "):       health = ", health)

	health = health - 10   # fell into a pit
	print("- fell in a pit (-10):         health = ", health)

	# Spending coins at a shop
	var coins = 80
	var item_cost = 30
	coins = coins - item_cost
	print("- bought item for ", item_cost, " coins:    coins = ", coins)
	print("")


# ─────────────────────────────────────────────────────────────
# *  MULTIPLICATION
# Game uses: power-ups, level scaling, area damage
# Math link: scaling — enemies multiply in difficulty each level
# ─────────────────────────────────────────────────────────────

func _demo_multiplication() -> void:
	print("─── * MULTIPLICATION ────────────────────────────")

	var base_damage = 10

	# Double damage power-up
	var double_damage = base_damage * 2
	print("* double damage power-up:      ", base_damage, " × 2 = ", double_damage)

	# Critical hit — 3× damage
	var crit_damage = base_damage * 3
	print("* critical hit (3×):           ", base_damage, " × 3 = ", crit_damage)

	# Enemies get faster each level — level scaling
	var base_speed = 4
	print("")
	print("  Enemy speed scaling per level:")
	for level in range(1, 6):           # levels 1 through 5
		var enemy_speed = base_speed * level
		print("  Level ", level, " enemy speed: ", base_speed, " × ", level, " = ", enemy_speed)

	print("")


# ─────────────────────────────────────────────────────────────
# /  DIVISION
# Game uses: splitting loot, calculating averages, half-damage
# Important: GDScript integer division drops the decimal!
# ─────────────────────────────────────────────────────────────

func _demo_division() -> void:
	print("─── / DIVISION ──────────────────────────────────")

	# Splitting treasure between players
	var treasure  = 100
	var players   = 4
	var each_share = treasure / players
	print("/ split 100 coins among 4:     each_share = ", each_share)

	# Half-damage (shield blocks 50%)
	var incoming_damage = 40
	var blocked_damage  = incoming_damage / 2
	print("/ shield blocks half damage:   ", incoming_damage, " / 2 = ", blocked_damage)

	# Integer division warning!
	print("")
	print("  ⚠  Integer division — decimals are dropped:")
	var odd_treasure = 10
	var three_players = 3
	var share = odd_treasure / three_players
	print("  10 / 3 = ", share, "  (the .33 is lost!)")
	print("  Leftover: 10 - (", share, " × 3) = ", odd_treasure - (share * three_players))

	# For decimals, use float variables
	var float_share: float = float(odd_treasure) / float(three_players)
	print("  Using floats: 10.0 / 3.0 = ", snappedf(float_share, 0.01))
	print("")


# ─────────────────────────────────────────────────────────────
# %  MODULO  (remainder after division)
# Game uses: bonus lives, cycling animations, even/odd checks
# Math link: this IS the remainder from long division!
# ─────────────────────────────────────────────────────────────

func _demo_modulo() -> void:
	print("─── % MODULO (remainder) ────────────────────────")

	# Extension challenge: what does print(10 % 3) output?
	print("10 %% 3 = ", 10 % 3, "   ← 10 = 3×3 + 1  (remainder is 1)")
	print("9  %% 3 = ", 9 % 3,  "   ← 9  = 3×3 + 0  (divides evenly)")
	print("")

	# Game use: award a bonus life every 100 points
	print("  Bonus life check (every 100 points):")
	for points in [50, 100, 150, 200, 250, 300]:
		var remainder = points % 100
		if remainder == 0:
			print("  score = ", points, "  →  BONUS LIFE!  (", points, " %% 100 = 0)")
		else:
			print("  score = ", points, "  →  not yet     (", points, " %% 100 = ", remainder, ")")

	print("")

	# Game use: alternate player turns
	print("  Alternating turns (Player 1 and Player 2):")
	for turn in range(1, 7):
		var current_player = (turn % 2) + 1
		print("  Turn ", turn, " → Player ", current_player)

	print("")

	# Game use: looping a 4-frame walk animation
	print("  Looping a 4-frame walk animation:")
	for tick in range(12):
		var frame = tick % 4    # frames 0, 1, 2, 3, 0, 1, 2, 3 ...
		print("  tick=", tick, "  frame=", frame)

	print("")


# ─────────────────────────────────────────────────────────────
# COMBINED — One full simulated game turn using all operators
# Shows how +  -  *  /  %  work together in a real scenario
# ─────────────────────────────────────────────────────────────

func _demo_combined_game_turn() -> void:
	print("─── COMBINED: Full Game Turn ────────────────────")
	print("  All 5 operators in one mini-game scenario")
	print("")

	var player_name  = "Alex"
	var health       = 100
	var score        = 0
	var gold         = 50
	var turn         = 0
	var enemy_damage = 12
	var player_damage = 18

	print("  ", player_name, " enters the dungeon!")
	print("  HP: ", health, "   Score: ", score, "   Gold: ", gold)
	print("")

	# Turn 1
	turn = turn + 1                       # +  addition
	score = score + 100                   # +  gained from exploring
	health = health - enemy_damage        # -  took damage
	var loot = 30
	gold = gold + loot                    # +  found treasure
	print("  Turn ", turn, ": explored room")
	print("  HP: ", health, "  Score: ", score, "  Gold: ", gold)

	# Turn 2 — boss fight
	turn = turn + 1
	var boss_bonus = player_damage * 2    # *  critical hit
	score = score + boss_bonus            # +  big points for boss
	health = health - (enemy_damage * 2)  # *  boss hits twice as hard
	print("")
	print("  Turn ", turn, ": BOSS FIGHT (critical hit!)")
	print("  Boss took ", boss_bonus, " damage  |  You took ", enemy_damage * 2)
	print("  HP: ", health, "  Score: ", score)

	# Divide treasure between all party members
	var party_gold = gold + 40
	var party_size = 3
	var each = party_gold / party_size     # /  split loot
	print("")
	print("  Total party gold: ", party_gold, " split 3 ways → each gets: ", each)

	# Check for bonus life milestone
	var milestone_check = score % 100      # %  modulo check
	print("")
	print("  Score milestone check: ", score, " %% 100 = ", milestone_check)
	if milestone_check == 0:
		print("  ★ BONUS LIFE EARNED!")
	else:
		print("  Need ", 100 - milestone_check, " more points for next bonus life")

	print("")
	print("═" .repeat(50))
