extends Node2D

export (int) var scroll_speed = 4

#Se establece la velocidad de movimiento del personaje
func move():
	self.position.x -= scroll_speed
