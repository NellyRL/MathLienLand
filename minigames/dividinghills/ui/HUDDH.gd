extends Control

signal hills_answerA
signal hills_answerB
signal hills_answerC
signal hills_answerD
signal continue_pressed


func _on_A_button_up():
	emit_signal("hills_answerA")


func _on_B_button_up():
	emit_signal("hills_answerB")


func _on_C_button_up():
	emit_signal("hills_answerC")


func _on_D_button_up():
	emit_signal("hills_answerD")


func _on_Continue_button_up():
	emit_signal("continue_pressed")
