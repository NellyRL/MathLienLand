extends RigidBody2D
# Velocidad minima con la que se moveran
# los meteoritos
export (float) var lower_speed_limit = 120.0
# Velocidad maxima con la que se moveran
# los meteoritos
export (float) var upper_speed_limit = 200.0
# Inicio y final de las cadenas de los meteoritos
# para garantizar el centrado del texto
var starting_bbcode = "\n[center]"
var ending_bbcode = "[/center]"

# Se ejecutara cada vez que un 
# meteorito se cree correctamente. 
func _ready():
	# Escogemos una animacion aleatoria de entre las existentes.
	var mtypes = $AnimatedSprite.frames.get_animation_names()
	var animation = randi()%mtypes.size() + 1
	# Asignamos la animacion elegida como la actual,
	# de esta forma se podran tener distintos meteoritos.
	$AnimatedSprite.animation = str(animation)
	# Los hacemos girar para dar el efecto espacial.
	$AnimationPlayer.play("default")


func _on_VisibilityNotifier2D_screen_exited():
	# Elimina el objeto de forma segura al final del frame.
	queue_free()
	
func set_text(text):
	# Funcion que establece un texto al meteorito
	$Label.bbcode_text = starting_bbcode + text + ending_bbcode

func trigger_correct_reaction():
	# Funcion a llamar si el jugador
	# colisiona con este meteorito y es
	# parte del grupo de respuestas correctas.
	# En ese caso, sonara el sonido de acierto
	# y se ejecutara la animacion para indicar
	# al jugador su acierto.
	$CorrectSound.play()
	$AnimationPlayer2.play("Correct")

func trigger_wrong_reaction():
	# Funcion a llamar si el jugador
	# colisiona con este meteorito y es
	# parte del grupo de respuestas incorrectas.
	# En ese caso, sonara el sonido de fallo
	# y se ejecutara la animacion para indicar
	# al jugador su fallo.
	$WrongSound.play()
	$AnimationPlayer2.play("Wrong")
