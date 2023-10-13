extends Node2D

export (PackedScene) var Enemy_1
export (PackedScene) var Enemy_2
export (PackedScene) var Enemy_3

export (PackedScene) var Pickup

onready var items = $Items

# Array para guardar las posiciones de las cuatro posiciones
# de puertas a cerrar en caso de fallo. Tantas como posibles
# respuestas haya.
var door_frames = []
var num_answers = 4
var answers = ["answerA", "answerB", "answerC", "answerD"]
var door_ids = {"answerA": ["doorA", 0], "answerB": ["doorB", 1], "answerC": ["doorC", 2], "answerD": ["doorD", 3]}

func _ready():
	randomize()
	$Items.hide()
	set_camera_limits()
	# Nombres dados a los marcadores de las posiciones
	# de las puertas.
	var door_frames_names = ['doorframeA', 
	"doorframeB", "doorframeC", "doorframeD"]
	# Por cada marcador nos hemos asegurado de solamente poner una
	# celda con dicha "baldosa", asi que nos vale con cojer la primera
	# celda obtenida con ese nombre.
	#for cell in $Walls.get_used_cells():
		# Obtenemos su id
	#	var id = $Walls.get_cellv(cell)
		# Obtenemos el nombre de la "baldosa"
	#	var type = $Walls.tile_set.tile_get_name(id)
	#	print(type)
	
	for tile_name in door_frames_names:
		#print(tile_name)
		var door_frame_id = $Walls.tile_set.find_tile_by_name(tile_name)
		#print(door_frame_id)
		var cells_by_id = $Walls.get_used_cells_by_id(door_frame_id)
		#print(cells_by_id)
		door_frames.append($Walls.get_used_cells_by_id(door_frame_id).front())
	
	# Comprobamos que hayan tantas posiciones de puertas como respuestas posibles.
	if door_frames.size() < num_answers:
		print("No se han establecido correctamente las posiciones de las puertas")
		get_tree().quit()
	
	spawn_items()
	$Player.connect("labyrinth_dead", self, "game_over")
	$Player.connect("labyrinth_answerA", self, "_on_Player_answered_a")
	$Player.connect("labyrinth_answerB", self, "_on_Player_answered_b")
	$Player.connect("labyrinth_answerC", self, "_on_Player_answered_c")
	$Player.connect("labyrinth_answerD", self, "_on_Player_answered_d")
	
	set_question_hud()
	
func set_camera_limits():
	# Obtenemos las dimensiones del laberinto en 
	# celdas
	var maze_dims = $Ground.get_used_rect()
	# Obtenemos las dimensiones de las celdas en 
	# pixeles
	var cell_dims = $Ground.cell_size
	# Ponemos los limites en pixeles partiendo de las
	# dimensiones obtenidas.
	$Player/Camera2D.limit_bottom = maze_dims.end.y * cell_dims.y
	$Player/Camera2D.limit_left = maze_dims.position.x * cell_dims.x
	$Player/Camera2D.limit_right = maze_dims.end.x * cell_dims.x
	$Player/Camera2D.limit_top = maze_dims.position.y * cell_dims.y

func spawn_items():
	# Para cada celda del laberinto
	for cell in items.get_used_cells():
		# Obtenemos su id
		var id = items.get_cellv(cell)
		# Obtenemos el nombre de la "baldosa"
		var type = items.tile_set.tile_get_name(id)
		# Obtenemos la posicion central de la celda mediante
		# su punto inicial (map_to_world) y la mitad del tamanio
		# de una celda.
		var pos = items.map_to_world(cell) + items.cell_size/2
		# Ahora procedemos a ver que tipo de item es:
		match type:
			"enemies_spawner1":
				var ghost = Enemy_1.instance()
				ghost.position = pos
				ghost.tile_dim = items.cell_size
				add_child(ghost)
			"enemies_spawner2":
				var slime = Enemy_2.instance()
				slime.position = pos
				slime.tile_dim = items.cell_size
				add_child(slime)
			"enemies_spawner3":
				var spider = Enemy_3.instance()
				spider.position = pos
				spider.tile_dim = items.cell_size
				add_child(spider)
			"answerA", "answerB", "answerC", "answerD":
				var answer_flag =  Pickup.instance()
				answer_flag.init(type, pos)
				add_child(answer_flag)
			"player_spawner":
				$Player.position = pos
				$Player.tile_dim = items.cell_size

func game_over():
	$Player.move_allowed = false
	$Player.hide()
	yield(get_tree().create_timer(1), 'timeout')
	$Player.position = $StartingPoint.position
	$Player/AnimationPlayer.play_backwards("die")
	$Player.show()
	yield($Player/AnimationPlayer, 'animation_finished')
	$Player.move_allowed = true
	$Player.set_process(true)
	$Player/CollisionShape2D.set_deferred("disabled", false)
	

func _on_Player_answered_a():
	check_answer(answers[0])
	
func _on_Player_answered_b():
	check_answer(answers[1])
	
func _on_Player_answered_c():
	check_answer(answers[2])
	
func _on_Player_answered_d():
	check_answer(answers[3])

func check_answer(answer):
	if not answer in answers:
		return
	
	var correct = Global.labyrinth_questions[Global.current_labyrinth_question][answer][1]
	if correct:
		Global.current_labyrinth_question+=1
		print("Correctas:", Global.current_labyrinth_question)
		if Global.current_labyrinth_question >= Global.num_labyrinth_questions:
			Global.current_labyrinth_question=0
			get_tree().change_scene("res://minigames/labyrinthofrule3/ui/EndScreen.tscn")
		else:
			set_question_hud()
			get_tree().reload_current_scene()
	else:
		print("Incorrecto!")
		var door_id = $Walls.tile_set.find_tile_by_name(door_ids[answer][0])
		#print(door_id)
		$Walls.set_cellv(door_frames[door_ids[answer][1]], door_id)
		game_over()


func set_question_hud():
	$CanvasLayer/HUD/Panel/HBoxContainer/QuestionMargin/Question.text = Global.labyrinth_questions[Global.current_labyrinth_question]["question"]
	$CanvasLayer/HUD/A/Answer.text = Global.labyrinth_questions[Global.current_labyrinth_question]["answerA"][0]
	$CanvasLayer/HUD/B/Answer.text = Global.labyrinth_questions[Global.current_labyrinth_question]["answerB"][0]
	$CanvasLayer/HUD/C/Answer.text = Global.labyrinth_questions[Global.current_labyrinth_question]["answerC"][0]
	$CanvasLayer/HUD/D/Answer.text = Global.labyrinth_questions[Global.current_labyrinth_question]["answerD"][0]
