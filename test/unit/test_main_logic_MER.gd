extends 'res://addons/gut/test.gd'

var MainScript = load("res://minigames/endlessrunner/levels/Level0MER.gd")
var ScrollMovement = load("res://minigames/endlessrunner/general/ScrollMovement.gd")
var MathEngine = load("res://minigames/endlessrunner/mathengine/Operation.gd")


var _level = null
var _movement = null
var _math_engine = null

func before_each():
	_level = MainScript.new()
	_movement = ScrollMovement.new()
	_math_engine = MathEngine.new()

func after_each():
	_level.free()
	_movement.free()
	_math_engine.free()

	
func test_movement():
	_movement.scroll_speed = 40
	_movement.position.x = 0
	_movement.move()
	assert_eq(_movement.position.x, -40.0)

func test_get_operand():
	var result = _math_engine.operand()
	
	assert_between(result, 10, 99)

func test_get_multiplication_operand():
	var result = _math_engine.multiplicationOperand()
	
	assert_between(result, 0, 9)
	
func test_get_operator():
	var result = _math_engine.get_operator()
	
	assert_between(result, 0, 2)
