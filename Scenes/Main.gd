extends Node2D

@export var queue : AnimatedSprite2D
@export var anim : AnimationPlayer
@export var fore : AnimatedSprite2D
@export var music : AudioStreamPlayer2D

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


func _game_over(_btn_name, _i):
	if global.user_responses:
		# Calculate if the last response was correct or not
		var last_response_incorrect = global.user_responses[global.user_responses.size() - 1]["app"] != global.correct_responses[global.user_responses.size() - 1]["app"]


		# Decrease health if the last response was incorrect
		global.health -= int(last_response_incorrect)

	if global.health <= 0:
		print("\n\n\n\ngame_over\n\n")
		fore.animation = "GameOver"
		fore.play_backwards()
	


		# Adjust the score
		if last_response_incorrect:
			decrease_score(5)  # Deduct points for incorrect response
		else:
			increase_score(10)  # Award points for correct response

		# Print the current score for debugging
		print("Current Score: ", global.score)

		# Check if the game is over due to health or score
		if global.health <= 0 or global.score <= 0:
			print("\n\n\n\ngame_over\n\n")
			get_tree().change_scene_to_file("res://Scenes/score.tscn")
			# You can add any additional game-over logic here, like stopping the game or showing a game-over screen.
	
	
func generate_results() -> Dictionary:
	var results : Dictionary = {"rounds" : [], "total_errors" : 0, "total_oks" : 0}

	var user_res : Array = global.user_responses
	var ok_res : Array = global.correct_responses

	for i in range(0, user_res.size()):
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

		# Update total OKs and errors
		results["total_errors"] += result["errors"]
		results["total_oks"] += result["oks"]

		# Adjust the score based on correct and incorrect responses
		increase_score(result["oks"] * 10)  # Award points for each correct answer
		decrease_score(result["errors"] * 5)  # Deduct points for each error

	return results

# Method to increase the score
func increase_score(points: int):
	global.score += points

# Method to decrease the score
func decrease_score(points: int):
	global.score -= points
