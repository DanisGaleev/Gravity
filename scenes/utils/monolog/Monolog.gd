extends Label

#export (Array, String) var phrases_en
#export (Array, String) var phrases_ru

export (int, "start_cutscene_0", "start_cutscene_1","final_cutscene_0","final_cutscene_1", "end_cutscene_0") var cutscene
export (Array, float) var times
var current_time = 0.0
var current_step = 0
var step_time = 0

var save = Save_Handler.new()
var lang : String
var isStarted = false

var monolog = {
	0 : [
		tr("start_cutscene_0"),
		tr("start_cutscene_1"),
		tr("start_cutscene_2"),
		tr("start_cutscene_3")
	],
	1 : [
		tr("start_cutscene_4"),
		tr("start_cutscene_5")
	],
	2 : [
		tr("final_cutscene_0")
	],
	3 :[
		tr("final_cutscene_1"),
		tr("final_cutscene_2"),
	],
	4 : [
		tr("end_cutscene_0")
	]
}

func started():
	isStarted = true

func _ready():
	visible = false
	save.load_from_file("user://data.txt")
	lang = save.get_value("language")
	text = monolog.get(cutscene)[current_step]
#	print(phrases_en)
#	if lang == "english":
#		text = phrases_en[current_step]
#	elif lang == "russian":
#		text = phrases_ru[current_step]

func _process(delta):
	if isStarted:
		visible = true
		current_time += delta
#		print(step_time)
#		print(current_time)
		if current_time >= times[step_time] and current_step == monolog.get(cutscene).size() - 1:
			queue_free()
		elif current_time >= times[step_time] and step_time % 2 == 0:
			text = ""
			current_time = 0
			step_time += 1
		elif current_time >= times[step_time]:
			current_step += 1
			step_time += 1
			text = monolog.get(cutscene)[current_step]
#			if lang == "english":
#				text = phrases_en[current_step]
#			elif lang == "russian":
#				text = phrases_ru[current_step]
			current_time = 0
