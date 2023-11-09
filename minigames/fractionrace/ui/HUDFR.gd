extends Control

# Senyal que se lanza cuando el jugador a respondido con la opcion A
signal race_answerA
# Senyal que se lanza cuando el jugador a respondido con la opcion B
signal race_answerB
# Senyal que se lanza cuando el jugador a respondido con la opcion C
signal race_answerC
# Senyal que se lanza cuando el jugador a respondido con la opcion D
signal race_answerD

func _on_BackBtn_button_up():
	# Si el usuario desea volver a la pantalla de inicio del
	# juego, reseteamos las variables que controlan la aparicion
	# de preguntas y cambiamos de escena.
	Global.current_race_question = 0
	Global.total_race_time = 0
	var _ret = get_tree().change_scene("res://minigames/fractionrace/ui/StartScreenFR.tscn")



func _on_PauseBtn_button_up():
	# Si el usuario desea pausar la escena, mostramos un panel
	# auxiliar que permita al usuario reanudar el juego y
	# pausamos el juego.
	if not $PausedScreen.visible:
		get_tree().paused = true
		$PausedScreen.visible = true


func _on_ResumeBtn_button_up():
	# Si el usuario desea continuar con el juego, dejamos de
	# mostrar el panel de pausa y reanudamos el juego.
	if $PausedScreen.visible:
		get_tree().paused = false
		$PausedScreen.visible = false



func _on_answerA_button_up():
	emit_signal("race_answerA")
	print("Ha seleccionado A")


func _on_answerB_button_up():
	emit_signal("race_answerB")
	print("Ha seleccionado B")


func _on_answerC_button_up():
	emit_signal("race_answerC")
	print("Ha seleccionado C")


func _on_answerD_button_up():
	emit_signal("race_answerD")
	print("Ha seleccionado D")
