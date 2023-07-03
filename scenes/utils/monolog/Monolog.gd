extends Label

#export (Array, String) var phrases_en
#export (Array, String) var phrases_ru

export (int, "start_cutscene_0", "start_cutscene_1","final_cutscene_0","final_cutscene_1", "end_cutscene_0") var cutscene
export (Array, float) var times
export(NodePath) var audio
var current_time = 0.0
var current_step = 0
var step_time = 0

var save = Save_Handler.new()
var lang : String
var isStarted = false

var phrase_dictionaty = {
	"start_cutscene_5" : "ha_ha_ha_your_beloved_has_fallen/ha_ha_ha_your_beloved_has_fallen_en",
	"final_cutscene_0" : "you_finally_reached_her/you_finally_reached_her_en",
	"final_cutscene_1" : "you_will_never_get_her_out/you_will_never_get_her_out_en",
	"final_cutscene_2" : "this_is_not_the_end/this_is_not_the_end_en"
}

var monolog = {
	0 : [
		tr("start_cutscene_0"),
		tr("start_cutscene_1"),
		tr("start_cutscene_2"),
		tr("start_cutscene_3"),
		tr("start_cutscene_4")
	],
	1 : [
		tr("start_cutscene_5"),
		tr("start_cutscene_6")
	],
	2 : [
		{tr("final_cutscene_0") : "you_finally_reached_her/you_finally_reached_her_en"}
	],
	3 :[
		{tr("final_cutscene_1") : "you_will_never_get_her_out/you_will_never_get_her_out_en"},
		{tr("final_cutscene_2") : "this_is_not_the_end/this_is_not_the_end_en"}
	],
	4 : [
		tr("end_cutscene_0")
	]
}

func started():
	isStarted = true
	(get_node(audio) as AudioStreamPlayer).play()
func _ready():
	visible = false
	save.load_from_file("user://data.txt")
	lang = save.get_value("language")
	text = monolog.get(cutscene)[current_step].keys()[0]
	print(monolog.get(cutscene)[current_step].keys()[0])
	print(monolog.get(cutscene)[current_step].values()[0])
	print("ffff")
	(get_node(audio) as AudioStreamPlayer).stream = load("res://audio/devil_phrase/plot_phrase/" + monolog.get(cutscene)[current_step].values()[0] + ".mp3")
#	print(phrases_en)
#	if lang == "english":
#		text = phrases_en[current_step]
#	elif lang == "russian":
#		text = phrases_ru[current_step]

func _process(delta):
	if isStarted:
#		if (get_node(audio) as AudioStreamPlayer).play() == false:
#			(get_node(audio) as AudioStreamPlayer).playing = true
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
			text = monolog.get(cutscene)[current_step].keys()[0]
			(get_node(audio) as AudioStreamPlayer).stream = load("res://audio/devil_phrase/plot_phrase/" + monolog.get(cutscene)[current_step].values()[0] + ".mp3")
			(get_node(audio) as AudioStreamPlayer).play()
#			if lang == "english":
#				text = phrases_en[current_step]
#			elif lang == "russian":
#				text = phrases_ru[current_step]
			current_time = 0
