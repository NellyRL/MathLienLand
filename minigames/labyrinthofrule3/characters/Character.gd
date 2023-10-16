extends Area2D

# Velocidad de las animaciones. Es ajustable.
export (int) var velocity

# Tamanio de las celdas
var tile_dim = 64
# Si es true implica que no hay paredes
# que impidan el movimiento.
var move_allowed = true

# Orientacion del personaje en el mapa.
var orientation = 'right'

# Movimientos posibles.
var movs = {'right': Vector2(1, 0), 'left': Vector2(-1, 0),
'up': Vector2(0, -1), 'down': Vector2(0, 1)}

# Avisadores de las 4 direcciones.
onready var raycasts = {'right': $RayCastR, 'left': $RayCastL,
'up': $RayCastU, 'down': $RayCastD}


# Funcion comun para mover un personaje.
func move(direction):
	#print("Estoy aca")
	#$AnimatedSprite.speed_scale
	
	# Aplicamos la velocidad deseada a la animacion.
	$AnimationPlayer.playback_speed = velocity
	
	# Orientamos el personaje a la direccion deseada
	orientation = direction
	# Vemos si se puede avanzar en esa direccion.
	if raycasts[orientation].is_colliding():
		#print("Objeto bloquea")
		return
	
	#print("Amoh a movernos")
	# Vamos a movernos, asi que no se permite otro movimiento
	# mientras tanto.
	move_allowed = false
	# Ejecutamos la animacion
	$AnimationPlayer.play(orientation)
	
	# Tween para hacer mas atractivo el movimiento.
	# Esto es lo que movera al jugador.
	var origin = position
	var end = position + movs[orientation] * tile_dim
	#print(origin, end)
	# Por si sucede el caso que el jugador no se pueda mover
	# y no se haya detectado hasta ahora, comprobamos que 
	# la funcion process este activa.
	if is_processing():
		$MoveTween.interpolate_property(self, "position", origin, end, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$MoveTween.start()
		return true
	


func _on_MoveTween_tween_completed(_object, _key):
	# Una vez termine el tween procedemos a permitir el movimiento de nuevo
	move_allowed = true

