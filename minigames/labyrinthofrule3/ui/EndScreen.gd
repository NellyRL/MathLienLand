extends Control

onready var btn =  $CanvasLayer/MarginContainer/VBoxContainer/GridContainer/Continue
onready var normal_size = btn.rect_scale

var bigger_size = Vector2(1.1, 1.1)


func _on_Continue_mouse_entered() -> void:
	scaling_tween(bigger_size, .1)


func _on_Continue_mouse_exited() -> void:
	scaling_tween(normal_size, .1)
	
	
func scaling_tween(end_size, seconds):
	#print("estoy aqui")
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	#print(tween)
	tween.tween_property(btn, 'rect_scale', end_size, seconds)



func _on_Continue_button_up():
	get_tree().change_scene("res://minigames/labyrinthofrule3/ui/StartScreen.tscn")
