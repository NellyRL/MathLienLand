extends Control

# Obtenemos el panel de informacion para 
# hacerlo visible o invisible segun corresponda.
onready var infopanel = $CanvasLayer/MarginContainer/Panel

func _enter_tree():
	# Cada vez que entre la escena al arbol del proyecto de nuevo,
	# tenemos que comprobar que la musica tocada sea la correcta.
	MusicController.set_music()

func _on_Info_pressed():
	# Cuando se presione el boton de informacion
	# mostraremos el panel con las instrucciones del juego
	if not infopanel.visible:
		infopanel.visible = true

func _on_Close_pressed():
	# Cuando se presione el boton Close en el panel informativo
	# haremos invisible dicho panel
	if infopanel.visible:
		infopanel.visible = false

