extends Node2D

@onready var cool_down_timer = $CoolDownTimer
@onready var point_light_2d = $PointLight2D
@onready var effect_timer = $EffectTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	point_light_2d.enabled = false
	cool_down_timer.stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func activate():
	if cool_down_timer.is_stopped():
		point_light_2d.enabled = true
		effect_timer.start()
	else:
		return_cooldown_time_left()

func return_cooldown_time_left() -> float:
	return cool_down_timer.time_left

func _on_effect_timer_timeout():
	point_light_2d.enabled = false
	cool_down_timer.start()


