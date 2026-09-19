extends Node3D

@onready var player: Player = $Player
@onready var phantom_camera_3d: PhantomCamera3D = $PhantomCamera3D

const COIN: PackedScene = preload("uid://jmcmluig3ds")
const OBSTACLE: PackedScene = preload("uid://cqm73q6d8bj3t")

@export var layers_of_generation := 3
@export var max_coins := 3
@export var max_obstacles := 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if player and phantom_camera_3d:
		phantom_camera_3d.follow_target = player
	get_tree().create_timer(2.0).timeout.connect(spawn_coin)

func spawn_coin():
	for i in range(layers_of_generation):
		var coin: Node3D = COIN.instantiate()
		coin.position.z = (player.global_position.z) - 10
		coin.position.y = 1
		coin.position.x = randi_range(-6, 6)
		get_tree().current_scene.call_deferred("add_child", coin)


func _on_timer_timeout() -> void:
	for i in range(layers_of_generation):
		for j in range(randi_range(0, max_coins)):
			var coin: Node3D = COIN.instantiate()
			coin.position.z = (player.global_position.z) - (10 * (i + 1))
			coin.position.y = 1
			coin.position.x = randi_range(-6, 6)
			get_tree().current_scene.call_deferred("add_child", coin)
		for k in range(randi_range(1, max_obstacles)):
			var obstacle: Node3D = OBSTACLE.instantiate()
			obstacle.position.z = (player.global_position.z) - (10 * (i + 1))
			obstacle.position.y = 1
			obstacle.position.x = randi_range(-6, 6)
			get_tree().current_scene.call_deferred("add_child", obstacle)
