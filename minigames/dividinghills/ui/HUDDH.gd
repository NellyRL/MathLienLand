extends Control

# Senyales correspondientes a las respuestas posibles
signal hills_answerA
signal hills_answerB
signal hills_answerC
signal hills_answerD
# Senyal para indicar la presion del boton continue
signal continue_pressed
# Texturas del boton de pausa/reanudar.
onready var pausetxtre = preload("res://assets/ui/pause.png")
onready var playtxtre = preload("res://assets/ui/play.png")
# Codigo duplicado por incopatibilidad de tipo de boton.
# Tamanyo normal
var normal_size = Vector2(0.75, 0.75)
# Tamanyo mas grande
var bigger_size = Vector2(0.8, 0.8)

func _on_A_button_up():
	# Si se responde A se emite la senya correspondiente.
	emit_signal("hills_answerA")


func _on_B_button_up():
	# Si se responde B se emite la senya correspondiente.
	emit_signal("hills_answerB")


func _on_C_button_up():
	# Si se responde C se emite la senya correspondiente.
	emit_signal("hills_answerC")


func _on_D_button_up():
	# Si se responde D se emite la senya correspondiente.
	emit_signal("hills_answerD")


func _on_Continue_button_up():
	# Cuando se presione continue se emite la 
	# senyal correspondiente.
	emit_signal("continue_pressed")
	
func set_score(value):
	# Funcion para actualizar la puntacion en pantalla
	$Score/Label.text = str(value)

func set_fuel(value):
	# Funcion para actualizar el combustible en pantalla
	$Fuel/ProgressBar.value = value
	$Fuel/ProgressBar.get_stylebox("fg").bg_color.h = lerp(0, 0.33, value/100)
	
func set_time(value):
	# Funcion para actualizar el tiempo en pantalla
	$Time/Label.text = str(value)


func show_feedback(feed):
	# Funcion para establecer un mensaje de feedback a mostrar
	$MarginContainer/Panel2/MarginContainer/VBoxContainer/Feedback.text = feed


func _on_PauseBtn_button_up():
	# Si el juego no esta en pausa, lo pausamos
	# y mostramos la pantalla de pausa.
	if get_tree().paused == true:
		get_tree().paused = false
		$PauseBtn.texture_normal = pausetxtre
		$PausedScreen.visible = false
	# Si el juego esta en pausa, lo reanudamos
	# y ocultamos la pantalla de pausa.
	else:
		get_tree().paused = true
		$PauseBtn.texture_normal = playtxtre
		$PausedScreen.visible = true

# Si el raton entra en el boton, se agranda
func _on_PauseBtn_mouse_entered() -> void:
	scaling_tween($PauseBtn, bigger_size, .1)

# Si sale, se hace mas pequenyo
func _on_PauseBtn_mouse_exited() -> void:
	scaling_tween($PauseBtn, normal_size, .1)
	
# Si el raton entra en el boton, se agranda
func _on_ReturnBtn_mouse_entered() -> void:
	scaling_tween($ReturnBtn, bigger_size, .1)

# Si sale, se hace mas pequenyo
func _on_ReturnBtn_mouse_exited() -> void:
	scaling_tween($ReturnBtn, normal_size, .1)

# Funcion para escalar el boton desde su tamanyo
# actual hasta el tamanyo final dado en los segundos indicados
func scaling_tween(btn, end_size, seconds):
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(btn, 'rect_scale', end_size, seconds)

func _on_ReturnBtn_button_up():
	# Si se presiona el boton de retorno, volvemos a la escena de inicio.
	if get_tree().paused:
		get_tree().paused = false
	var _ret = get_tree().change_scene("res://minigames/dividinghills/ui/StartScreenDH.tscn")
