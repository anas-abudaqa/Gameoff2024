extends Node2D

@onready var cool_down_timer = $CoolDownTimer
@onready var point_light_2d = $PointLight2D
@onready var effect_timer = $EffectTimer
@onready var enemy_detection_area = $EnemyDetectionArea

#var marker_sprite_scene = preload("res://Tools/enemy_marker_sprite.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	point_light_2d.enabled = false
	cool_down_timer.stop()
	enemy_detection_area.monitoring = false


func activate() -> Variant:
	if cool_down_timer.is_stopped():
		enemy_detection_area.monitoring = true
		#point_light_2d.enabled = true
		effect_timer.start()
		print("Activating PulseScanner")
		return
	else:
		return cool_down_timer.time_left
	

func _on_area_2d_area_entered(area):
	area.highlight()

func _on_effect_timer_timeout():
	cool_down_timer.start()
	enemy_detection_area.monitoring = false
	#print("effect ended")
	#point_light_2d.enabled = false
	



