extends Control



func _on_BackBtn_button_up():
	Global.current_labyrinth_question = 0
	get_tree().change_scene("res://minigames/labyrinthofrule3/ui/StartScreen.tscn")

