extends Area2D

export var dsm_player_speed = 400
var end_screen_point
var start_screen_point
signal correct_answer
signal wrong_answer

func _ready():
	start_screen_point = Vector2.ZERO
	end_screen_point = get_viewport().get_visible_rect().size


func _process(delta):
	var dir = Vector2.ZERO
	if Input.is_action_pressed("right"):
		dir.x += 1
	if Input.is_action_pressed("down"):
		dir.y += 1
	if Input.is_action_pressed("left"):
		dir.x -= 1
	if Input.is_action_pressed("up"):
		dir.y -= 1
		
	if dir.y != 0:
		$AnimatedSprite.animation = "idle"
	elif dir.x != 0:
		if dir.x > 0:
			$AnimatedSprite.animation = "right"
		else:
			$AnimatedSprite.animation = "left"
	
	# Si se esta presionando alguna tecla.
	if dir.length() > 0:
		dir = dir.normalized()
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += dir * dsm_player_speed * delta
	position.x = clamp(position.x, start_screen_point.x, end_screen_point.x)
	position.y = clamp(position.y, start_screen_point.y, end_screen_point.y)

func _on_Player_body_entered(body):
	print("He chocado con algo")
	if body.is_in_group("correct"):
		print("Good collision")
		emit_signal("correct_answer")
	if body.is_in_group("wrong"):
		print("Bad collision")
		emit_signal("wrong_answer")
	
