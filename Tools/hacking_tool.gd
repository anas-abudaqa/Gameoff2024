extends Node2D

@onready var area_2d = $Area2D

const ENEMY_MARKER_SPRITE = preload("res://Tools/enemy_marker_sprite.tscn")

var interactable_area_array: Array
var hackables_available: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	area_2d.monitoring = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("LMB"):
		if hackables_available:
			
			var mouse_position = get_viewport().get_mouse_position()
			print(mouse_position)
			for hackable in interactable_area_array:
				print("hackable: ", hackable.global_position)
				if mouse_position >= hackable.global_position + Vector2(100, 100) or mouse_position <= hackable.global_position - Vector2(100, 100):
					print("Yo this works i guess")
		#print(mouse_position)
#collisions on layer Hackable

func _on_area_2d_area_entered(area):
	interactable_area_array.append(area)
	#area.highlight()
	var marker_instance = ENEMY_MARKER_SPRITE.instantiate()
	get_tree().root.add_child(marker_instance)
	marker_instance.global_position = area.global_position
	hackables_available = true



func activate():
	area_2d.monitoring = true

