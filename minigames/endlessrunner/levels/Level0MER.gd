extends Node2D

export (PackedScene) var enemy_scene
export (PackedScene) var collectible_scene
export (float) var time_btwn_enemies_decrement = 0.1
export (float) var minimum_time_btwn_enemies = 0.1
export (float) var reward_time_bonus = 1

onready var coin_starting_pos = $GameLayer/CoinsSpawningPoint.position
onready var enemies_starting_pos = $GameLayer/EnemiesSpawningPoint.position

var can_move = true

func _ready():
	MusicController.set_music()
	
	randomize()
	
	$GameLayer/Timer.start()
	$GameLayer/CoinsTimer.start()
	$GameLayer/EnemiesTimer.start()
	$GameLayer/DifficultyTimer.start()
	var _ret = $GameLayer/Player.connect("reward", self, "rewardPlayer")
	_ret = $GameLayer/Player.connect("killplayer", self, "newOperation")
	Global.total_runner_time = 0
	Global.runner_score = 0
	Global.ncorrect_runner = 0
	
	_ret = $GameLayer/Operation.connect("continuegame", self, "continue_game")
	_ret = $GameLayer/Operation.connect("gameover", self, "game_over")

func _on_Timer_timeout():
	Global.total_runner_time += 1
	$HUDLayer/HUDMER.set_time(Global.total_runner_time)


func _on_EnemiesTimer_timeout():
	var new_enemy = enemy_scene.instance()
	new_enemy.position = enemies_starting_pos
	$GameLayer.add_child(new_enemy)

func _on_CoinsTimer_timeout():
	var new_coin = collectible_scene.instance()
	new_coin.position = coin_starting_pos
	$GameLayer.add_child(new_coin)

func rewardPlayer():
	$GameLayer/PickUpSound.play()
	Global.runner_score += 1
	$HUDLayer/HUDMER.set_score(Global.runner_score)

func newOperation():
	can_move = false
	$GameLayer/PlayerHurt.play()
	$GameLayer/Player.visible = false
	$GameLayer/Operation.visible = true
	$GameLayer/Operation/MarginContainer/Panel/Answer.grab_focus()
	# Limpiamos la escena del minijuego
	$GameLayer/CoinsTimer.stop()
	$GameLayer/EnemiesTimer.stop()
	$GameLayer/DifficultyTimer.stop()
	get_tree().call_group("collidable", "queue_free")
	
	
func continue_game():
	Global.ncorrect_runner += 1 
	can_move = true
	$GameLayer/Player.visible = true
	$GameLayer/Operation.visible = false
	# Limpiamos la escena del minijuego
	$GameLayer/CoinsTimer.start()
	$GameLayer/EnemiesTimer.start()
	$GameLayer/DifficultyTimer.start()
	$GameLayer/EnemiesTimer.wait_time += reward_time_bonus
	
	
func game_over():
	var _ret = get_tree().change_scene("res://minigames/endlessrunner/ui/EndScreenMER.tscn")


func _on_DifficultyTimer_timeout():
	var actual_enemy_wait_time = $GameLayer/EnemiesTimer.wait_time
	if actual_enemy_wait_time - time_btwn_enemies_decrement > minimum_time_btwn_enemies: 
		$GameLayer/EnemiesTimer.wait_time -= time_btwn_enemies_decrement
	else:
		$GameLayer/EnemiesTimer.wait_time = minimum_time_btwn_enemies
		$GameLayer/DifficultyTimer.stop()
