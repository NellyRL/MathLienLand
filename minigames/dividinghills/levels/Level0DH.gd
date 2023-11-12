extends Node2D

export (int) var num_hills = 6
export (int) var hill_slices = 10
export (int) var hill_height_range = 100
export (PackedScene) var collectible
var hills_texture = preload("res://assets/hills/grass.png")
var criteria_numbers = [2, 3, 4, 5, 6, 9, 10, 11]
var max_multiplicator = 1000
var max_gcd = 25
var current_question = {"type": 0, "text": "", "correct_answer":-1,
						"options":{"A":"", "B":"", "C":"", "D":""}}
var screensize
var hills = Array()
var score = 0
var can_move = true

func _ready():
	randomize()
	# Conectamos las senyales de contestacion
	var _ret
	_ret = $CanvasLayer/HUDDH.connect("hills_answerA", self, "_on_Player_answered_a")
	_ret = $CanvasLayer/HUDDH.connect("hills_answerB", self, "_on_Player_answered_b")
	_ret = $CanvasLayer/HUDDH.connect("hills_answerC", self, "_on_Player_answered_c")
	_ret = $CanvasLayer/HUDDH.connect("hills_answerD", self, "_on_Player_answered_d")
	_ret = $Player.connect("game_over", self, "game_over")
	# Generamos las primeras colinas
	hills = Array()
	screensize = get_viewport().get_visible_rect().size
	
	# Anyadimos una altura extra al starting point desde
	# -hill_height_range hasta hill_height_range.
	var extra_starting_height = -hill_height_range + randi()%(hill_height_range*2)
	
	var start_height = screensize.y * 3/4 + extra_starting_height
	hills.append(Vector2(0, start_height))
	generate_hills()
	set_question()
	
func _process(_delta):
	var target_x = hills[-1].x
	var target_y = hills[-1].y
	if target_x < $Player.position.x + screensize.x*4:
		generate_hills()
		var pickup = collectible.instance()
		pickup.position = Vector2(target_x, target_y-32)
		add_child(pickup)
		var _ret 
		_ret = pickup.connect("chest_collected", self, "pop_up_question")
	
func generate_hills():
	# PREGUNTAR
	# Idea general de creacion procedural del terreno obtenida de
	# https://www.youtube.com/watch?v=QLZa1mjW-YU
	# Cuanto puede ocupar como maximo una colina y su alrededor.
	var hills_width = screensize.x*4 / num_hills
	var hill_slice_width = hills_width / hill_slices
	var starting_point = hills[-1]
	var polygon = PoolVector2Array()
	for new_hill in range(0, num_hills):
		var hill_height = randi()%hill_height_range
		starting_point.y -= hill_height
		for hill_slice in range(hill_slice_width):
			var hill_point = Vector2()
			hill_point.x = starting_point.x + hill_slice * hill_slices + hills_width * new_hill
			hill_point.y = starting_point.y + hill_height * cos(2 * PI/ hill_slice_width * hill_slice)
			#$Line2D.add_point(hill_point)
			hills.append(hill_point)
			polygon.append(hill_point)
		starting_point.y += hill_height
	var shape = CollisionPolygon2D.new()
	#var shape = $StaticBody2D/CollisionPolygon2D
	var hill_grass = Polygon2D.new()
	#var hill_grass = $Polygon2D
	$StaticBody2D.add_child(shape)
	polygon.append(Vector2(hills[-1].x, screensize.y*5))
	polygon.append(Vector2(starting_point.x, screensize.y*5))
	shape.polygon = polygon
	hill_grass.polygon = polygon
	hill_grass.texture = hills_texture
	add_child(hill_grass)

func set_question():
	# Se podrian anyadir mas tipos de preguntas
	# pero yo decidi que estos dos temas son
	# los mas importantes. En un futuro estaria
	# bien anyadir preguntas del mcm, numeros primos
	# etc.
	# Obtenemos los botones.
	var node_a = $CanvasLayer/HUDDH/MarginContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/A
	var node_b = $CanvasLayer/HUDDH/MarginContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/B
	var node_c = $CanvasLayer/HUDDH/MarginContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/C
	var node_d = $CanvasLayer/HUDDH/MarginContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/D
		
	var selector = randi()%2
	if selector == 0:
		set_divisibility_criteria_question()
		node_c.visible = false
		node_d.visible = false
	else:
		set_gcd_question()
		node_c.visible = true
		node_d.visible = true
		node_c.text = current_question["options"]["C"]
		node_d.text = current_question["options"]["D"]
	
	node_a.text = current_question["options"]["A"]
	node_b.text = current_question["options"]["B"]
	var question = $CanvasLayer/HUDDH/MarginContainer/Panel/MarginContainer/VBoxContainer/Question
	question.text = current_question["text"]

func set_divisibility_criteria_question():
	# Seleccionamos aleatoriamente uno de los 
	# elementos cuyos criterios de divisibilidad
	# queremos poner a prueba.
	var nselector = randi()%criteria_numbers.size()
	var chosen_num = criteria_numbers[nselector]
	# Generamos un multiplo de dicho numero
	# Sumamos dos pues no queremos que salga
	# ni el 0 ni el 1 nunca.
	var question_num = chosen_num * (randi()%max_multiplicator + 2)
	# Aleatoreamente vemos si queremos que la 
	# pregunta deba responderse con verdadero 
	# o con falso.
	var aselector = randi()%2
	if aselector == 0:
		# Si queremos que sea falso, sumamos uno
		# al multiplo obtenido de tal forma que
		# ya no sea divisible por chosen_num
		question_num += 1
	current_question["type"] = 0
	current_question["text"] = "Is " + str(question_num) + " divisible by\n" + str(chosen_num) + "?"
	current_question["correct_answer"] = aselector
	current_question["options"]["A"] = "False"
	current_question["options"]["B"] = "True"
	current_question["options"]["C"] = ""
	current_question["options"]["D"] = ""

func set_gcd_question():
	# Obtenemos un numero aleatorio entre 
	# 10 y max_gdc + 10 - 1.
	var gcd = randi()%max_gcd + 10
	# Obtenemos dos numeros distintos y menores que
	# el gcd elegido.
	var a = 1
	var b = 1
	while a%b==0 or b%a==0:
		a = randi()%(gcd - 2) + 2 
		b = a
		while b == a: 
			b = randi()%(gcd - 2) + 2 
	
	var first_number = a*gcd
	var second_number = b*gcd
	
	gcd = gcd * euclidean_gdc(a, b)
	
	var option_set = {gcd:true, a:true, b:true,}
	while option_set.keys().size() < 4:
		#var new_option
		#var new_option = randi()%(gcd - 2) + 2 
		var new_option = randi()%(gcd*2) + 2 
		option_set[new_option]=true
	
	current_question["type"] = 1
	current_question["text"] = "Select the gcd of " + str(first_number) + " and " + str(second_number) + ":"
	current_question["correct_answer"] = gcd
	var option_list =  option_set.keys()
	option_list.shuffle()
	current_question["options"]["A"] = str(option_list[0])
	current_question["options"]["B"] = str(option_list[1])
	current_question["options"]["C"] = str(option_list[2])
	current_question["options"]["D"] = str(option_list[3])

func _on_Player_answered_a():
	disable_player_answer()
	if current_question["type"]==0:
		check_answer(0)
	else:
		check_answer(int(current_question["options"]["A"]))
	
func _on_Player_answered_b():
	disable_player_answer()
	if current_question["type"]==0:
		check_answer(1)
	else:
		check_answer(int(current_question["options"]["B"]))
	
func _on_Player_answered_c():
	disable_player_answer()
	check_answer(int(current_question["options"]["C"]))

func _on_Player_answered_d():
	disable_player_answer()
	check_answer(int(current_question["options"]["D"]))

func check_answer(answer):
	var restart_timer = false
	if !$Player/GameOverTimer.is_stopped():
		restart_timer = true
		$Player/GameOverTimer.stop()

	var feed_text
	if answer == current_question["correct_answer"]:
		feed_text = "Correct!! Well done!! \nYou got 10 additional coins"
		score += 10
		$Player.refuel()
		print(score)
	else:
		feed_text = "Ups, wrong answer!"
	
	var feed_panel = $CanvasLayer/HUDDH/MarginContainer/Panel2/MarginContainer/VBoxContainer/Feedback
	feed_panel.text = feed_text
	$CanvasLayer/HUDDH/MarginContainer/Panel2.visible = true
	set_question()
	enable_player_answer()
	yield($CanvasLayer/HUDDH, "continue_pressed")
	$CanvasLayer/HUDDH/MarginContainer/Panel2.visible = false
	$CanvasLayer/HUDDH/MarginContainer/Panel.visible = false
	can_move = true
	if restart_timer:
		$Player/GameOverTimer.start()

func disable_player_answer():
	$CanvasLayer/HUDDH/MarginContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/A.disabled = true
	$CanvasLayer/HUDDH/MarginContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/B.disabled = true
	$CanvasLayer/HUDDH/MarginContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/C.disabled = true
	$CanvasLayer/HUDDH/MarginContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/D.disabled = true

func enable_player_answer():
	$CanvasLayer/HUDDH/MarginContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/A.disabled = false
	$CanvasLayer/HUDDH/MarginContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/B.disabled = false
	$CanvasLayer/HUDDH/MarginContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/C.disabled = false
	$CanvasLayer/HUDDH/MarginContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/D.disabled = false

func euclidean_gdc(n1, n2):
	var aux
	while n2!=0:
		aux = n2
		n2 = n1%n2
		n1 = aux
	return n1

func pop_up_question():
	can_move = false
	$CanvasLayer/HUDDH/MarginContainer/Panel.visible = true

func game_over():
	print("Game over!")
