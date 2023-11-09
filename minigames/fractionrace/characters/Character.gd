extends Path2D

# export (int) var normal_speed
export (int) var acceleration = 1
export (int) var sprite = 1
export (bool) var active_camera = false
export (int) var acceleration_duration_in_seconds = 1
var acceleration_duration_in_frames_max = 60
var acceleration_left_duration_in_frames = 60
var project_fps
var total_path_time = 60
var total_path_frames


func _ready():
	# FPS del proyecto
	project_fps = ProjectSettings.get_setting("physics/common/physics_fps")
	#print(project_fps)
	# Frames que la aceleracion va a durar
	acceleration_duration_in_frames_max = project_fps * acceleration_duration_in_seconds
	# Aceleracion restante
	acceleration_left_duration_in_frames = acceleration_duration_in_frames_max
	#print(acceleration_left_duration_in_frames)
	# Frames que durara el recorrido del camino.
	total_path_frames = total_path_time * project_fps
	# Ponemos que personaje va a tener la camara activa.
	$PathFollow2D/Character/Camera2D.current = active_camera
	# Esto funcionara siempre que todos los sprites posibles
	# sean de la forma SpriteX y solo haya dos hijos mas de Character:
	# la forma de colision y la camara.
	#print($PathFollow2D/Character.get_child_count())
	# Hacemos visible solo el sprite que representara cada personaje
	for i in range(1, $PathFollow2D/Character.get_child_count()-1):
		#print("PathFollow2D/Character/Sprite"+str(i))
		get_node("PathFollow2D/Character/Sprite"+str(i)).visible = false
	
	get_node("PathFollow2D/Character/Sprite"+str(sprite)).visible = true
	#pass
	

func _physics_process(_delta):
	# Si esta ubicado en la escena principal y dicha escena
	# ha activado el movimiento, el personaje se movera de 
	# acuerdo a la duracion indicada
	if get_parent()!=null and get_parent().move_active:
		var step = float(1)/float(total_path_frames)
		#print(step)
		# Si hay aceleracion, nos movemos mas rapido un 
		# determinado tiempo
		if acceleration > 1:
			#speed *= acceleration
			step *= acceleration
			acceleration_left_duration_in_frames -= 1
			if acceleration_left_duration_in_frames == 0:
				acceleration = 1
				acceleration_left_duration_in_frames = acceleration_duration_in_frames_max
			
		#$PathFollow2D.set_offset($PathFollow2D.get_offset()+speed*delta)
		$PathFollow2D.unit_offset += step
