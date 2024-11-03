extends Node2D

@onready var area_2d = $DetectionArea
@onready var effect_timer = $EffectTimer


# Called when the node enters the scene tree for the first time.
func _ready():
	area_2d.monitoring = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	#print(area, "part of ", area.get_parent())
	area.highlight()
	area.make_clickable()


func activate():
	area_2d.monitoring = true
	effect_timer.start()
	print("Activating HackingTool")


func _on_effect_timer_timeout():
	#turn off collision with the detection sphere
	area_2d.monitoring = false
	print("Deactivating Hackingtool")
