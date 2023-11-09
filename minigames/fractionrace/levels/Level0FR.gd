extends Node2D
var move_active = false
var pos = 0
var numcharacters = 4
# Nombres de las 4 opciones. Son empleadas como claves en 
# distintos diccionarios.
var answers = ["answerA", "answerB", "answerC", "answerD"]
var acceleration_rivals = 6
var acceleration_player = 4
var seconds_till_next_acceleration_try_rivals = 5

func _ready():
	randomize()
	MusicController.set_music()
	set_camera_limits()
	
	var _ret
	_ret = $CanvasLayer/HUDFR.connect("race_answerA", self, "_on_Player_answered_a")
	_ret = $CanvasLayer/HUDFR.connect("race_answerB", self, "_on_Player_answered_b")
	_ret = $CanvasLayer/HUDFR.connect("race_answerC", self, "_on_Player_answered_c")
	_ret = $CanvasLayer/HUDFR.connect("race_answerD", self, "_on_Player_answered_d")
	
	
	set_question_hud()

func _enter_tree():
	MusicController.set_music()
	

func _on_Goal_area_entered(area):
	pos += 1
	if area.get_parent().get_parent().name == "Player":
		print(area.get_parent().get_parent().name + " ha llegado en la posicion " + str(pos) + "!")
		Global.final_position = pos
		# Tocar musica de llegada, aplausos o algo y cambiar de escena.
		var _ret = get_tree().change_scene("res://minigames/fractionrace/ui/EndScreenFR.tscn")
		

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
	$Time.start()

func set_question_hud():
	# Funcion que se encarga de mostrar la pregunta correspondiente
	# con sus opciones en pantalla
	$CanvasLayer/HUDFR/Panel/HBoxContainer/QuestionMargin/VBoxContainer/question.texture = load(Global.race_questions[Global.current_race_question]["question"])
	$CanvasLayer/HUDFR/Panel/HBoxContainer/QuestionMargin/VBoxContainer/HBoxContainer/answerA/TextureRect.texture = load(Global.race_questions[Global.current_race_question]["answerA"][0])
	$CanvasLayer/HUDFR/Panel/HBoxContainer/QuestionMargin/VBoxContainer/HBoxContainer/answerB/TextureRect.texture = load(Global.race_questions[Global.current_race_question]["answerB"][0])
	$CanvasLayer/HUDFR/Panel/HBoxContainer/QuestionMargin/VBoxContainer/HBoxContainer/answerC/TextureRect.texture = load(Global.race_questions[Global.current_race_question]["answerC"][0])
	$CanvasLayer/HUDFR/Panel/HBoxContainer/QuestionMargin/VBoxContainer/HBoxContainer/answerD/TextureRect.texture = load(Global.race_questions[Global.current_race_question]["answerD"][0])

# Funcion que realiza el conteo del tiempo que el usuario esta jugando 
# juego. Su funcion consiste en, cada segundo, aumentar el contador de
# segundos del script global y mostrar el total en pantalla.
func _on_Time_timeout():
	Global.total_race_time+=1
	$CanvasLayer/HUDFR/Time.text = str(Global.total_race_time)
	# Cada X segundos se intentara dar un aceleron a los
	# contrincantes.
	if Global.total_race_time%seconds_till_next_acceleration_try_rivals==0:
		var number = randi()%2
		if number == 1:
			$Rival1.acceleration=acceleration_rivals
		number = randi()%2
		if number == 1:
			$Rival2.acceleration=acceleration_rivals
		number = randi()%2
		if number == 1:
			$Rival3.acceleration=acceleration_rivals

func _on_Player_answered_a():
	check_answer(answers[0])
	
func _on_Player_answered_b():
	check_answer(answers[1])
	
func _on_Player_answered_c():
	check_answer(answers[2])
	
func _on_Player_answered_d():
	check_answer(answers[3])

func check_answer(answer):
	# Funcion para comprobar si la opcion elegida ha sido la
	# correcta. 
	
	# Comprobamos que la clave indicada sea valida.
	if not answer in answers:
		return
	
	# Comprobamos si la opcion elegida es correcta.
	var correct = Global.race_questions[Global.current_race_question][answer][1]
	
	# Si es correcta, procedemos a ejecutar el sonido 
	# de opcion correcta, esperamos a que termine e iniciamos
	# el procedimiento de cambio de pregunta.
	if correct:
		#$CorrectSound.play()
		#yield($CorrectSound, "finished")
		print("Mereces avanzar mas rapido")
		$Player.acceleration=acceleration_player
		next_question()
	else:
		print("Ups, incorrecta.")
		
	
	
	
func next_question():
	# Avanzamos en las preguntas
	Global.current_race_question+=1
	print("Correctas:", Global.current_race_question)
	# Comprobamos si era la ultima pregunta disponible o no.
	if Global.current_race_question >= Global.num_race_questions:
		# Si era la ultima pregunta disponible, reseteamos la pregunta actual
		# para el siguiente juego.
		Global.current_race_question=0
		# Cambiamos a la escena final.
		#var _ret = get_tree().change_scene("res://minigames/labyrinthofrule3/ui/EndScreenLR3.tscn")
		$CanvasLayer/HUDFR/Panel/HBoxContainer/QuestionMargin.visible=false
		$CanvasLayer/HUDFR/Panel/HBoxContainer/EndQuestions.visible=true
	else:
		# Si no es la ultima pregunta, significa que qun hay preguntas.
		# Mostramos la siguiente pregunta al usuario
		set_question_hud()
