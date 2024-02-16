extends 'res://addons/gut/test.gd'

var MainScript = load("res://minigames/decimalsystemmeteors/levels/Level0DSM.gd")

var _level = null

func before_each():
	_level = MainScript.new()

func after_each():
	_level.free()

func test_add_superindex():
	assert_has_method(_level, "add_superindex")
	var text = "mm"
	var result = _level.add_superindex(text, 2)
	var expected = "mm[sup][b]2[/b][/sup]"
	assert_eq(result, expected)
