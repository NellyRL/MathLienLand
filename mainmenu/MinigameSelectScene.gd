extends Control

func _enter_tree():
	# Cada vez que entre la escena al arbol del proyecto de nuevo,
	# tenemos que comprobar que la musica tocada sea la correcta.
	MusicController.set_music()

func _on_Exit_pressed():
	# Salimos
	get_tree().quit()


func _on_Back_pressed():
	# Cambiamos la escena al menu principal
	var _ret = get_tree().change_scene("res://mainmenu/MainMenu.tscn")
