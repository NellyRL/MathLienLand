extends Area2D
# Velocidad del jugador en este minijuego
# meteoritos
export var dsm_player_speed = 400
# Punto final de la pantalla.
var end_screen_point
# Punto inicial de la pantalla.
var start_screen_point
# Senyales para indicar a la escena principal
# si el jugador a respondido bien o no
signal correct_answer
signal wrong_answer

func _ready():
	# Obtenemos los puntos inicial y final de la pantalla
	start_screen_point = Vector2.ZERO
	end_screen_point = get_viewport().get_visible_rect().size


func _process(delta):
	# Si el jugador puede moverse segun lo indicado
	# por la escena principal
	if get_parent().get_parent().can_move:
		# Calculamos el vector direccion
		# que se empleara para mover al jugador
		# en la direccion indicada por el mismo.
		var dir = Vector2.ZERO
		# Para ello, usamos la comprobacion habitual,
		# de tal forma que se permite el presionado de
		# varias teclas a la vez y se empleen la logica
		# de los ejes cartesianos (x positiva, derecha
		# y x negativa izquierda, lo mismo para arriba
		# y abajo con y)
		if Input.is_action_pressed("right"):
			dir.x += 1
		if Input.is_action_pressed("down"):
			dir.y += 1
		if Input.is_action_pressed("left"):
			dir.x -= 1
		if Input.is_action_pressed("up"):
			dir.y -= 1
		
		# Si nos vamos a mover hacia arriba o hacia
		# abajo, usaremos la animacion de "inactividad"
		# para los lados.
		if dir.y != 0:
			$AnimatedSprite.animation = "idle"
		# En otro caso, usaremos la animacion
		# correspondiente segun se desee ir a la
		# derecha o a la izquierda.
		elif dir.x != 0:
			if dir.x > 0:
				$AnimatedSprite.animation = "right"
			else:
				$AnimatedSprite.animation = "left"
		
		# Si se esta presionando alguna tecla,
		# normalizamos la direccion para que no
		# por presionar mas de una tecla se vaya mas
		# rapido y ejecutamos la animacion seleccionada
		# previamente.
		if dir.length() > 0:
			dir = dir.normalized()
			$AnimatedSprite.play()
		# En otro caso simplemente paramos la animacion
		# de movimiento
		else:
			$AnimatedSprite.stop()
		
		# Finalmente modificamos la posicion del jugador segun la direccion
		# calculada, limitando para que no se salga de la pantalla.
		position += dir * dsm_player_speed * delta
		position.x = clamp(position.x, start_screen_point.x, end_screen_point.x)
		position.y = clamp(position.y, start_screen_point.y, end_screen_point.y)

func _on_Player_body_entered(body):
	# Si el jugador colisiona con un cuerpo, comprobamos
	# a que grupo pertenece dicho cuerpo.
	# Si es parte del grupo correcto:
	if body.is_in_group("correct"):
		# Pararemos la escena pues nos interesa que se vea
		# la animacion correspondiente pero la musica debe seguir
		# sonando para garantizar un mejor ambiente.
		$"/root/MusicController".get_node("MeteorsMusic").pause_mode=PAUSE_MODE_PROCESS
		get_tree().paused = true
		# Ejecutamos la funcion del cuerpo que 
		# se encargara de realizar todo lo necesario
		# para mostrarle al jugador la correccion de su
		# movimiento
		body.trigger_correct_reaction()
		# Esperamos un segundo para que el jugador pueda visualizarlo
		# antes de limpiar la escena.
		yield(get_tree().create_timer(1), "timeout")
		# Una vez terminado el tiempo de espera, procedemos
		# a continuar el juego con la siguiente pregunta.
		get_tree().paused = false
		$"/root/MusicController".get_node("MeteorsMusic").pause_mode = PAUSE_MODE_INHERIT
		# Finalmente, lanzamos la senyal correspondiente para
		# que la escena principal culmine el proceso de
		# reconocimiento de respuesta correcta.
		emit_signal("correct_answer")
	# Si es parte del grupo incorrecto
	if body.is_in_group("wrong"):
		# Ejecutamos la funcion del cuerpo que 
		# se encargara de realizar todo lo necesario
		# para mostrarle al jugador su fallo
		body.trigger_wrong_reaction()
		# Lanzamos la senyal correspondiente
		emit_signal("wrong_answer")
	
