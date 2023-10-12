extends Node2D

func _on_SelectMinBtn_pressed():
	# Cambiamos la escena a la seleccion de minijuegos
	var _ret = get_tree().change_scene("res:///mainmenu/MinigameSelectScene.tscn")



func _on_ExitBtn_pressed():
	# Salimos
	get_tree().quit()
