extends RigidBody2D

var wheels = []

export (int) var speed = 60000
export (int) var max_angular_speed = 40
var project_fps
var fuel = 100
signal game_over

func _input(event):
	if event.is_action_pressed('up'):
		$Camera2D.zoom -= Vector2(0.1, 0.1)
	if event.is_action_pressed('down'):
		$Camera2D.zoom += Vector2(0.1, 0.1)

func _ready():
	# Para que esto funcione en todo el proyecto no debe 
	# haber mas elementos pertenecientes a este grupo
	wheels = get_tree().get_nodes_in_group("dhwheel")
	# FPS del proyecto
	project_fps = ProjectSettings.get_setting("physics/common/physics_fps")
	

func _physics_process(delta):
	if get_parent().can_move:
		if fuel > 0 and rotation_degrees <= 90 and rotation_degrees>=-90:
			$GameOverTimer.stop()
			if Input.is_action_pressed("right"):
				use_fuel(delta)
				for wheel in wheels:
					if wheel.angular_velocity < max_angular_speed:
						wheel.apply_torque_impulse(speed * delta * project_fps)

			if Input.is_action_pressed("left"):
				use_fuel(delta)
				for wheel in wheels:
					if wheel.angular_velocity > -max_angular_speed:
						wheel.apply_torque_impulse(-speed * delta * project_fps)
			print(fuel)
		else:
			if $GameOverTimer.is_stopped():
				$GameOverTimer.start()

func refuel():
	fuel = 100

func use_fuel(delta):
	fuel -= 20*delta
	fuel = clamp(fuel, 0, 100)


func _on_GameOverTimer_timeout():
	emit_signal("game_over")
