extends Control

onready var infopanel = $CanvasLayer/MarginContainer/Panel

func _enter_tree():
	MusicController.set_music()

func _on_Info_pressed():
	if not infopanel.visible:
		infopanel.visible = true

func _on_Close_pressed():
	if infopanel.visible:
		infopanel.visible = false

