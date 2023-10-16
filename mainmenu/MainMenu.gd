extends Node2D

func _enter_tree():
	# Cada vez que entre la escena al arbol del proyecto de nuevo,
	# tenemos que comprobar que la musica tocada sea la correcta.
	MusicController.set_music()

func _on_SelectMinBtn_pressed():
	# Cambiamos la escena a la seleccion de minijuegos
	var _ret = get_tree().change_scene("res:///mainmenu/MinigameSelectScene.tscn")



func _on_ExitBtn_pressed():
	# Salimos
	get_tree().quit()
