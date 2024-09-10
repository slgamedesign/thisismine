extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN) # Se esconde el mouse al iniciar el juego


func _input(evt) -> void:
	# Setea la posición del objeto Cursor a la posición del Mouse
	global_position = get_global_mouse_position()
	self.move_to_front()
	
	if evt is InputEventMouseButton: 
		# Selecciona sprite del cursor si se hace click o no
		self.frame = int(evt.button_index == MOUSE_BUTTON_LEFT and evt.pressed)
