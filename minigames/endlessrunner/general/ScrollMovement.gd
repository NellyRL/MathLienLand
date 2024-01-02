# ----------------- Codigo Base obtenido de: -----------------
# 		https://github.com/CVelasco2/Math-Endless-Runner
extends Node2D

# Velocidad de movimiento del nodo
export (int) var scroll_speed = 4

#Se establece la velocidad de movimiento del personaje
# u objeto
func move():
	self.position.x -= scroll_speed
