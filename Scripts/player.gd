class_name Player
extends RigidBody3D

@export var speed: int = 10
@export var side_speed: int = 15

var is_moving = true

@onready var scene_anim: AnimationPlayer = $UI/Control/SceneTransition/scene_anim
@onready var mesh: MeshInstance3D = $Mesh
@onready var transition_lbl: Label = $UI/Control/SceneTransition/TransitionLbl
@onready var pause_btn: Button = $UI/Control/PauseBtn
@onready var virtual_joystick: VirtualJoystick = $UI/Control/VirtualJoystick

var PLAYER_MATERIAL: StandardMaterial3D = preload("uid://b2gcqiq4cxhun")

func _ready() -> void:
	freeze = false
	is_moving = true
	scene_anim.play("RESET")
	PLAYER_MATERIAL.albedo_color = GlobalValues.get_player_color()
	if OS.get_name() == "Web":
		virtual_joystick.visibility_mode = VirtualJoystick.VISIBILITY_ALWAYS
	

func _physics_process(delta: float) -> void:
	
	# Movement
	linear_velocity.z = -speed
	if is_moving:
		linear_velocity.x = Input.get_axis("move_left", "move_right") * side_speed
	
	# Loosing the Level if Falling Down
	if position.y <= -2:
		LevelManager.restart_current_scene()


func _on_body_entered(body: Node) -> void:
	if body is RigidBody3D:
		# If object is Obstacle
		if body.collision_layer == 3 and is_moving:
			is_moving = false
			get_tree().create_timer(1.0, false).timeout.connect(LevelManager.restart_current_scene)
	elif body is StaticBody3D:
		# If Object is FinishLine
		if body.collision_layer == 9: 
			if is_moving:
				freeze = true
				transition_lbl.text = "Level " + str(GlobalValues.get_level() + 1) + " Completed"
				scene_anim.play("scene_transition")
				GlobalValues.save_data(GlobalValues.get_coins(), GlobalValues.get_player_color(), GlobalValues.get_purchased_colors())
				pause_btn.hide()
				get_tree().create_timer(1.5, false).timeout.connect(LevelManager.next_level)
