extends Button
# Script que se emplea si se desea que un boton tenga un efecto
# mientras el mouse este sobre el.

# Tamanyo normal
var normal_size = rect_scale
# Tamanyo mas grande
var bigger_size = Vector2(1.1, 1.1)

# Si el raton entra en el boton, se agranda
func _on_Btn_mouse_entered() -> void:
	scaling_tween(bigger_size, .1)

# Si sale, se hace mas pequenyo
func _on_Btn_mouse_exited() -> void:
	scaling_tween(normal_size, .1)

# Funcion para escalar el boton desde su tamanyo
# actual hasta el tamanyo final dado en los segundos indicados
func scaling_tween(end_size, seconds):
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, 'rect_scale', end_size, seconds)
