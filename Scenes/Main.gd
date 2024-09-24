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
	print(validate_checks())


func validate_checks() -> Dictionary:
		var results : Dictionary = {"rounds" : [], "total_errors" : 0, "total_oks" : 0}
		
		var user_res : Array = global.user_responses
		var ok_res : Array = global.correct_responses
		
		for i in range(0, user_res.size()-1):
			var err_count : int = 0
			var ok_count : int = 0
			
			results["rounds"].append({
				"license" : null,
				"att" : null,
				"sa" : null,
				"nc" : null,
				"nd" : null,
				"errors" : 0,
				"oks" : 0,
			})
			
			if user_res[i]["license"] != ok_res[i]["license"]: 
				err_count += 1 
				results["rounds"][i]["license"] = true
			else : 
				results["rounds"][i]["license"] = false
				ok_count += 1
			
			if user_res[i]["att"] != ok_res[i]["att"]:
				err_count += 1 
				results["rounds"][i]["att"] = true
			else : 
				results["rounds"][i]["att"] = false
				ok_count += 1
			
			if user_res[i]["sa"] != ok_res[i]["sa"]:
				err_count += 1 
				results["rounds"][i]["sa"] = true
			else : 
				results["rounds"][i]["sa"] = false
				ok_count += 1
			
			if user_res[i]["nc"] != ok_res[i]["nc"]:
				err_count += 1 
				results["rounds"][i]["nc"] = true
			else : 
				results["rounds"][i]["nc"] = false
				ok_count += 1
			
			if user_res[i]["nd"] != ok_res[i]["nd"]:
				err_count += 1 
				results["rounds"][i]["nd"] = true
			else : 
				results["rounds"][i]["nd"] = false
				ok_count += 1
			
			results["rounds"][i]["errors"] = err_count
			results["rounds"][i]["oks"] = ok_count
			results["total_errors"] += err_count
			results["total_oks"] += ok_count
		
		return results
