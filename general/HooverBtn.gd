extends Button

var normal_size = rect_scale
var bigger_size = Vector2(1.1, 1.1)


func _on_Btn_mouse_entered() -> void:
	scaling_tween(bigger_size, .1)


func _on_Btn_mouse_exited() -> void:
	scaling_tween(normal_size, .1)
	
	
func scaling_tween(end_size, seconds):
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, 'rect_scale', end_size, seconds)
