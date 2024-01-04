# ------------------- Codigo Fuente Obtenido de: -----------
#			https://github.com/benbishopnz/godot-credits
extends Node2D

const section_time := 1.75
const line_time := 0.7
const base_speed := 75.0
const speed_up_multiplier := 10.0
const title_color := Color.lime

var scroll_speed := base_speed
var speed_up := false

onready var line := $CanvasLayer/CreditsContainer/Line
var started := false
var finished := false

var section
var section_next := true
var section_timer := 0.0
var line_timer := 0.0
var curr_line := 0
var lines := []
var title_start = "[center][rainbow][b][wave amp=30 freq=5]"
var title_end = "[/wave][/b][/rainbow][/center]"
var line_start = "[center][wave amp=20 freq=3]\n"
var line_end = "[/wave][/center]"



var credits = [
	[
		"A game by Universidad Autonoma de Madrid"
	],[
		"Started By",
		"Carla Velasco"
	],[
		"Continued By",
		"Nelly Ramos"
	],[
		"Guided By",
		"Cristina Alonso"
	],[
		"Music and Sound Effects Obtained From"
	],[
		"Freesounds.org Users",
		"DZeDeNZ",
		"SieuAmThanh",
		"Geoff-Bremner-Audio",
		"Seth_Makes_Sounds",
		"MATRIXXX_",
		"MrLindstrom",
		"FFKoenigsegg20012017",
		"mrrap4food",
		"Rolly-SFX",
		"Raclure",
		"GabrielAraujo",
		"Fantozzi",
		"edtijo"
	],[
		"And From OpenGameArt.org Users",
		"cynicmusic",
		"pauliuw",
		"congusbongus",
		"Wolfgang_",
		"Pro Sensory"
	],[
		"With Art By",
		"kenney.nl",
		"iconduck.com",
		"hippo from opengameart.org",
		"azagaya from itch.io",
		"Steampunkdemon from itch.io"
	],[
		"Project implemented Thanks to Numerous Youtube\nTutorials Featured By",
		"Aarimous",
		"Amos Dsouza",
		"rayuse rp",
		"KidsCanCode",
		"space nomad",
		"HeartBeast",
		"pencilflip",
		"GDQuest",
		"Rafa Fiedo",
		"Generalist Programmer",
		"Clear Code",
		"BitBirdy",
		"Nevoski",
		"Z53 INCOMING",
		"Rungeon",
		"LucyLavend",
		"Patrick Morrow",
		"Juan Chade",
		"CyberPotato",
		"And More"
	],[
		"Testers",
		"Kids and teachers from ESO",
	],[
		"Tools used",
		"Developed with Godot Engine",
		"https://godotengine.org/license",
		"",
		"Art Adjusted using ILoveImg and PineTools",
		"https://www.iloveimg.com/",
		"https://pinetools.com/es/",
		"",
	],[
		"Credit Screen By",
		"Ben Bishop (benbishopnz) from GitHub",
		"",
	],[
		"Special thanks to",
		"My parents",
		"",
		"My entire family for supporting me",
		"",
		"My tutor, for giving me this opportunity",
		"",
		"My teachers for getting me to love education",
		"",
		"Godot and Reddit Community for being a \nsupport in this journey",
		"",
		"My college friends, for always being there",
		"",
		"And most of all to God, for always guiding me",
	],[
		"Thank you for using this project!"
	]
]


func _process(delta):
	scroll_speed = base_speed * delta
	
	if section_next:
		section_timer += delta * speed_up_multiplier if speed_up else delta
		if section_timer >= section_time:
			section_timer -= section_time
			
			if credits.size() > 0:
				started = true
				section = credits.pop_front()
				curr_line = 0
				add_line()
	
	else:
		line_timer += delta * speed_up_multiplier if speed_up else delta
		if line_timer >= line_time:
			line_timer -= line_time
			add_line()
	
	if speed_up:
		scroll_speed *= speed_up_multiplier
	
	if lines.size() > 0:
		for l in lines:
			l.rect_position.y -= scroll_speed
			var font = l.get("custom_fonts/bold_font")
			var line_height = font.get_height()
			if l.rect_position.y < -line_height:
				lines.erase(l)
				l.queue_free()
	elif started:
		finish()


func finish():
	if not finished:
		finished = true
		# NOTE: This is called when the credits finish
		# - Hook up your code to return to the relevant scene here, eg...
		var _ret = get_tree().change_scene("res://mainmenu/MainMenu.tscn")


func add_line():
	var new_line = line.duplicate()
	#new_line.bbcode_text = "[center]" + section.pop_front() + "[/center]"
	
	if curr_line == 0:
		new_line.bbcode_text = title_start + section.pop_front() + title_end
		#new_line.add_color_override("font_color", title_color)
	else:
		new_line.bbcode_text = line_start + section.pop_front() + line_end
	lines.append(new_line)
	$CanvasLayer/CreditsContainer.add_child(new_line)
	
	if section.size() > 0:
		curr_line += 1
		section_next = false
	else:
		section_next = true


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		finish()
	if event.is_action_pressed("ui_down") and !event.is_echo():
		speed_up = true
	if event.is_action_released("ui_down") and !event.is_echo():
		speed_up = false

