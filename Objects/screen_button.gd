extends AnimatedSprite2D

@export var buttonName : String
@export var tab_index : int

signal was_clicked(buttonName : String, tab_index : int)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.frame = 0



func _on_area_2d_mouse() -> void:
	self.frame = int(!self.frame)


func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("Click") and !!self.frame:
		self.frame = 3
	if Input.is_action_just_released("Click") and !!self.frame:
		self.frame = 1
		clicked()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func clicked() -> void: #TODO Señal para pasar a la siguiente tab
	was_clicked.emit(buttonName, tab_index)
	
