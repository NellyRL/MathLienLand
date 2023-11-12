extends RigidBody2D
var picked_up = false


func _on_Chest_body_entered(body):
	if body.is_in_group("player") and picked_up == false:
		picked_up = true
		$AnimationPlayer.play("pickup")
		$CollisionShape2D.disabled = true


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
