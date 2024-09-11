extends AnimatedSprite2D

var ontop : bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.frame = 0
	pass # Replace with function body.

func _on_area_2d_mouse_entered() -> void:
	self.frame = 1
	ontop = true
	pass # Replace with function body.


func _on_area_2d_mouse_exited() -> void:
	self.frame = 0
	ontop = false
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("Click") and ontop:
		self.frame = 3
	if Input.is_action_just_released("Click") and ontop:
		self.frame = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func clicked(): #TODO Señal para pasar a la siguiente tab
	pass
