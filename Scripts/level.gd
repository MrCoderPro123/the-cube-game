extends Node3D

@onready var player: Player = $Player
@onready var phantom_camera_3d: PhantomCamera3D = $PhantomCamera3D

func _ready() -> void:
	if player and phantom_camera_3d:
		phantom_camera_3d.follow_target = player
#
#func _change_level():
	#get_tree().create_timer(1.0).timeout.connect(LevelManager.next_level)
