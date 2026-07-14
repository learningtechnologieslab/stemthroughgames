## ScoreTargetFixed.gd — identical to buggy version
## The target itself was never broken. Signal emission was correct.
## The fix was in the parent scene connecting to this signal.

extends Area2D

signal score_changed(new_score)

var hit_count = 0

func _ready():
	body_entered.connect(_on_body_entered)
	print("ScoreTargetFixed ready.")

func _on_body_entered(body):
	if body.name == "Player":
		hit_count += 1
		print("Hit! Emitting score_changed(", hit_count, ")")
		score_changed.emit(hit_count)
		$TargetSprite.color = Color(1, 1, 1, 1)
		await get_tree().create_timer(0.15).timeout
		$TargetSprite.color = Color(0.1, 0.8, 0.3, 1)
