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
var current_time = 0.0
var current_step = 0
var step_time = 0

var isStarted = false

func start():
	isStarted = true

var monolog = {
	0 : [
		{"Hero" : tr("start_cutscene_0")},
		{"Beloved" : tr("start_cutscene_1")},
		{"Hero" : tr("start_cutscene_2")},
		{"Beloved" : tr("start_cutscene_3")},
		{"Beloved" : tr("start_cutscene_4")}
	],
	1 : [
		{"Devil" : tr("start_cutscene_5")},
		{"Hero" : tr("start_cutscene_6")}
	],
	2 : [
		{"Devil" : tr("final_cutscene_0")}
	],
	3 :[
		{"Devil" : tr("final_cutscene_1")},
		{"Devil" : tr("final_cutscene_2")},
	],
	4 : [
		{"Beloved" : tr("end_cutscene_0")}
	]
}
func _ready():
	print(monolog.get(cutscene)[current_step].keys()[0])
	for label_path in dialog_windows.values():
		get_node(label_path).visible = false
	get_node(dialog_windows.get(monolog.get(cutscene)[current_step].keys()[0])).text = monolog.get(cutscene)[current_step].values()[0]

func _process(delta):
	if isStarted:
		current_time += delta
		for label_path in dialog_windows.values():
			get_node(label_path).visible = true
		if current_time >= times[step_time] and current_step == monolog.get(cutscene).size() - 1:
			print("gg")
			for label_path in dialog_windows.values():
				get_node(label_path).text = ""
			queue_free()
		elif current_time >= times[step_time] and step_time % 2 == 0:
			print("hhh")
			for label_path in dialog_windows.values():
				get_node(label_path).text = ""
			current_time = 0
			step_time += 1
		elif current_time >= times[step_time]:
			current_step += 1
			step_time += 1
			get_node(dialog_windows.get(monolog.get(cutscene)[current_step].keys()[0])).text = monolog.get(cutscene)[current_step].values()[0]
			current_time = 0
