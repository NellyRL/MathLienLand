extends "res://minigames/labyrinthofrule3/characters/Character.gd"

# Senyal que se lanza cuando el jugador se ha movido.
signal labyrinth_moved
# Senyal que se lanza cuando el jugador ha muerto
signal labyrinth_dead
# Senyal que se lanza cuando el jugador a respondido con la opcion A
signal labyrinth_answerA
# Senyal que se lanza cuando el jugador a respondido con la opcion B
signal labyrinth_answerB
# Senyal que se lanza cuando el jugador a respondido con la opcion C
signal labyrinth_answerC
# Senyal que se lanza cuando el jugador a respondido con la opcion D
signal labyrinth_answerD

func _process(_delta):
	# Comprobamos repetidamente si esta procesando en 
	# esta funcion para que aunque el jugador mantenga
	# presionada una tecla de movimiento, no se ejecute
	# el movimiento. 
	if not is_processing():
		return
	# Si me puedo mover
	if move_allowed:
		# Compruebo cual de a todas las direcciones
		# quiere moverse el juegador
		for dir in movs.keys():
			if Input.is_action_pressed(dir) and is_processing():
				# Si se pudo mover activo el sonido de pasos y aviso.
				if is_processing() and move(dir):
					$FootStepsSound.play()
					emit_signal('labyrinth_moved')

func _on_Player_area_entered(area):
	# Si se ha topado con algun enemigo
	if area.is_in_group("enemies"):
		# Evitamos que se siga moviendo
		set_process(false)
		# Evitamos que se pueda colisionar con otro enemigo
		$CollisionShape2D.set_deferred("disabled", true)
		# Animamos la muerte
		$AnimationPlayer.play("die")
		# Esperamos que termine y avisamos del suceso.
		yield($AnimationPlayer, 'animation_finished')
		emit_signal("labyrinth_dead")

	# Si por el contrario se ha topado con algun coleccionable
	# como lo son las banderas de las opciones, emitimos la
	# senyal correspondiente para que la escena principal lo
	# procese.
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
	
