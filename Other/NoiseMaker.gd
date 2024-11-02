extends Node2D

@export var audio_file: AudioStream
@export var volume: float 
@export var autoplay: bool
@export var max_sound_distance: float
@export var sound_attenuation_over_distance: float


@onready var audio_stream_player_2d = $AudioStreamPlayer2D



# Called when the node enters the scene tree for the first time.
func _ready():
	audio_stream_player_2d.stream = audio_file
	audio_stream_player_2d.volume_db = volume
	audio_stream_player_2d.autoplay = autoplay
	audio_stream_player_2d.max_distance = max_sound_distance
	audio_stream_player_2d.attenuation = sound_attenuation_over_distance
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_audio():
	audio_stream_player_2d.play(1)
