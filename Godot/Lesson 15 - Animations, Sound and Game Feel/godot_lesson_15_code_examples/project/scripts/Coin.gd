## Coin.gd
## ============================================================
## STEM Through Games – Day 15: Animations, Sound & Game Feel
## ============================================================
##
## A collectible coin that:
##   1. Plays a spin animation in a loop
##   2. Plays a collect sound when the player touches it
##   3. Disappears after being collected
##
## HOW TO USE:
##   Attach this script to an Area2D node that has:
##     - AnimatedSprite2D  (child, with "spin" and "collect" animations)
##     - CoinSound         (AudioStreamPlayer child)
##     - CollisionShape2D  (child, circle or capsule shape)
##
## Then connect the Area2D's "body_entered" signal to _on_body_entered()
##
## ============================================================

extends Area2D

# ── SIGNALS ───────────────────────────────────────────────────
## Emitted when the player collects this coin.
## The main scene (or a ScoreManager) can listen to this.
signal collected

# ── STATE ─────────────────────────────────────────────────────
var is_collected: bool = false


# ════════════════════════════════════════════════════════════
# _ready()
# ════════════════════════════════════════════════════════════
func _ready() -> void:
	$AnimatedSprite2D.play("spin")
	# Connect the signal programmatically (alternative to the editor)
	body_entered.connect(_on_body_entered)


# ════════════════════════════════════════════════════════════
# _on_body_entered() – Fires when any PhysicsBody enters this area
# ════════════════════════════════════════════════════════════
func _on_body_entered(body: Node2D) -> void:
	# Only react to the Player, and only if not already collected
	if is_collected:
		return
	if not body.is_in_group("player"):
		return

	is_collected = true
	_do_collect()


# ════════════════════════════════════════════════════════════
# _do_collect() – Runs the collection sequence
## Design Note: We can't call queue_free() immediately because
## the sound needs time to finish playing. Instead we:
##   1. Disable the collision so it can't be collected twice
##   2. Play the collect animation
##   3. Play the sound
##   4. Wait for the sound to finish, then remove the node
# ════════════════════════════════════════════════════════════
func _do_collect() -> void:
	# Disable collision so this coin can't be triggered again
	$CollisionShape2D.set_deferred("disabled", true)

	# Emit signal so score systems can respond
	collected.emit()

	# Switch to collect animation (a quick flash/burst)
	$AnimatedSprite2D.play("collect")

	# 🔊 Play the coin sound
	$CoinSound.play()

	# Wait for the sound to finish, THEN remove the coin
	await $CoinSound.finished
	queue_free()


# ════════════════════════════════════════════════════════════
# ── 🎨 DESIGN CHALLENGE ──────────────────────────────────────
# ════════════════════════════════════════════════════════════
#
# The coin spins at a certain FPS. Try these experiments:
#
#   1. Increase the spin animation FPS from 8 to 16.
#      How does it change the coin's visual "energy"?
#
#   2. Add a small vertical bob using a Tween node:
#      var tween = create_tween().set_loops()
#      tween.tween_property(self, "position:y", position.y - 6, 0.5)
#      tween.tween_property(self, "position:y", position.y,     0.5)
#
#   3. Change the CoinSound pitch_scale (0.5 = deep, 2.0 = high).
#      How does pitch affect how "valuable" the coin feels?
#
# ════════════════════════════════════════════════════════════
