extends "res://minigames/labyrinthofrule3/characters/Character.gd"

func _ready():
	# La primera vez que se cree el enemigo aun no
	# queremos que se mueva, puesto que tenemos
	# que esperar que las paredes esten establecidas
	move_allowed = false
	# Elegimos aleatoriamente una direccion por la que empezara
	# a moverse
	orientation = movs.keys()[randi() % 4]
	# Esperamos a que las paredes aparezcan y se 
	# procesen.
	yield(get_tree().create_timer(0.5), 'timeout')
	# Volvemos a habilitar el movimiento.
	move_allowed = true

func _process(_delta):
	# Si podemos movernos porque ha terminado 
	# el anterior movimiento.
	if move_allowed:
		# Nos intentamos mover en la misma direccion
		# y si no podemos cambiamos. Si si podemos, 
		# aun asi podemos cambiar de direccion con 
		# un medio de probabilidad.
		if not move(orientation) or randi()%2 > 0:
			orientation = movs.keys()[randi() % 4]
