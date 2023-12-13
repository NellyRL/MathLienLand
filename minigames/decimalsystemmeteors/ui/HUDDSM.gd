extends Control

func _on_BackBtn_button_up():
	# Si el usuario desea volver a la pantalla de inicio del
	# juego, reseteamos las variables que controlan la aparicion
	# de preguntas y cambiamos de escena.
	# Global.current_labyrinth_question = 0
	# Global.total_labyrinth_time = 0
	var _ret = get_tree().change_scene("res://minigames/decimalsystemmeteors/ui/StartScreenDSM.tscn")

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
