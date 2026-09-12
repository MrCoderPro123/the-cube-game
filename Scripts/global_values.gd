extends Node

var coins: int
var level: int = 0 # Level indexed from 0

var purchased_colors: Array[Color] 
var player_color: Color

var default_colors: Array[Color] = [Color(1.0, 0, 0)]

func _ready() -> void:
	var data: GameData = load_data()
	if data:
		coins = data.coins
		player_color = data.player_color
		purchased_colors = data.purchased_colors
	else:
		coins = 0
		player_color = Color.RED
		purchased_colors = [Color(1.0, 0, 0)]

func get_coins():
	return coins

func set_coins(val: int):
	coins = val

func get_level():
	return level

func set_level(val: int):
	level = val

func get_player_color():
	return player_color

func set_player_color(color: Color):
	player_color = color

func get_purchased_colors():
	return purchased_colors

func add_purchased_color(color: Color):
	purchased_colors.append(color)

func save_data(coin: int, py_color: Color, colors: Array[Color]):
	var data = GameData.new()
	data.coins = coin
	data.player_color = py_color
	data.purchased_colors = colors
	ResourceSaver.save(data, "user://game_data.tres")

func load_data():
	var data = ResourceLoader.load("user://game_data.tres") as GameData
	if data:
		return data
	else:
		return null

func reset_data():
	var data = GameData.new()
	data.coins = 0
	data.player_color = Color.RED
	data.purchased_colors = default_colors
	ResourceSaver.save(data, "user://game_data.tres")
	_ready()
