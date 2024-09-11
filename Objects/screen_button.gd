extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.frame = 0
	pass # Replace with function body.


func _on_area_2d_mouse() -> void: # Llamada cuando el mouse SALE/ENTRA al area del documento
	self.frame = 0 if self.frame == 1 else 1
