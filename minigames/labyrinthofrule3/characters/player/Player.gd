extends "res://minigames/labyrinthofrule3/characters/Character.gd"

signal labyrinth_moved
signal labyrinth_dead
signal labyrinth_answerA
signal labyrinth_answerB
signal labyrinth_answerC
signal labyrinth_answerD

func _process(_delta):
	# Si me puedo mover
	if move_allowed:
		# Compruebo cual de a todas las direcciones
		# quiere moverse el juegador
		for dir in movs.keys():
			if Input.is_action_pressed(dir):
				# Si se pudo mover aviso.
				if move(dir):
					emit_signal('labyrinth_moved')

func _on_Player_area_entered(area):
	if area.is_in_group("enemies"):
		emit_signal("labyrinth_dead")

	if area.has_method("pickup"):
		area.pickup()
		if area.type == "answerA":
			emit_signal("labyrinth_answerA")
		if area.type == "answerB":
			emit_signal("labyrinth_answerB")
		if area.type == "answerC":
			emit_signal("labyrinth_answerC")
		if area.type == "answerD":
			emit_signal("labyrinth_answerD")
	
