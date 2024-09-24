extends Node2D

@export var queue : AnimatedSprite2D
@export var anim : AnimationPlayer

signal _new_char()

func _ready() -> void:
	anim.current_animation = anim.get_animation_list()[1]
	pass


func _process(_delta: float) -> void:
	pass


func _on_sentence(_buttonName: String, _tab_index: int) -> void:
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


func validate_player_responses():
	print(generate_results())


func generate_results() -> Dictionary:
		var results : Dictionary = {"rounds" : [], "total_errors" : 0, "total_oks" : 0}

		var user_res : Array = global.user_responses
		var ok_res : Array = global.correct_responses

		for i in range(0, user_res.size()-1):
			var result = {
				"license" : user_res[i]["license"] == ok_res[i]["license"],
				"att" : user_res[i]["att"] == ok_res[i]["att"],
				"sa" : user_res[i]["sa"] == ok_res[i]["sa"],
				"nc" : user_res[i]["nc"] == ok_res[i]["nc"],
				"nd" : user_res[i]["nd"] == ok_res[i]["nd"],
				"app" : user_res[i]["app"] == ok_res[i]["app"],
				"errors" : 0,
				"oks" : 0,
			}

			result["oks"] = (int(result["license"]) + int(result["att"]) + 
						   int(result["sa"]) + int(result["nc"]) + 
						   int(result["nd"]) + int(result["app"]))

			result["errors"] = 6 - result["oks"]

			results["rounds"].append(result)

			results["total_errors"] += result["errors"]
			results["total_oks"] += result["oks"]

		return results
