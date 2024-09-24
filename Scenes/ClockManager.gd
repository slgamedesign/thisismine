extends Node2D

@export var minuteHandle : AnimatedSprite2D
@export var hourHandle : AnimatedSprite2D
@export var timer : Timer

var time : int = 36  # Initialize the time to 36 (or any value you need)
var timeIsUp = false
signal timeUp() 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Check if the nodes were successfully assigned by the editor
	if minuteHandle == null:
		print("Minutes node not found.")
	if hourHandle == null:
		print("Hours node not found.")
	if timer == null:
		print("Timer node not found.")
	
	# Initialize the clock hands if they are assigned
	if minuteHandle != null:
		minuteHandle.frame = 0
	if hourHandle != null:
		hourHandle.frame = 0
	
	# Start and configure the timer
	if timer != null:
		timer.start()  # Start the timer
		timer.wait_time = 1  # Each second represents a minute in the game
		timer.one_shot = false  # Ensure the timer repeats


# Called when the timer times out (every second or set time).
func _on_timer_timeout() -> void:
	_update_minute_hand()

	# Check if the game should end or reset
	if time <= 0:
		_reset_clock()  # Handle what happens when time hits 0

# Function to update the minute hand's frame and check for hour updates
func _update_minute_hand() -> void:
	if minuteHandle != null and !timeIsUp:
		minuteHandle.frame += 1
	
		# Simulate the passing of one minute in the game
		if time > 0:
			time -= 1
		else:
			# When the time reaches 0, handle the clock reset or game-over logic
			_reset_clock()
		
		print("Time left:", time)
		
		# Check if it's time to update the hour hand
		if time % 12 == 0:
			_update_hour_hand()
		
		# If the minute hand reaches the max frame count, reset it
		if minuteHandle.frame >= minuteHandle.sprite_frames.get_frame_count(minuteHandle.animation):
			minuteHandle.frame = 0

# Function to update the hour hand's frame every 12 minutes
func _update_hour_hand() -> void:
	if hourHandle != null and !timeIsUp:
		# Advance the hour hand by 1 frame every 12 minutes (36 frames per hour)
		hourHandle.frame += 1
		
		# Reset the hour hand if it completes a full 12-hour cycle (36 frames total)
		if hourHandle.frame >= 36:  # 36 frames for a full 12-hour cycle
			hourHandle.frame = 0


# Function to reset the clock or trigger game-over logic
func _reset_clock() -> void:
	# Reset time to 36 or trigger an event like restarting the game
	print("Time is up, resetting the clock or triggering end game!")
	
	# Reset the time back to 36 (or any value you want to restart with)
	time = 36
	
	# Reset the clock hands
	if minuteHandle != null:
		minuteHandle.frame = 0
	if hourHandle != null and hourHandle.frame == 24:
		hourHandle.frame = 0
		timeIsUp = true
		timeUp.emit()
	
	# Optionally restart the timer if needed, or handle game-over logic
	timer.start()
