extends AnimatedSprite2D

@export var checked : bool = false
@export var info : String
var enable : bool = false

#frame 0 = default
#frame 1 = hover
#frame 2 = checked
#frame 3 = hover + checked

func _on_area_2d_mouse() -> void:
	enable = !enable
	self.frame = 1 if enable else 0
	self.frame = 3 if enable and checked == true else self.frame
	self.frame = 2 if enable == false and checked == true else self.frame


func _input(_event: InputEvent) -> void:
	if enable and Input.is_action_just_released("Click"):
		checked = !checked
		self.frame = 3 if checked else 1


func _on_next(_action: String, _tab_index : int) -> void:
	global.sendInfo[info] = checked
	checked = false
	self.frame = 0

func clicked():
	pass
