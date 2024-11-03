extends Area2D


@export var player: CharacterBody2D
@export var patrol_path: PathFollow2D
@onready var highlight_timer = $HighlightTimer

@onready var point_light_2d = $PointLight2D
@onready var sprite_2d = $Sprite2D
@onready var navigation_agent_2d = $NavigationAgent2D
@onready var line_of_sight = $VisionCone/LineOfSight
@onready var texture_progress_bar = $TextureProgressBar
@onready var mouse_interaction_area = $MouseInteractionArea


var speed: float = randf_range(175, 250)
var alert_mode = false
var direction_vector: Vector2 = Vector2.ZERO

var allow_clicks: bool = true
var mouse_in_area: bool = false
var detection_meter: float = 0
var detection_meter_max: float = 100
var start_meter: bool = false
var awareness_status


enum awareness_levels {
	Idle,
	Curious,
	Suspicious, 
	Alert,
	Nervous
}

# Called when the node enters the scene tree for the first time.
func _ready():
	#set max value for our detection meter sprite
	texture_progress_bar.max_value = detection_meter_max
	#set starting point on patrol path starting point if it exists
	if patrol_path:
		global_position = patrol_path.global_position
		
		
	#by default set these parameters to false 
	point_light_2d.enabled = false

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if !alert_mode:
		patrol(delta)
		#if we are not alerted, check if detection meter is full
		if detection_meter >= detection_meter_max:
			detection_meter = clampf(detection_meter, 0, detection_meter_max)
			#go_into_alert()
	#else:
		#track_player(delta)
	
	#if line of sight is enabled due to body in detection area
	if line_of_sight.enabled:
		#check if player is in light of sight
		if player_in_line_of_sight():
			#if yes, start filling detection meter
			start_meter = true
		else:
			#else stop it
			start_meter = false
	
	#if an activity is causing suspicion start filling up meter
	if start_meter:
		if detection_meter < detection_meter_max:
			fill_up_detection_meter(1)
	else: #else start depleting the meter
		if detection_meter > 0:
			fill_up_detection_meter(-0.2)
	
	
	
func player_in_line_of_sight() -> bool:
	var collided_object = line_of_sight.get_collider()
	if collided_object:
		if collided_object.is_in_group("Player"):
			return true
		else:
			return false
	else:
		return false

func fill_up_detection_meter(rate):
	detection_meter += rate
	#also call the players fill function
	player.fill_up_detection_meter(rate)

func patrol(delta):
	if patrol_path:
		patrol_path.progress += speed * delta

func highlight():
	##to be used by the pulse_scanner to highlight enemies
	point_light_2d.enabled = true
	print("my light is on ", point_light_2d.enabled)
	highlight_timer.start()

func make_clickable():
	allow_clicks = true
	print("Now you can click ", allow_clicks)


func _on_area_2d_body_entered(body):
	#When we detect the player is in the vision cone. Try to establish line of sight
	line_of_sight.enabled = true


func _on_area_2d_body_exited(body):
	#check if we are alerted first before disabling line of sight
	if !alert_mode:
		line_of_sight.enabled = false

func _on_highlight_timer_timeout():
	point_light_2d.enabled = false

func _on_mouse_interaction_area_input_event(viewport, event, shape_idx):
	if allow_clicks and mouse_in_area:
		if event.is_action_pressed("LMB"):
			print("Yo this kinda works")
			allow_clicks = false
	#else:
		#print("mouse is here ", mouse_in_area)
		#print("i can click ", allow_clicks)



func _on_mouse_interaction_area_mouse_entered():
	mouse_in_area = true


func _on_mouse_interaction_area_mouse_exited():
	mouse_in_area = false

	#if going_right:
		#position.x += speed * delta
		##scale = Vector2(1, 1)
	#else:
		##scale = Vector2(-1, 1)
		#position.x -= speed * delta
#
	#if ray_cast_right.is_colliding():
		#going_right = false
	#elif ray_cast_left.is_colliding():
		#going_right = true
	#else:
		#return

#func go_into_alert():
	#alert_mode = true
	#tracker_update_timer.start()

#func track_player(delta):
	#direction_vector = (navigation_agent_2d.get_next_path_position() - global_position).normalized()
	#translate(direction_vector * speed * delta)
	##Make enemy follow player with their "eyes"
	#
	#########################IMPORTANT################################
	##This might cause bugs if the raycast is exactly at the player's position
	##Should create a small offset to prevent touching if necessary
	#line_of_sight.target_position = global_position - player.global_position
	##if the timer is not on and player is not in sight, start the 
	#if escape_timer.is_stopped() and !player_in_line_of_sight():
		#escape_timer.start()
	#if player_in_line_of_sight():
		#escape_timer.stop()

#func update_target_position():
	#navigation_agent_2d.target_position = player.global_position







