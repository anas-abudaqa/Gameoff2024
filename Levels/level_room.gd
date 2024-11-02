extends Node2D

@export var camera: Camera2D
@export var room_id: int
@onready var window_size: Vector2 = get_viewport_rect().size
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_camera():
	camera.global_position = self.global_position + window_size/2

func _on_player_detector_body_entered(_body):
	update_camera()



func _on_player_detector_body_exited(_body):
	pass # Replace with function body.
