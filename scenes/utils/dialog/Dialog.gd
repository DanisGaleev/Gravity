extends Node2D

class_name Dialog
enum Speaker{
	Hero = 0,
	Devil = 1,
	Beloved = 2
}
export (Dictionary) var dialog_windows
export (int, "start_cutscene_0", "start_cutscene_1","final_cutscene_0","final_cutscene_1", "end_cutscene_0") var cutscene
export (Array, float) var times
export (NodePath) var audiostream_path
var audiostream : AudioStreamPlayer
var current_time = 0.0
var current_step = 0
var step_time = 0

var isStarted = false

func start():
	isStarted = true
	(audiostream as AudioStreamPlayer).play()
var monolog = {
	0 : [
		{"Hero" : [tr("start_cutscene_0"), "hero_phrases/it_good/it_good_en"]},
		{"Beloved" : [tr("start_cutscene_1"), "beloved_phrases/yes_right/yes_right_en"]},
		{"Hero" : [tr("start_cutscene_2"), "hero_phrases/wow_well/wow_well_en"]},
		{"Beloved" : [tr("start_cutscene_3"), "beloved_phrases/that_inside/that_inside_en"]},
		{"Beloved" : [tr("start_cutscene_4"), "beloved_phrases/aaaa/aaaa_en"]}
	],
	1 : [
		{"Devil" : [tr("start_cutscene_5"), "devil_phrase/plot_phrase/ha_ha_ha_your_beloved_has_fallen/ha_ha_ha_your_beloved_has_fallen_en"]},
		{"Hero" : [tr("start_cutscene_6"), "hero_phrases/i_save_her/i_save_her_en"]}
	],
	2 : [
		{"Devil" : [tr("final_cutscene_0"), "devil_phrase/plot_phrase/you_finally_reached_her/you_finally_reached_her_en"]}
	],
	3 :[
		{"Devil" : [tr("final_cutscene_1"), "devil_phrase/plot_phrase/you_will_never_get_her_out/you_will_never_get_her_out_en"]},
		{"Devil" : [tr("final_cutscene_2"), "devil_phrase/plot_phrase/this_is_not_the_end/this_is_not_the_end_en"]},
	],
	4 : [
		{"Beloved" : [tr("end_cutscene_0"), "beloved_phrases/you_hero/you_hero_en"]}
	]
}
func _ready():
	#TranslationServer.set_locale("en")
	audiostream = get_node(audiostream_path)
	print(monolog.get(cutscene)[current_step].keys()[0])
	for label_path in dialog_windows.values():
		get_node(label_path).visible = false
	get_node(dialog_windows.get(monolog.get(cutscene)[current_step].keys()[0])).text = monolog.get(cutscene)[current_step].values()[0][0]
	(audiostream as AudioStreamPlayer).stream = load("res://audio/" + monolog.get(cutscene)[current_step].values()[0][1] + ".mp3")
	
func _process(delta):
	#TranslationServer.set_locale("en")
	if isStarted:
		current_time += delta
		for label_path in dialog_windows.values():
			get_node(label_path).visible = true
		if current_time >= times[step_time] and current_step == monolog.get(cutscene).size() - 1:
			for label_path in dialog_windows.values():
				get_node(label_path).text = ""
			audiostream.queue_free()
			queue_free()
		elif current_time >= times[step_time] and step_time % 2 == 0:
			for label_path in dialog_windows.values():
				get_node(label_path).text = ""
			current_time = 0
			step_time += 1
		elif current_time >= times[step_time]:
			current_step += 1
			step_time += 1
			get_node(dialog_windows.get(monolog.get(cutscene)[current_step].keys()[0])).text = monolog.get(cutscene)[current_step].values()[0][0]
			(audiostream as AudioStreamPlayer).stream = load("res://audio/" + monolog.get(cutscene)[current_step].values()[0][1] + ".mp3")
			(audiostream as AudioStreamPlayer).play()
			current_time = 0
