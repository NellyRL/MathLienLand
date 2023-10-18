extends Node

# Variables que indican si una pista concreta esta siendo 
# tocada o no
var menu_music_is_playing = false
var lab_music_is_playing = false
var victory_loop_is_playing = false

# Variable de documentacion. Indica las escenas posibles del juego.
var scenes_names = ["MainMenu", "MinigameSelectScene", "StartScreenLR3", "EndScreenLR3", "Level0LR3"]

# Funcion que se asegura que este sonando el tema del menu
func play_menu_music():
	if not menu_music_is_playing:
		$MenuMusic.play()
		menu_music_is_playing = true
	
# Funcion que se asegura que NO este sonando el tema del menu
func stop_menu_music():
	if menu_music_is_playing:
		$MenuMusic.stop()
		menu_music_is_playing = false

# Funcion que se asegura que este sonando el tema del laberinto
func play_lab_music():
	if not lab_music_is_playing:
		$LabyrinthMusic.play()
		lab_music_is_playing = true

# Funcion que se asegura que NO este sonando el tema del laberinto
func stop_lab_music():
	if lab_music_is_playing:
		$LabyrinthMusic.stop()
		lab_music_is_playing = false

# Funcion que se asegura que este sonando el tema de la victoria
func play_vict_music():
	if not victory_loop_is_playing:
		$VictoryLoop.play()
		victory_loop_is_playing = true

# Funcion que se asegura que NO este sonando el tema de la victoria
func stop_vict_music():
	if victory_loop_is_playing:
		$VictoryLoop.stop()
		victory_loop_is_playing = false

# Funcion a ser llamada cuando cada escena entre al arbol del proyecto
# Se encarga de hacer sonal el tema correspondiente en cada momento.
func set_music():
	var name = get_tree().current_scene.name
	#print(name)
	match name:
		"MainMenu", "MinigameSelectScene":
			stop_lab_music()
			stop_vict_music()
			play_menu_music()
		"StartScreenLR3", "Level0LR3":
			stop_menu_music()
			stop_vict_music()
			play_lab_music()
		"EndScreenLR3":
			stop_menu_music()
			stop_lab_music()
			play_vict_music()
		_:
			stop_lab_music()
			stop_menu_music()
			stop_vict_music()
