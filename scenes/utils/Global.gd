extends Node

class_name Global

var isStartScene = true
var playerPos_bef_Cutscene = Vector2(346, 103)
var playerRotation_bef_Cutscene = -90

func map_number(number, from_min, from_max, to_min, to_max):
	var normalized_number = (number - from_min) / (from_max - from_min)
	var mapped_number = normalized_number * (to_max - to_min) + to_min
	return mapped_number
