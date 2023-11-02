extends Node2D
var move_active = false
var pos = 0
var numcharacters = 4

func _ready():
	MusicController.set_music()
	set_camera_limits()

func _on_Goal_area_entered(area):
	pos += 1
	print(area.get_parent().get_parent().name + " ha llegado en la posicion " + str(pos) + "!")
	if pos == numcharacters:
		# Lanzar senyal o algo para indicar que todos han llegado.
		# O mejor simplemente comprobar en que posicion ha llegado el jugador
		# y ya.
		pos = 0

func set_camera_limits():
	# Obtenemos las dimensiones del laberinto en 
	# celdas
	var track_dims = $Ground.get_used_rect()
	# Obtenemos las dimensiones de las celdas en 
	# pixeles
	var cell_dims = $Ground.cell_size
	# Ponemos los limites en pixeles partiendo de las
	# dimensiones obtenidas.
	var player_camera = $Player/PathFollow2D/Character/Camera2D
	player_camera.limit_bottom = track_dims.end.y * cell_dims.y
	player_camera.limit_left = track_dims.position.x * cell_dims.x
	player_camera.limit_right = track_dims.end.x * cell_dims.x
	player_camera.limit_top = track_dims.position.y * cell_dims.y


func _on_StartTimer_timeout():
	print("EMPEZAMOS")
	move_active = true
