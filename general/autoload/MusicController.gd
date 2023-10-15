extends Node

var menu_music_is_playing = false
var lab_music_is_playing = false
var victory_loop_is_playing = false

# The scenes whithout identifier prefix are from the labyrinth minigame
var scenes_names = ["MainMenu", "MinigameSelectScene", "StartScreen", "EndScreen", "Level0"]

func play_menu_music():
	if not menu_music_is_playing:
		$MenuMusic.play()
		menu_music_is_playing = true
	
func stop_menu_music():
	if menu_music_is_playing:
		$MenuMusic.stop()
		menu_music_is_playing = false

func play_lab_music():
	if not lab_music_is_playing:
		$LabyrinthMusic.play()
		lab_music_is_playing = true
	
func stop_lab_music():
	if lab_music_is_playing:
		$LabyrinthMusic.stop()
		lab_music_is_playing = false
		
func play_vict_music():
	if not victory_loop_is_playing:
		$VictoryLoop.play()
		victory_loop_is_playing = true
	
func stop_vict_music():
	if victory_loop_is_playing:
		$VictoryLoop.stop()
		victory_loop_is_playing = false

func set_music():
	var name = get_tree().current_scene.name
	match name:
		"MainMenu", "MinigameSelectScene":
			stop_lab_music()
			stop_vict_music()
			play_menu_music()
		"StartScreen", "Level0":
			stop_menu_music()
			stop_vict_music()
			play_lab_music()
		"EndScreen":
			stop_menu_music()
			stop_lab_music()
			play_vict_music()
