extends AnimatedSprite2D

@export var checked : bool
@export var info : String

func _on_area_2d_mouse() -> void:
	if !checked and self.frame == 0:
		self.frame = 1
	elif !checked and self.frame == 1:
		self.frame = 0
	elif checked and self.frame == 2:
		self.frame = 3
	elif checked and self.frame == 3:
		self.frame = 2
	


func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("Click") and self.frame == 1:
		self.frame = 2
	if Input.is_action_just_released("Click") and frame == 2 and !checked:
		self.frame = 3
		checked = true
	elif Input.is_action_just_released("Click") and frame == 3 and checked:
		self.frame = 1
		checked = false
	
# Called when the node enters the scene tree for the first time.

func _on_next(action: String, tab_index : int) -> void:
	global.sendInfo[info] = checked
	print(info, ": ", global.sendInfo[info])

func clicked():
	pass
