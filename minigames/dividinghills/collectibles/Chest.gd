extends Area2D
var picked_up = false
signal chest_collected 

func _on_Chest_body_entered(body):
	# Si colisionamos con el jugador y aun no se habia
	# recolectado el cofre, indicamos que ahora si ya se
	# ha recolectado, activamos la animacion correspondiente,
	# deshabilitamos la colision y emitimos la senyal correspondiente
	if body.is_in_group("dhplayer") and picked_up == false:
		picked_up = true
		$AnimationPlayer.play("pickup")
		$CollisionShape2D.set_deferred("disabled", true)
		emit_signal("chest_collected")


func _on_AnimationPlayer_animation_finished(_anim_name):
	# Una vez finalizada la animacion, liberamos los 
	# recursos asociados al cofre.
	queue_free()
