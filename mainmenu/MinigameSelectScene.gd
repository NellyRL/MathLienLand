extends Control


func _on_Exit_pressed():
	# Salimos
	get_tree().quit()


func _on_Back_pressed():
	# Cambiamos la escena al menu principal
	var _ret = get_tree().change_scene("res://mainmenu/MainMenu.tscn")
