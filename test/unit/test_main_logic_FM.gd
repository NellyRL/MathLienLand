extends 'res://addons/gut/test.gd'

var MainScript = load("res://minigames/functionmemory/levels/Level0FM.gd")

var _level = null

func before_each():
	_level = MainScript.new()

func after_each():
	if _level.deck != null and _level.deck.size()>0:
		for card in _level.deck:
			card.free()
		
	_level.free()
	

func test_fill_deck():
	_level.deck = Array()
	
	_level.fillDeck()
	
	assert_eq(_level.deck.size(), 10)
	var contador = 0
	for i in range(1, 3):
		for j in range(1, 6):
			assert_eq(_level.deck[contador].suit, i)
			assert_eq(_level.deck[contador].value, j)
			contador += 1
