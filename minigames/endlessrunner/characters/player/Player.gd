extends KinematicBody2D


onready var animation = $AnimatedSprite
const JUMP_VELOCITY = -500.0
export (int) var weight = 1
var velocity = Vector2.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#Se enumeran los estados del jugador
enum {
	JUMP,
	RUN,
	IDLE
}

var state = RUN

# ---------------Senyales del juego-----------------------
signal killplayer
signal reward
# ---------------- FIN -----------------------------------


func _ready():
	#Se conecta con la señal indicada
	# Signals.connect("killplayer", killplayer)
	pass

#Se establece el comportamiento del jugador
func _physics_process(delta):
	#print(is_on_floor())
	if get_parent().get_parent().can_move:
		match state:
			#El jugador está corriendo/andando
			RUN:
				animation.play("Walk")
			#El  jugador salta
			JUMP:
				velocity.y = JUMP_VELOCITY
				animation.play("Jump")
				state = IDLE
			IDLE:
				pass
				
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta * weight
		
		var _ret = move_and_slide(velocity, Vector2(0, -1))
		
		#Si está en el suelo, se establece el estado RUN
		if is_on_floor():
			state = RUN
			velocity.y = 0

#Se establece el comportamiento si se presiona un botón
func _input(event):
	
	#Si se presiona el espacio y el jugador no está ya saltando
	if event.is_action_pressed("ui_accept") and is_on_floor() \
	and get_parent().get_parent().can_move:
		#Se emite la señal correspondiente para que el jugador salte
		#Signals.emit_signal("playerjump")
		$JumpSound.play()
		#Se establece el estado JUMP
		state = JUMP



#Si el jugador muere, se liberan los recursos
func killplayer():
	queue_free()


func _on_ContactArea_area_entered(area):
	if area.is_in_group("enemies"):
		print("ENEMIGO COLISIONADO")
		if area.get_parent().has_method("hurtplayer"):
			area.get_parent().hurtplayer()
		emit_signal("killplayer")

	if area.is_in_group("pickups"):
		print("MONEDA COLISIONADA")
		if area.get_parent().has_method("pickup"):
			area.get_parent().pickup()
		emit_signal("reward")
			