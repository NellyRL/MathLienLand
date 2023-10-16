extends Node
# Variable que contiene las preguntas posibles
var labyrinth_questions = []
# Variable que indica que cuestion debe ser propuesta
var current_labyrinth_question = 0
# Maximo de preguntas disponibles
var num_labyrinth_questions = 5
# Tiempo total que el usuario ha jugado.
var total_labyrinth_time = 0

# Rellenamos las preguntas con la bateria elegida
func _ready():
	fill_labyrinth_questions()

func fill_labyrinth_questions():
	var question1 = {}
	
	question1["question"] = "If 10cm of a map are 750m in reality, how many meters\n are 13cm in the map?"
	question1["answerA"] = ["1000m", false]
	question1["answerB"] = ["950m", true]
	question1["answerC"] = ["5000m", false]
	question1["answerD"] = ["13m", false]
	question1["explanation"] = ["res://assets/lab_explanationcards/0.png"]
	
	var question2 = {}
	
	question2["question"] = "If 8 workers can build a house in 20 days, how many\n days are they going to need with 2 additional workers?"
	question2["answerA"] = ["16 days", true]
	question2["answerB"] = ["10 days", false]
	question2["answerC"] = ["1 day", false]
	question2["answerD"] = ["100 days", false]
	question2["explanation"] = ["res://assets/lab_explanationcards/1.png"]
	
	var question3 = {}
	
	question3["question"] = "If we need 3 mathaliens to defeat 6 slimes, how many\n mathaliens do we need to defeat 12 slimes?"
	question3["answerA"] = ["9", false]
	question3["answerB"] = ["4", false]
	question3["answerC"] = ["6", true]
	question3["answerD"] = ["13", false]
	question3["explanation"] = ["res://assets/lab_explanationcards/2.png"]
	
	var question4 = {}
	
	question4["question"] = "If 6 people can stay in a hotel 12 days for 792$,\n how much is going to be paid for 15 people during 8 days?"
	question4["answerA"] = ["1400$", false]
	question4["answerB"] = ["0$", false]
	question4["answerC"] = ["1000$", false]
	question4["answerD"] = ["1320$", true]
	question4["explanation"] = ["res://assets/lab_explanationcards/3.png"]
	
	var question5 = {}
	
	question5["question"] = "If we need 20 nurses to take care of 200 patients\n in 5 days, how many nurses do we need to take care of\n 500 patients in 10 days?"
	question5["answerA"] = ["25 nurses", true]
	question5["answerB"] = ["20 nurses", false]
	question5["answerC"] = ["50 nurses", false]
	question5["answerD"] = ["15 nurses", false]
	question5["explanation"] = ["res://assets/lab_explanationcards/4.png"]
	
	labyrinth_questions = [question1, question2, question3, question4, question5]
	

