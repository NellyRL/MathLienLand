extends Control




func _on_BackBtn_button_up():
	Global.current_labyrinth_question = 0
	Global.total_labyrinth_time = 0
	get_tree().change_scene("res://minigames/labyrinthofrule3/ui/StartScreen.tscn")



func _on_PauseBtn_button_up():
	if not $PausedScreen.visible:
		get_tree().paused = true
		$PausedScreen.visible = true


func _on_ResumeBtn_button_up():
	if $PausedScreen.visible:
		get_tree().paused = false
		$PausedScreen.visible = false
