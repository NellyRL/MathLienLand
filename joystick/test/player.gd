extends Sprite

export (NodePath) var joystickLeftPath
onready var joystickLeft : VirtualJoystick = get_node(joystickLeftPath)

export var speed : float = 100

export (NodePath) var joystickRightPath
onready var joystickRight : VirtualJoystick = get_node(joystickRightPath)

func _process(delta: float) -> void:
#	# Movement using the joystick output:
#	if joystickLeft and joystickLeft.is_pressed():
#		position += joystickLeft.get_output() * speed * delta
	
	# Movement using Input functions:
	var dir = Vector2.ZERO
		# Para ello, usamos la comprobacion habitual,
		# de tal forma que se permite el presionado de
		# varias teclas a la vez y se empleen la logica
		# de los ejes cartesianos (x positiva, derecha
		# y x negativa izquierda, lo mismo para arriba
		# y abajo con y)
	if Input.is_action_pressed("right"):
		dir.x += 1
	if Input.is_action_pressed("down"):
		dir.y += 1
	if Input.is_action_pressed("left"):
		dir.x -= 1
	if Input.is_action_pressed("up"):
		dir.y -= 1
	position += dir * speed * delta
	
	# Rotation:
	if joystickRight and joystickRight.is_pressed():
		rotation = joystickRight.get_output().angle()
