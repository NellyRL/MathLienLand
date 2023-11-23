extends ParallaxLayer

# Variable que indica la velocidad a la que
# se mueve la nube
export (float) var cloud_speed = -25.0

func _process(delta):
	# Vamos moviendo la nube segun la velocidad 
	# indicada.
	motion_offset.x += cloud_speed * delta
