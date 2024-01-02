extends RigidBody2D
# Array que contiene las ruedas del jugador, que seran
# las responsables de su movimiento
var wheels = []
# Velocidad del jugador
export (int) var speed = 60000
# Limite de velocidad angular para las ruedas.
export (int) var max_angular_speed = 40
# FPS del proyecto
var project_fps
# Combustible inicial
var fuel = 100
# Senyal de final de juego
signal game_over
# Senial que indica si el jugador
# esta presionando teclas para 
# moverse.
var player_is_driving = 0

"""
func _input(event):
	if event.is_action_pressed('up'):
		$Camera2D.zoom -= Vector2(0.1, 0.1)
	if event.is_action_pressed('down'):
		$Camera2D.zoom += Vector2(0.1, 0.1)
"""

func _ready():
	# Para que esto funcione en todo el proyecto no debe 
	# haber mas elementos pertenecientes a este grupo
	wheels = get_tree().get_nodes_in_group("dhwheel")
	# FPS del proyecto
	project_fps = ProjectSettings.get_setting("physics/common/physics_fps")
	

func _physics_process(delta):
	# Por defecto consideramos que el jugador
	# no esta conduciendo.
	player_is_driving = 0
	# Si el jugador se puede mover
	if get_parent().can_move:
		# Si el jugador tiene combustible y no esta boca abajo, 
		# Paramos el temporizador de fin de juego y atendemos a las
		# acciones del jugador.
		if fuel > 0 and rotation_degrees <= 90 and rotation_degrees>=-90:
			$GameOverTimer.stop()
			if Input.is_action_pressed("right"):
				# Si se ha presionado la tecla, el jugador esta 
				# conduciendo.
				player_is_driving += 1
				# Para que pueda girar.
				apply_torque_impulse(-1500*delta*project_fps)
				# Cada vez que mueva el jugador, se consumira
				# combustible.
				use_fuel(delta)
				# El movimiento se aplicara a cada una de sus ruedas.
				for wheel in wheels:
					if wheel.angular_velocity < max_angular_speed:
						wheel.apply_torque_impulse(speed * delta * project_fps)
			# Se realizara lo mismo que en el caso de la derecha.
			if Input.is_action_pressed("left"):
				player_is_driving += 1
				apply_torque_impulse(1500*delta*project_fps)
				use_fuel(delta)
				for wheel in wheels:
					if wheel.angular_velocity > -max_angular_speed:
						wheel.apply_torque_impulse(-speed * delta * project_fps)
		else:
			# Si no tiene combustible o esta cabeza abajo, 
			# activamos el temporizador de fin de juego
			if $GameOverTimer.is_stopped():
				$GameOverTimer.start()
	# Si el jugador esta conduciendo, agudizamos el sunido del motor.
	if player_is_driving == 1:
		$Engine.pitch_scale = lerp($Engine.pitch_scale, 2, 2*delta)
	else:
		# Si no, volvemos a la normalidad.
		$Engine.pitch_scale = lerp($Engine.pitch_scale, 1, 2*delta)

func refuel():
	# Rellenamos el combustible del jugador
	fuel = 100
	get_parent().update_fuel_HUD(fuel)

func use_fuel(delta):
	# Disminuimos el combustible porque se esta usando.
	fuel -= 20*delta
	fuel = clamp(fuel, 0, 100)
	get_parent().update_fuel_HUD(fuel)


func _on_GameOverTimer_timeout():
	# Si el temporizador de game over ha llegado a su fin,
	# emitimos la senyal de fin de juego
	emit_signal("game_over")
