extends Area2D

var textures = {'answerA': 'res://assets/maze/Other/flagBlue.png',
				'answerB': 'res://assets/maze/Other/flagGreen.png',
				'answerC': 'res://assets/maze/Other/flagRed.png',
				'answerD': 'res://assets/maze/Other/flagYellow.png'}

# Obtenido del libro Godot Engine Game Development Projects
# TODO: Mejorar si es posible
var type

func _ready():
	$Tween.interpolate_property($Sprite, 'scale', Vector2(1, 1),
	Vector2(3, 3), 0.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	
	$Tween.interpolate_property($Sprite, 'modulate',
	Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.5,
	Tween.TRANS_QUAD, Tween.EASE_IN_OUT)


func init(_type, pos):
	$Sprite.texture = load(textures[_type])
	type = _type
	position = pos


func pickup():
	$CollisionShape2D.set_deferred("disabled", true)
	$Tween.start()

func _on_Tween_completed(object, key):
	queue_free()
