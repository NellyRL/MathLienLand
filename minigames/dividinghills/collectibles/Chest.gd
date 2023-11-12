extends Area2D
var picked_up = false
signal chest_collected 

func _on_Chest_body_entered(body):
	#print("Hola")
	if body.is_in_group("dhplayer") and picked_up == false:
		picked_up = true
		$AnimationPlayer.play("pickup")
		$CollisionShape2D.set_deferred("disabled", true)
		emit_signal("chest_collected")


func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
