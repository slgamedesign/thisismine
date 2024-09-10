extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.frame = 0
	pass # Replace with function body.

func _on_area_2d_mouse() -> void: # Llamada cuando el mouse SALE/ENTRA al area del documento
	if self.frame == 0:
		self.frame = 1
	elif self.frame == 1:
		self.frame = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
