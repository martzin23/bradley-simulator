extends Node3D
class_name EngineAudioPlayer

@export_group("Engine Sounds")
@export var START_SOUND: AudioStream
@export var LOOP_SOUND: AudioStream
@export var STOP_SOUND: AudioStream

@export_group("References")
@export var MOVEMENT_COMPONENT: MovementComponent

@export_group("Audio Tuning")
@export var FADE_TIME := 0.08
@export var VOLUME_DB := 0.0

@onready var _player_a: AudioStreamPlayer3D = $PlayerA
@onready var _player_b: AudioStreamPlayer3D = $PlayerB
var _active: AudioStreamPlayer3D
var _inactive: AudioStreamPlayer3D

enum EnginePhase { IDLE, STARTING, LOOPING, STOPPING }
var _phase := EnginePhase.IDLE
var _wants_to_move := false
var _fade_tween: Tween

func _ready() -> void:
	assert(MOVEMENT_COMPONENT)
	
	_active = _player_a
	_inactive = _player_b
	
	for p in [_player_a, _player_b]:
		p.volume_db = -80.0
		p.finished.connect(_on_stream_finished)
	
	# Connect movement intent signals
	MOVEMENT_COMPONENT.move_started.connect(_on_move_started)
	MOVEMENT_COMPONENT.move_stopped.connect(_on_move_stopped)

func _on_move_started() -> void:
	_wants_to_move = true
	match _phase:
		EnginePhase.IDLE, EnginePhase.STOPPING:
			_play_start()

func _on_move_stopped() -> void:
	_wants_to_move = false
	match _phase:
		EnginePhase.STARTING, EnginePhase.LOOPING:
			_play_stop()

func _play_start() -> void:
	if not START_SOUND:
		_play_loop()
		return
	_phase = EnginePhase.STARTING
	_crossfade_to(START_SOUND)

func _play_loop() -> void:
	if not LOOP_SOUND:
		return
	if _phase == EnginePhase.LOOPING and _active.playing:
		return
	_phase = EnginePhase.LOOPING
	_crossfade_to(LOOP_SOUND)

func _play_stop() -> void:
	if not STOP_SOUND:
		_reset()
		return
	_phase = EnginePhase.STOPPING
	_crossfade_to(STOP_SOUND)

func _crossfade_to(stream: AudioStream) -> void:
	if _fade_tween:
		_fade_tween.kill()
	
	_inactive.stream = stream
	_inactive.volume_db = -80.0
	_inactive.play()
	
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_interval(0.015)
	tween.tween_property(_inactive, "volume_db", VOLUME_DB, FADE_TIME)
	tween.parallel().tween_property(_active, "volume_db", -80.0, FADE_TIME)
	
	tween.tween_callback(func():
		_active.stop()
		_swap_players()
	)
	
	_fade_tween = tween

func _swap_players() -> void:
	var tmp := _active
	_active = _inactive
	_inactive = tmp

func _on_stream_finished() -> void:
	match _phase:
		EnginePhase.STARTING:
			if _wants_to_move:
				_play_loop()
			else:
				_play_stop()
		EnginePhase.STOPPING:
			_reset()

func _reset() -> void:
	if _fade_tween:
		_fade_tween.kill()
	_active.stop()
	_inactive.stop()
	_phase = EnginePhase.IDLE
