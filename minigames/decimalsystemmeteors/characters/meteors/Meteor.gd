extends RigidBody2D

export var lower_speed_limit = 100.0
export var upper_speed_limit = 200.0

# Se ejecutara cada vez que un 
# meteorito se cree correctamente. 
func _ready():
	
	var mtypes = $AnimatedSprite.frames.get_animation_names()
	var animation = randi()%mtypes.size() + 1
	
	$AnimatedSprite.animation = str(animation)
	$AnimationPlayer.play("default")


func _on_VisibilityNotifier2D_screen_exited():
	# Elimina el objeto de forma segura al final del frame.
	queue_free()
	
func set_text(text):
	$Label.text = text
