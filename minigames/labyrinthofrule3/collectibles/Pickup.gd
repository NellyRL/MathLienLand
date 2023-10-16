extends Area2D

# Texturas que tendran los coleccionables
var textures = {'answerA': 'res://assets/maze/Other/flagBlue.png',
				'answerB': 'res://assets/maze/Other/flagGreen.png',
				'answerC': 'res://assets/maze/Other/flagRed.png',
				'answerD': 'res://assets/maze/Other/flagYellow.png'}

# Obtenido del libro Godot Engine Game Development Projects
# TODO: Mejorar si es posible
# Tipo de coleccionable que es.
var type

func _ready():
	# Establecemos la animacion de los coleccionables. Basicamente
	# van a crecer en tamanyo a la vez que se "desvanecen"
	$Tween.interpolate_property($Sprite, 'scale', Vector2(1, 1),
	Vector2(3, 3), 0.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	
	$Tween.interpolate_property($Sprite, 'modulate',
	Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.5,
	Tween.TRANS_QUAD, Tween.EASE_IN_OUT)


func init(_type, pos):
	# Para inicializar un coleccionable vamos a cargar su textura
	# segun su tipo y vamos a asignar el tipo y la posicion indicadas
	# a la instancia creada.
	$Sprite.texture = load(textures[_type])
	type = _type
	position = pos


func pickup():
	# Cuando se recoja el coleccionable vamos a deshabilitar
	# que sea colisionable para que no se recoja dos veces y
	# procederemos a ejecutar la animacion asociada.
	$CollisionShape2D.set_deferred("disabled", true)
	$Tween.start()

func _on_Tween_completed(_object, _key):
	# Una vez termine la animacion liberamos la instancia.
	queue_free()
