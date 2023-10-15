extends "res://minigames/labyrinthofrule3/characters/Character.gd"

signal labyrinth_moved
signal labyrinth_dead
signal labyrinth_answerA
signal labyrinth_answerB
signal labyrinth_answerC
signal labyrinth_answerD

func _process(_delta):
	if not is_processing():
		return
	# Si me puedo mover
	if move_allowed:
		# Compruebo cual de a todas las direcciones
		# quiere moverse el juegador
		for dir in movs.keys():
			if Input.is_action_pressed(dir) and is_processing():
				# Si se pudo mover aviso.
				if is_processing() and move(dir):
					$FootStepsSound.play()
					emit_signal('labyrinth_moved')

func _on_Player_area_entered(area):
	if area.is_in_group("enemies"):
		set_process(false)
		$CollisionShape2D.set_deferred("disabled", true)
		$AnimationPlayer.play("die")
		yield($AnimationPlayer, 'animation_finished')
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
	
