extends 'res://addons/gut/test.gd'

var MainScript = load("res://minigames/dividinghills/levels/Level0DH.gd")
var Cloud = load("res://minigames/dividinghills/levels/Clouds.gd")

var _level = null
var _cloud = null

func before_each():
	_level = MainScript.new()
	_cloud = Cloud.new()

func after_each():
	_level.free()
	_cloud.free()

func test_set_divisibility_criteria_question():
	
	_level.set_divisibility_criteria_question()
	
	var question = _level.current_question
	
	assert_eq(question["type"], 0)
	#question["text"] = "Is " + str(question_num) + " divisible by\n" + str(chosen_num) + "?"
	var texto:String = question["text"]
	var parts = texto.split(" ")
	assert_eq(parts.size(), 4)
	assert_eq(parts[0], "Is")
	assert_eq(parts[2], "divisible")
	
	var question_number = parts[1].to_int()
	
	parts = parts[3].split("\n")
	assert_eq(parts.size(), 2)
	texto = parts[1].trim_suffix("?")
	
	var divisor = texto.to_int()
	var correct
	if question_number % divisor == 0:
		correct = 1
	else:
		correct = 0
	
	assert_eq(question["correct_answer"], correct)

func test_euclidean_gcd():
	var test_cases = { 
		[9  , 15] : 3,
		[9  , 27] : 9,
		[222, 333]: 111,
		[180, 225]: 45,
		[123, 321]: 3,
		[260, 980]: 20
	}
	test_cases.keys()
	
	for case in test_cases.keys():
		assert_eq(_level.euclidean_gcd(case[0], case[1]), test_cases[case])
		assert_eq(_level.euclidean_gcd(case[1], case[0]), test_cases[case])

func test_set_gcd_question():
	_level.set_gcd_question()
	
	var question = _level.current_question
	
	assert_eq(question["type"], 1)
	#question["text"] = "Select the gcd of " + str(first_number) + " and " + str(second_number) + ":"
	var texto:String = question["text"]
	var parts = texto.split(" ")
	assert_eq(parts.size(), 7)
	assert_eq(parts[0], "Select")
	assert_eq(parts[1], "the")
	assert_eq(parts[2], "gcd")
	assert_eq(parts[3], "of")
	assert_eq(parts[5], "and")
	
	var question_first_number:int  = parts[4].to_int()
	var question_second_number:int = parts[6].trim_suffix(":").to_int()
	
	var correct = _level.euclidean_gcd(question_first_number, question_second_number)
	
	assert_eq(question["correct_answer"], correct)
	
func test_cloud():
	_cloud.cloud_speed = 40
	_cloud.motion_offset.x = 0
	_cloud._process(20.0)
	assert_eq(_cloud.motion_offset.x, 800.0)
