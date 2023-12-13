extends Control
# Establecemos el principio y el final de 
# la cadena a mostrar, para establecer su formato.
var default_start_bbtext = "[center][wave freq=3 ampl=10][color=#FFD700]"
var default_end_bbtext = "[/color][/wave][/center]"

func _enter_tree():
	# Cada vez que entre la escena al arbol del proyecto de nuevo,
	# tenemos que comprobar que la musica tocada sea la correcta.
	MusicController.set_music()	

func _on_Continue_button_up():
	# Si se presiona continuar, cambiamos de escena
	# Esto se realiza aqui para facilitar el hecho de que continuar
	# implique moverse a distintas escenas segun hayan mas niveles, se
	# este en modo historia, etc.
	var _ret = get_tree().change_scene("res://minigames/decimalsystemmeteors/ui/StartScreenDSM.tscn")


