extends Node2D

var player_position = Vector2(400, 300)
var enemy_position = Vector2(600, 300)

func _ready():
    $Label.text = "Distance: %s" % str(calculate_distance(player_position, enemy_position))

func _process(delta):
    pass

func calculate_distance(p1: Vector2, p2: Vector2) -> float:
    return p1.distance_to(p2)
