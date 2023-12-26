extends Node

# Variables que indican si una pista concreta esta siendo 
# tocada o no
var menu_music_is_playing = false
var lab_music_is_playing = false
var victory_loop_is_playing = false
var race_music_is_playing = false
var race_vict_music_is_playing = false
var hills_music_is_playing = false
var hills_vict_music_is_playing = false
var meteor_music_is_playing = false
var meteor_vict_music_is_playing = false
var memory_music_is_playing = false

# Variable de documentacion. Indica las escenas posibles del juego.
# var scenes_names = ["MainMenu", "MinigameSelectScene", "StartScreenLR3", "EndScreenLR3", "Level0LR3"]

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

# Funcion que se asegura que este sonando el tema de carreras
func play_race_music():
	if not race_music_is_playing:
		$RaceMusic.play()
		race_music_is_playing = true

# Funcion que se asegura que NO este sonando el tema de carreras
func stop_race_music():
	if race_music_is_playing:
		$RaceMusic.stop()
		race_music_is_playing = false
		
# Funcion que se asegura que este sonando el tema de
# victoria de carreras.
func play_race_vict_music():
	if not race_vict_music_is_playing:
		$RaceVictMusic.play()
		race_vict_music_is_playing = true

# Funcion que se asegura que NO este sonando el tema de carreras
func stop_race_vict_music():
	if race_vict_music_is_playing:
		$RaceVictMusic.stop()
		race_vict_music_is_playing = false
	
# Funcion que se asegura que este sonando el tema de
# hills
func play_hills_music():
	if not hills_music_is_playing:
		$HillsMusic.play()
		hills_music_is_playing = true

# Funcion que se asegura que NO este sonando el tema de carreras
func stop_hills_music():
	if hills_music_is_playing:
		$HillsMusic.stop()
		hills_music_is_playing = false

# Funcion que se asegura que este sonando el tema de
# victoria del juego de colinas
func play_hills_vict_music():
	if not hills_vict_music_is_playing:
		$HillsVictMusic.play()
		hills_vict_music_is_playing = true

# Funcion que se asegura que NO este sonando el tema del juego
# de colinas
func stop_hills_vict_music():
	if hills_vict_music_is_playing:
		$HillsVictMusic.stop()
		hills_vict_music_is_playing = false
		
# Funcion que se asegura que este sonando el tema de
# meteors
func play_meteor_music():
	if not meteor_music_is_playing:
		$MeteorsMusic.play()
		meteor_music_is_playing = true

# Funcion que se asegura que NO este sonando el tema de carreras
func stop_meteor_music():
	if meteor_music_is_playing:
		$MeteorsMusic.stop()
		meteor_music_is_playing = false

# Funcion que se asegura que este sonando el tema de
# victoria de meteors
func play_meteor_vict_music():
	if not meteor_vict_music_is_playing:
		$MeteorsVictMusic.play()
		meteor_vict_music_is_playing = true

# Funcion que se asegura que NO este sonando el tema de meteoritos
func stop_meteor_vict_music():
	if meteor_vict_music_is_playing:
		$MeteorsVictMusic.stop()
		meteor_vict_music_is_playing = false

# Funcion que se asegura que este sonando el tema de
# function memory
func play_memory_music():
	if not memory_music_is_playing:
		$MemoryMusic.play()
		memory_music_is_playing = true

# Funcion que se asegura que NO este sonando el tema de function memory
func stop_memory_music():
	if memory_music_is_playing:
		$MemoryMusic.stop()
		memory_music_is_playing = false

# Funcion a ser llamada cuando cada escena entre al arbol del proyecto
# Se encarga de hacer sonal el tema correspondiente en cada momento.
func set_music():
	var name = get_tree().current_scene.name
	#print(name)
	match name:
		"MainMenu", "MinigameSelectScene":
			stop_lab_music()
			stop_vict_music()
			stop_race_music()
			stop_race_vict_music()
			stop_hills_music()
			stop_hills_vict_music()
			stop_meteor_music()
			stop_meteor_vict_music()
			stop_memory_music()
			play_menu_music()
		"StartScreenLR3", "Level0LR3":
			stop_menu_music()
			stop_vict_music()
			stop_race_music()
			stop_race_vict_music()
			stop_hills_music()
			stop_hills_vict_music()
			stop_meteor_music()
			stop_meteor_vict_music()
			stop_memory_music()
			play_lab_music()
		"EndScreenLR3":
			stop_lab_music()
			stop_menu_music()
			stop_race_music()
			stop_race_vict_music()
			stop_hills_music()
			stop_hills_vict_music()
			stop_meteor_music()
			stop_meteor_vict_music()
			stop_memory_music()
			play_vict_music()
		"StartScreenFR", "Level0FR":
			stop_lab_music()
			stop_menu_music()
			stop_vict_music()
			stop_race_vict_music()
			stop_hills_music()
			stop_hills_vict_music()
			stop_meteor_music()
			stop_meteor_vict_music()
			stop_memory_music()
			play_race_music()
		"EndScreenFR":
			stop_lab_music()
			stop_menu_music()
			stop_vict_music()
			stop_race_music()
			stop_hills_music()
			stop_hills_vict_music()
			stop_meteor_music()
			stop_meteor_vict_music()
			stop_memory_music()
			play_race_vict_music()
		"StartScreenDH", "Level0DH":
			stop_lab_music()
			stop_menu_music()
			stop_vict_music()
			stop_race_music()
			stop_race_vict_music()
			stop_hills_vict_music()
			stop_meteor_music()
			stop_meteor_vict_music()
			stop_memory_music()
			play_hills_music()
		"EndScreenDH":
			stop_lab_music()
			stop_menu_music()
			stop_vict_music()
			stop_race_music()
			stop_race_vict_music()
			stop_hills_music()
			stop_meteor_music()
			stop_meteor_vict_music()
			stop_memory_music()
			play_hills_vict_music()
		"StartScreenDSM", "Level0DSM":
			stop_lab_music()
			stop_menu_music()
			stop_vict_music()
			stop_race_music()
			stop_race_vict_music()
			stop_hills_music()
			stop_hills_vict_music()
			stop_meteor_vict_music()
			stop_memory_music()
			play_meteor_music()
		"EndScreenDSM":
			stop_lab_music()
			stop_menu_music()
			stop_vict_music()
			stop_race_music()
			stop_race_vict_music()
			stop_hills_music()
			stop_meteor_music()
			stop_hills_vict_music()
			stop_meteor_music()
			stop_memory_music()
			play_meteor_vict_music()
		"Level0FM":
			stop_lab_music()
			stop_menu_music()
			stop_vict_music()
			stop_race_music()
			stop_race_vict_music()
			stop_hills_music()
			stop_meteor_music()
			stop_hills_vict_music()
			stop_meteor_music()
			stop_meteor_vict_music()
			play_memory_music()
		"StartScreenFM":
			stop_lab_music()
			stop_vict_music()
			stop_race_music()
			stop_race_vict_music()
			stop_hills_music()
			stop_hills_vict_music()
			stop_meteor_music()
			stop_meteor_vict_music()
			stop_memory_music()
			play_menu_music()
		"EndScreenFM":
			stop_lab_music()
			stop_menu_music()
			stop_race_music()
			stop_race_vict_music()
			stop_hills_music()
			stop_hills_vict_music()
			stop_meteor_music()
			stop_meteor_vict_music()
			stop_memory_music()
			play_vict_music()
		_:
			stop_music()

func stop_music():
	stop_lab_music()
	stop_menu_music()
	stop_vict_music()
	stop_race_music()
	stop_race_vict_music()
	stop_hills_music()
	stop_hills_vict_music()
	stop_meteor_music()
	stop_meteor_vict_music()
	stop_memory_music()
	

# ------------------------ Anyadido desde Codigo Heredado ----------------------


