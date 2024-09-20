extends Node2D

@export var queue : AnimatedSprite2D
@export var anim : AnimationPlayer

signal _new_char()

func _ready() -> void:
	anim.current_animation = anim.get_animation_list()[1]
	pass


func _process(_delta: float) -> void:
	pass


func _on_sentence(buttonName: String, tab_index: int) -> void:
	queue.play()
	next_char()
	pass # Replace with function body.

func next_char():
	anim.current_animation = anim.get_animation_list()[2]
	anim.play()
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "characterOut":
		_new_char.emit()
		anim.current_animation = anim.get_animation_list()[1]
		anim.play()
	pass # Replace with function body.
