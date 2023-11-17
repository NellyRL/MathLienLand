extends ParallaxLayer

export (float) var cloud_speed = -25.0

func _process(delta):
	motion_offset.x += cloud_speed * delta
