extends Node2D

@onready var cool_down_timer = $CoolDownTimer
@onready var point_light_2d = $PointLight2D
@onready var effect_timer = $EffectTimer
@onready var enemy_detection_area = $EnemyDetectionArea

var marker_sprite_scene = preload("res://Tools/enemy_marker_sprite.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	point_light_2d.enabled = false
	cool_down_timer.stop()
	enemy_detection_area.monitoring = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func activate():
	if cool_down_timer.is_stopped():
		#point_light_2d.enabled = true
		enemy_detection_area.monitoring = true
		#effect_timer.start()
	else:
		return_cooldown_time_left()

func return_cooldown_time_left() -> float:
	return cool_down_timer.time_left

func _on_effect_timer_timeout():
	print("effect ended")
	point_light_2d.enabled = false
	enemy_detection_area.monitoring = false
	cool_down_timer.start()


func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemies"):
		var marker_sprite_instance = marker_sprite_scene.instantiate()
		get_tree().root.add_child(marker_sprite_instance)
		marker_sprite_instance.global_position = area.global_position
		effect_timer.start()
