extends Node2D

@export var background : AnimatedSprite2D
@export var engine : AudioStreamPlayer2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	background.frame = 68
	background.play_backwards("default")
	str(global.score)
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if background.frame == 60:
		engine.play()
	pass
