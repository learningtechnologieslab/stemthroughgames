## PhysicsHUD.gd
## STEM Through Games – Day 6: Physics Debug Display
## =============================================================================
## This HUD (Heads-Up Display) prints live physics data to the screen.
## Watching these numbers change in real-time is the best way to UNDERSTAND
## what gravity and jumping are actually doing to velocity every frame.
##
## HOW TO USE:
##   Attach this script to a CanvasLayer node in your scene.
##   Set the `player` export variable to point to your Player node.
##
## WHAT TO WATCH:
##   • velocity.y climbs from 0 while falling (gravity accelerating it)
##   • velocity.y snaps to JUMP_VELOCITY the moment you jump
##   • velocity.y decelerates back toward 0 at the jump peak (parabola!)
##   • is_on_floor() flips between true/false as you land and leave the ground
## =============================================================================

extends CanvasLayer

## Drag your Player node here in the Inspector.
@export var player: CharacterBody2D

# We'll store references to our Label nodes after _ready().
var _label: RichTextLabel

func _ready() -> void:
	# Build the label programmatically so students don't need a separate scene.
	_label = RichTextLabel.new()
	_label.bbcode_enabled = true
	_label.fit_content = true
	_label.position = Vector2(12, 12)
	_label.size = Vector2(340, 260)
	add_child(_label)

	# Semi-transparent dark background panel
	var bg := ColorRect.new()
	bg.color = Color(0, 0, 0, 0.62)
	bg.position = Vector2(8, 8)
	bg.size = Vector2(348, 264)
	add_child(bg)
	move_child(bg, 0)  # Put bg behind the label

func _process(_delta: float) -> void:
	if not player:
		_label.text = "[color=red]⚠ No player assigned![/color]\nSet 'player' in the Inspector."
		return

	var vel     := player.velocity
	var on_floor := player.is_on_floor()
	var speed_x  := abs(vel.x)
	var speed_y  := abs(vel.y)

	# Color-code velocity.y: green when going up, red when going down.
	var vy_color := "lime" if vel.y < 0 else ("white" if vel.y == 0 else "tomato")
	var floor_color := "lime" if on_floor else "gray"
	var state := "ON FLOOR" if on_floor else ("RISING ↑" if vel.y < 0 else "FALLING ↓")
	var state_color := "lime" if on_floor else ("cyan" if vel.y < 0 else "tomato")

	_label.text = (
		"[b][color=gold]── Physics Debug HUD ──[/color][/b]\n" +
		"\n" +
		"[color=silver]velocity.x[/color]   [b]%.1f[/b] px/s\n" % vel.x +
		"[color=silver]velocity.y[/color]   [b][color=%s]%.1f[/color][/b] px/s\n" % [vy_color, vel.y] +
		"[color=silver]speed     [/color]   [b]%.1f[/b] px/s\n" % Vector2(vel.x, vel.y).length() +
		"\n" +
		"[color=silver]is_on_floor()[/color]  [b][color=%s]%s[/color][/b]\n" % [floor_color, str(on_floor).to_upper()] +
		"[color=silver]state         [/color]  [b][color=%s]%s[/color][/b]\n" % [state_color, state] +
		"\n" +
		"[color=gold]── Controls ──[/color]\n" +
		"[color=silver]Move:[/color]  Arrow keys / A D\n" +
		"[color=silver]Jump:[/color]  Space / W / Up Arrow"
	)
