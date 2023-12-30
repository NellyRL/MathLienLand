extends "res://minigames/endlessrunner/general/ScrollMovement.gd"

#Se llama para establecer los movimientos y procesos fisicos del nodo
func _physics_process(delta):
	move()

#Se llama para liberar el nodo cuando entra en contacto con otro cuerpo
func pickup():
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
