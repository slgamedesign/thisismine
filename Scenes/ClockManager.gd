extends Node2D

@export var minuteHandle : AnimatedSprite2D
@export var hourHandle : AnimatedSprite2D
@export var timer : Timer

var time : int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time = 36
	minuteHandle.frame = 0
	hourHandle.frame = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	pass # Replace with function body.


func _on_minutes_frame_changed() -> void:
	time -= 1
	if time % 12 == 0:
		hourHandle.frame += 1
	pass # Replace with function body.
