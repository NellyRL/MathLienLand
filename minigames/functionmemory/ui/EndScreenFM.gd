extends Control
# Establecemos el principio y el final de 
# la cadena a mostrar, para establecer su formato.
var default_start_bbtext = "[center][wave freq=3 ampl=10][color=#FFD700]"
var default_end_bbtext = "[/color][/wave][/center]"

func _enter_tree():
	# Cada vez que entre la escena al arbol del proyecto de nuevo,
	# tenemos que comprobar que la musica tocada sea la correcta.
	MusicController.set_music()
	# Formamos la informacion a mostrar en la pantalla final del minijuego
	var info = $CanvasLayer/MarginContainer/VBoxContainer/PlayerInfo
	# Establecemos el inicio de la cadena en bbcode.
	info.bbcode_text = default_start_bbtext
	# Indicamos los datos de partida
	info.bbcode_text += "You found " + str(Global.memory_score) + " pairs in " + str(Global.total_memory_time) 
	info.bbcode_text += " seconds,\nand flipped " + str(Global.flipped_pairs_number) + " pairs of cards!"
	# Establecemos el final de la cadena en bbcode.
	info.bbcode_text += default_end_bbtext
	
	# Reseteamos las variables globales del minijuego
	Global.memory_score = 0
	Global.total_memory_time = 0
	Global.flipped_pairs_number = 0

func _on_Continue_button_up():
	# Si se presiona continuar, cambiamos de escena
	# Esto se realiza aqui para facilitar el hecho de que continuar
	# implique moverse a distintas escenas segun hayan mas niveles, se
	# este en modo historia, etc.
	var _ret = get_tree().change_scene("res://minigames/functionmemory/ui/StartScreenFM.tscn")


