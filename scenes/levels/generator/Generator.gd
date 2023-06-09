extends Node2D

onready var tilemap = $TileMap
onready var spikes_map = $Spikes/spikes_map
onready var finish_area_node = $Finish
onready var result_label = $Node/Control/CanvasLayer/MarginContainer/Result

export var map_size = Vector2(20, 20)
export var wall = -0.2
export var spike = -0.4
export (int) var min_dist = int(map_size.length() / 2)
export var spike_tile_index:int
export var wall_tile_index:int
export var start_tile_index:int
export var finish_tile_index:int

signal spike_connected

var win_screen_scene = preload("res://scenes/entities/win_screen/WinScreen.tscn")
var win_screen: CanvasLayer
var died_screen_scene = preload("res://scenes/entities/died_screen/DiedScreen.tscn")
var died_screen: CanvasLayer

var noise
var astar = AStar.new()
var map = []
var empty_tiles = []
var isFoundPath = false
var respawnCount: int

var pl

var start_pos_index:int
var start_vec:Vector2
var finish_vec:Vector2

var current_result = 0
var isFirstTime = false

enum tiles{
	nothing = 0,
	wall = 1,
	spike = 2,
	start = 3,
	finish = 4
}

func _ready():
	randomize()
	noise = OpenSimplexNoise.new()
	
	create_level()
	var player = preload("res://scenes/entities/player/Player.tscn")
	var save = Save_Handler.new()
	save.load_from_file("user://data.txt")
	pl = player.instance()
	add_child(pl)
	var tex_path = save.get_value("skin_path")
	if tex_path != null:
		pl.get_node("Sprite").texture = load(save.get_value("skin_path"))
	pl.global_position = Vector2(start_vec.x, start_vec.y) * 16 + Vector2(8, 8)
func create_level() -> void:
	noise.seed = randi()
	noise.octaves = 1
	noise.period = 3
	
	generate()
	correcting_map()
	create_grid()
	count_empty_tiles()
	while !isFoundPath:
		create_start_and_finish()
	draw_map()
	var save = Save_Handler.new()
	save.load_from_file("user://data.txt")
	result_label.text = "Result: 0" if save.get_value("current_result") == null else "Result: " + str(save.get_value("current_result"))
	$Node/Control/CanvasLayer/MarginContainer/Count.text = "Respawn count: " + str(respawnCount)
	if isFirstTime:
		pl.global_position = Vector2(start_vec.x, start_vec.y) * 16 + Vector2(8, 8)
	isFirstTime = true
	
func generate():
	for x in map_size.x:
		map.append([])
		for y in map_size.y:
			map[x].append(tiles.nothing)
			var a = noise.get_noise_2d(x,y)
			if x == 0 or y == 0 or x == map_size.x - 1 or y == map_size.y - 1:
				map[x][y] = tiles.wall
			if a < wall:
				map[x][y] = tiles.wall
			if a < spike and x!= 0 and y!=0 and x!=map_size.x - 1 and y!= map_size.y - 1:
				map[x][y] = tiles.spike

func correcting_map():
	for x in range(0, map_size.x):
		for y in  range(0, map_size.y):
			var isConform = x != 0 and x != map_size.x - 1 and y != 0 and y != map_size.y - 1
			if isConform:
				var isHole =  map[x][y] != tiles.nothing and map[x-1][y] != tiles.nothing and  map[x+1][y] != tiles.nothing and map[x][y + 1] != tiles.nothing and  map[x][y - 1] != tiles.nothing
				var isNoWallHere = map[x][y] == tiles.spike and  map[x-1][y] != tiles.wall and  map[x+1][y] != tiles.wall and map[x][y + 1] != tiles.wall and  map[x][y - 1] != tiles.wall
				if isHole:
					map[x][y] = tiles.wall
				if isNoWallHere:
					map[x][y] = tiles.nothing

func create_grid():
	for x in map_size.x:
		for y in map_size.y:
			astar.add_point(x + y * map_size.x, Vector3(x, y, 0))

	for x in range(1, map_size.x - 1):
		for y in range(1, map_size.y - 1):
			if map[x][y] == tiles.nothing and map[x + 1][y] == tiles.nothing:
				astar.connect_points(x + y * map_size.x, (x + 1) + y * map_size.x)
			if map[x][y] == tiles.nothing and map[x][y + 1] == tiles.nothing:
				astar.connect_points(x + y * map_size.x, x + (y + 1) * map_size.x)

func count_empty_tiles():
	for x in range(2, map_size.x - 1):
		for y in  range(2, map_size.y - 1):
			if map[x][y] == tiles.nothing:
				empty_tiles.append(Vector2(x, y))

func create_start_and_finish():
	respawnCount+=1
	
	start_pos_index = rand_range(0, empty_tiles.size())
	start_vec = empty_tiles[start_pos_index]
	empty_tiles.remove(start_pos_index)
	finish_vec = empty_tiles[rand_range(0, empty_tiles.size())]
	map[start_vec.x][start_vec.y] = tiles.start
	map[finish_vec.x][finish_vec.y] = tiles.finish
	
	if start_vec.distance_to(finish_vec) > min_dist and astar.get_id_path(start_vec.x + start_vec.y * map_size.x, finish_vec.x + finish_vec.y * map_size.x).size() > 0:
		isFoundPath = true
		finish_area_node.position = finish_vec * 16 + Vector2(8, 8)
	else:
		map[start_vec.x][start_vec.y] = tiles.nothing
		map[finish_vec.x][finish_vec.y] = tiles.nothing
		empty_tiles.append(start_vec)
func draw_map():
	for x in range(0, map_size.x):
		for y in range(0, map_size.y):
			var isConform = x != 0 and x != map_size.x - 1 and y != 0 and y != map_size.y - 1
			match map[x][y]:
				tiles.wall:
					tilemap.set_cell(x, y, wall_tile_index)
				tiles.spike:
					draw_spikes(x, y)
				tiles.start:
					tilemap.set_cell(x, y, start_tile_index)
				tiles.finish:
					tilemap.set_cell(x, y, finish_tile_index)
	tilemap.update_bitmask_region(Vector2(0.0, 0.0), Vector2(map_size.x, map_size.y))
	spikes_map.update_bitmask_region(Vector2(0.0, 0.0), Vector2(map_size.x, map_size.y))

func _input(event):
	if event.is_action_pressed("exit"):
		get_tree().change_scene("res://scenes/menu/menu/Menu.tscn")

func _process(delta):
	if Input.is_action_just_pressed("respawn"):
		get_tree().reload_current_scene()

func draw_spikes(x, y):
	if map[x][y - 1] == tiles.wall:
		spikes_map.set_cell(x, y, spike_tile_index, false, true)
	if map[x + 1][y] == tiles.wall:
		spikes_map.set_cell(x, y, spike_tile_index, false, true, true)
	if map[x][y + 1] == tiles.wall:
		spikes_map.set_cell(x, y, spike_tile_index)
	if map[x - 1][y] == tiles.wall:
		spikes_map.set_cell(x, y, spike_tile_index, true, false, true)

	if map[x][y + 1] == tiles.wall and map[x][y - 1] == tiles.wall and map[x + 1][y] == tiles.wall:
		spikes_map.set_cell(x, y, spike_tile_index, false, true, true)
	if map[x][y + 1] == tiles.wall and map[x][y - 1] == tiles.wall and map[x - 1][y] == tiles.wall:
		spikes_map.set_cell(x, y, spike_tile_index, true, false, true)
	if map[x + 1][y] == tiles.wall and map[x - 1][y] == tiles.wall and map[x][y - 1] == tiles.wall:
		spikes_map.set_cell(x, y, spike_tile_index, false, true)
	if map[x + 1][y] == tiles.wall and map[x - 1][y] == tiles.wall and map[x][y + 1] == tiles.wall:
		spikes_map.set_cell(x, y, spike_tile_index)

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		died_screen = died_screen_scene.instance()
		get_node("Node/Control").add_child(died_screen)
		for i in get_children():
			if i.name != "Node":
				i.visible = false


func _on_Finish_body_entered(body):
	print(body.get_name())
	if body.get_name() == "Player":
		get_tree().reload_current_scene()
		var save = Save_Handler.new()
		save.load_from_file("user://data.txt")
		save.add_value("current_result", save.get_value("current_result") + 1)
		save.save_to_file("user://data.txt")


func _on_Spikes_body_entered(body):
	if body.get_name() == "Player":
		var save = Save_Handler.new()
		save.load_from_file("user://data.txt")
		save.add_value("best_result", max(int(save.get_value("best_result")), save.get_value("current_result")))
		save.add_value("current_result", 0)
		save.save_to_file("user://data.txt")
		died_screen = died_screen_scene.instance()
		get_node("Node/Control").add_child(died_screen)
		for i in get_children():
			if i.name != "Node":
				i.visible = false	
		pl.queue_free()


func _on_Exit_pressed():
	get_tree().change_scene("res://scenes/menu/menu/Menu.tscn")
