# ----------------- Codigo Base obtenido de: -----------------
# 			https://github.com/CVelasco2/Function-Memory
extends TextureButton

class_name Card

#Se definen las variables necesarias
var suit
var value
var face
var cardBack = preload("res://assets/memory_cards/cardBack_blue2.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	#Se establecen los valores de tamaños de las cartas
	set_h_size_flags(SIZE_EXPAND_FILL)
	set_v_size_flags(SIZE_EXPAND_FILL)
	#set_ignore_texture_size(true)
	expand = true
	set_stretch_mode(TextureButton.STRETCH_KEEP_ASPECT_CENTERED)

func _init(s, v):
	#Se establecen los valores de la carta, y se cargan la imagenes
	suit = s
	value = v
	face = load("res://assets/memory_cards/card-" + str(suit) + "-" + str(value) + ".png")
	texture_normal = cardBack
	var _ret = connect("pressed", self, "_pressed")

func _pressed():
	#Se llama a la función correspondiente en caso de presionar sobre una carta
	#CardsManager.chooseCard(self)
	if not disabled:
		get_parent().get_parent().chooseCard(self)

func flip():
	#Se cambia la imagen cargada en la carta a la correspondiente al girarla
	get_parent().get_parent().playFlipSound()
	if texture_normal == cardBack:
		texture_normal = face
	else:
		texture_normal = cardBack
