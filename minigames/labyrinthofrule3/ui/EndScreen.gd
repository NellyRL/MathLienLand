extends Control

func _enter_tree():
	MusicController.set_music()
	var node = $CanvasLayer/MarginContainer/VBoxContainer/Label
	# print(node.text)
	#$VictorySound.play()
	node.text = node.text.format({"seconds": str(Global.total_labyrinth_time)})
	Global.total_labyrinth_time = 0
	Global.current_labyrinth_question = 0
	

func _on_Continue_button_up():
	var _ret = get_tree().change_scene("res://minigames/labyrinthofrule3/ui/StartScreen.tscn")


