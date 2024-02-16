extends 'res://addons/gut/test.gd'

var Player_DSM  = load("res://minigames/decimalsystemmeteors/characters/player/Player.gd")
var Player_DH   = load("res://minigames/dividinghills/characters/player/Player.gd")
var Player_MER  = load("res://minigames/endlessrunner/characters/player/Player.gd")
var Player_FR   = load("res://minigames/fractionrace/characters/Character.gd")
var Player_LRO3 = load("res://minigames/labyrinthofrule3/characters/player/Player.gd")

var _player_DSM  = null
var _player_DH   = null
var _player_MER  = null
var _player_FR   = null
var _player_LRO3 = null

var _double_DH = null

func before_each() :
	_player_DSM  = Player_DSM.new()
	_player_DH   = Player_DH.new()
	_player_MER  = Player_MER.new()
	_player_FR   = Player_FR.new()
	_player_LRO3 = Player_LRO3.new()
	
	var Double_level_DH = double("res://minigames/dividinghills/levels/Level0DH.tscn")
	_double_DH = Double_level_DH.instance()
	_double_DH.add_child(_player_DH)
	stub(_double_DH, "update_fuel_HUD").to_return(0)

func after_each() :
	_player_DSM.free()
	_player_DH.free()
	_player_MER.free()
	_player_FR.free()
	_player_LRO3.free()

func test_Player_signals() :
	# Comprobamos que las distintas implementaciones
	# de los jugadores tengan las senyales necesarias.
	assert_has_signal(_player_DSM, "correct_answer")
	assert_has_signal(_player_DSM, "wrong_answer")
	assert_has_signal(_player_DH, "game_over")
	assert_has_signal(_player_MER, "killplayer")
	assert_has_signal(_player_MER, "reward")
	assert_has_signal(_player_LRO3, "labyrinth_moved")
	assert_has_signal(_player_LRO3, "labyrinth_dead")
	assert_has_signal(_player_LRO3, "labyrinth_answerA")
	assert_has_signal(_player_LRO3, "labyrinth_answerB")
	assert_has_signal(_player_LRO3, "labyrinth_answerC")
	assert_has_signal(_player_LRO3, "labyrinth_answerD")

func test_Player_DH_refuel():
	_player_DH.fuel = 10
	_player_DH.refuel()
	assert_eq(_player_DH.fuel, 100)

func test_Player_DH_use_fuel_normal():
	_player_DH.use_fuel(4)
	assert_eq(_player_DH.fuel, 20)

func test_Player_DH_use_fuel_under_minimun():
	_player_DH.fuel = 100
	_player_DH.use_fuel(20)
	assert_eq(_player_DH.fuel, 0)

func test_Player_DH_use_fuel_above_maximum():
	_player_DH.fuel = 100
	_player_DH.use_fuel(-20)
	assert_eq(_player_DH.fuel, 100)

func test_Player_DH_emit_game_over_signal():
	watch_signals(_player_DH)
	_player_DH._on_GameOverTimer_timeout()
	assert_signal_emitted(_player_DH, "game_over")
