extends CharacterBody2D

@onready var texture_progress_bar = $TextureProgressBar
@onready var stealth_matrix = $StealthMatrix

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


var direction_vector: Vector2 = Vector2.ZERO
var detection_meter: float = 0
var detection_meter_max: float = 100


func _ready():
	#set max value for our detection meter sprite
	texture_progress_bar.max_value = detection_meter_max
	
func _physics_process(delta):
	
	
	if Input.is_action_just_pressed("UseAbility"):
		stealth_matrix.activate_equipped_tool()
	#negative x, positive x, negative y, positive y
	direction_vector = Input.get_vector("Left", "Right", "Up", "Down")
	if direction_vector:
		velocity = direction_vector * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

func fill_up_detection_meter(rate):
	detection_meter += rate
	texture_progress_bar.value = detection_meter
