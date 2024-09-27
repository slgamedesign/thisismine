extends Node2D

@export var background : AnimatedSprite2D
@export var engine : AudioStreamPlayer2D
@export var label : RichTextLabel
var intro = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	intro = true
	background.frame = 68
	background.play_backwards("default")
	if global.lost:
		lost()
	else:
		label.add_text(str(global.score) + " dimes into your pocket\nCases: "
		+ str(global.daySummary["rounds"].size())
		+ "\nTotal errors: " + str(global.daySummary["total_errors"])
		+ "\nTotal ok's: " + str(global.daySummary["total_oks"]))
	pass # Replace with function body.
	

func lost():
	label.clear()
	
	label.add_text("YOU'RE FIRED!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if background.frame == 60 and intro:
		engine.play()
		


func _on_next(buttonName: String, tab_index: int) -> void:
	if global.lost:
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
	background.play("default")
	engine.play()
	pass # Replace with function body.


func _on_background_animation_finished() -> void:
	if intro:
		intro = !intro
	else:
		get_tree().change_scene_to_file("res://Scenes/Testing.tscn")
	pass # Replace with function body.
