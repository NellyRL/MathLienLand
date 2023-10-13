extends Control

onready var infoBtn =  $CanvasLayer/MarginContainer/VBoxContainer/GridContainer/Info
onready var normal_size = infoBtn.rect_scale
onready var infopanel = $CanvasLayer/MarginContainer/Panel
var bigger_size = Vector2(1.1, 1.1)


func _on_Info_mouse_entered() -> void:
	scaling_tween(bigger_size, .1)


func _on_Info_mouse_exited() -> void:
	scaling_tween(normal_size, .1)
	
	
func scaling_tween(end_size, seconds):
	#print("estoy aqui")
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	#print(tween)
	tween.tween_property(infoBtn, 'rect_scale', end_size, seconds)



func _on_Info_pressed():
	if not infopanel.visible:
		infopanel.visible = true



func _on_Close_pressed():
	if infopanel.visible:
		infopanel.visible = false
