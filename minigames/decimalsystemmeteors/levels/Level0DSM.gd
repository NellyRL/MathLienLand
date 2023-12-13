extends Node2D

export (PackedScene) var meteor_scene

func _ready():
	randomize()

func _on_MeteorTimer_timeout():
	#print("Estoy aca")
	# Idea plenamente obtenida de:
	# https://www.youtube.com/watch?v=TKpTvpeHh3U
	$MeteorPath/PathFollow2D.set_unit_offset(randf())
	
	var meteor = meteor_scene.instance()
	$CanvasLayer.add_child(meteor)
	#print(meteor)
	
	meteor.position = $MeteorPath/PathFollow2D.position
	#print(meteor.position, meteor.visible)
	var meteor_dir = $MeteorPath/PathFollow2D.rotation + PI/2
	meteor_dir += rand_range(-PI/5, PI/5)
	meteor.rotation = meteor_dir
	
	var velocity = Vector2(rand_range(meteor.lower_speed_limit, meteor.upper_speed_limit), 0)
	meteor.linear_velocity = velocity.rotated(meteor_dir)
	
	var random_number = randi()%10
	meteor.set_text(str(random_number))
	if random_number == 0:
		meteor.add_to_group("correct")
	else:
		meteor.add_to_group("wrong")
	#print(meteor)
	#print("Estoy aca2")
		
	
	
