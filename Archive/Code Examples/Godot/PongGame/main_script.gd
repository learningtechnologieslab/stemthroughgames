extends Node2D

var ball_velocity = Vector2(200, 150)  # Ball speed
var paddle_speed = 400

func _ready():
    pass

func _process(delta):
    # Move paddles up and down
    if Input.is_action_pressed("ui_up"):
        $PaddleRight.position.y -= paddle_speed * delta
    elif Input.is_action_pressed("ui_down"):
        $PaddleRight.position.y += paddle_speed * delta
    
    if Input.is_action_pressed("w"):
        $PaddleLeft.position.y -= paddle_speed * delta
    elif Input.is_action_pressed("s"):
        $PaddleLeft.position.y += paddle_speed * delta

    # Move the ball
    $Ball.position += ball_velocity * delta
    
    # Bounce the ball off top and bottom edges
    if $Ball.position.y < 0 or $Ball.position.y > 600:
        ball_velocity.y = -ball_velocity.y

    # Bounce the ball off the paddles
    if $Ball.get_rect().intersects($PaddleLeft.get_rect()) or $Ball.get_rect().intersects($PaddleRight.get_rect()):
        ball_velocity.x = -ball_velocity.x
