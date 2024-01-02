# ----------------- Codigo Base obtenido de: -----------------
# 		https://github.com/CVelasco2/Math-Endless-Runner
extends "res://minigames/endlessrunner/general/ScrollMovement.gd"

#Se llama para establecer los movimientos y procesos fisicos del nodo
func _physics_process(_delta):
	move()

#Se llama para liberar el nodo cuando entra en contacto con otro cuerpo
func pickup():
	queue_free()

#Se llama para liberar el nodo cuando sale de la pantalla
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
