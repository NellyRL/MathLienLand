extends Control


# Texturas del boton de pausa/reanudar.
onready var pausetxtre = preload("res://assets/ui/pause.png")
onready var playtxtre = preload("res://assets/ui/play.png")
# Codigo duplicado por incopatibilidad de tipo de boton.
# Tamanyo normal
var normal_size = Vector2(1, 1)
# Tamanyo mas grande
var bigger_size = Vector2(1.05, 1.05)

func set_score(value):
	# Funcion para actualizar la puntacion en pantalla
	$Panel/Sections/SectionScore/Score.text = str(value)

func set_time(value):
	# Funcion para actualizar la puntacion en pantalla
	$Panel/Sections/SectionTimer/Seconds.text = str(value)
	
func set_moves(value):
	# Funcion para actualizar la puntacion en pantalla
	$Panel/Sections/SectionMoves/Moves.text = str(value)

func _on_ButtonPause_button_up():
	# Si el juego no esta en pausa, lo pausamos
	# y mostramos la pantalla de pausa.
	if get_tree().paused == true:
		get_tree().paused = false
		$Panel/Sections/SectionButtons/ButtonPause.texture_normal = pausetxtre
		#$PausedScreen.visible = false
	# Si el juego esta en pausa, lo reanudamos
	# y ocultamos la pantalla de pausa.
	else:
		get_tree().paused = true
		$Panel/Sections/SectionButtons/ButtonPause.texture_normal = playtxtre
		#$PausedScreen.visible = true

# Si el raton entra en el boton, se agranda
func _on_ButtonPause_mouse_entered() -> void:
	scaling_tween($Panel/Sections/SectionButtons/ButtonPause, bigger_size, .1)

# Si sale, se hace mas pequenyo
func _on_ButtonPause_mouse_exited() -> void:
	scaling_tween($Panel/Sections/SectionButtons/ButtonPause, normal_size, .1)
	
# Si el raton entra en el boton, se agranda
func _on_ButtonReset_mouse_entered() -> void:
	scaling_tween($Panel/Sections/SectionButtons/ButtonReset, bigger_size, .1)

# Si sale, se hace mas pequenyo
func _on_ButtonReset_mouse_exited() -> void:
	scaling_tween($Panel/Sections/SectionButtons/ButtonReset, normal_size, .1)

# Funcion para escalar el boton desde su tamanyo
# actual hasta el tamanyo final dado en los segundos indicados
func scaling_tween(btn, end_size, seconds):
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(btn, 'rect_scale', end_size, seconds)

func _on_ButtonReset_button_up():
	# Si se presiona el boton de retorno, volvemos a la escena de inicio.
	if get_tree().paused:
		get_tree().paused = false
	var _ret = get_tree().change_scene("res://minigames/functionmemory/ui/StartScreenFM.tscn")
