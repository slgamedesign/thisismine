extends Node2D

var draggable = false # variable estática para saber si se puede arrastrar o no
@export var readingWindow : TileMapLayer # Pop-up del documento para leer
@export var textArea : RichTextLabel # Texto del Pop-up
var offset : Vector2

# Añade el objeto al grupo "Draggable" para organizar
func _ready():
	# Abre Documents.txt con los prompts
	var textSource = FileAccess.open("res://Prompts/Documents.txt", FileAccess.READ).get_as_text(true)
	# Separa por renglones todo el archivo y los guarda como un array de Strings
	
	# NOTA	TIENE EN PARENTESIS A QUE CORRESPONDE PARA DEBUGAR
	# TODO HACER UN SISTEMA PARA ALMACENAR EN CADA DOCUMENTO SI ES PARA APROBAR O NO
	var sourceArray = Array(textSource.split("\n"))
	# DEBUG
	print(sourceArray[0])
	# Añade el texto al Pop-up
	textArea.append_text(sourceArray[randi_range(0, 5)] + "\n")
	textArea.append_text(sourceArray[randi_range(6, 11)])
	
	# Esconde el Pop-up
	readingWindow.hide()
	add_to_group("Draggable", true) # Añande el objeto al grupo Draggable para organización

func _on_area_2d_mouse(): # Llamada cuando el mouse SALE/ENTRA al area del documento
	if not global.isdragging: # Si no se está arrastrando algo...
		draggable = !draggable # (deja de) arrastrar el objeto que está debajo del mouse

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Click") and draggable:
		offset = -Vector2(global_position - get_global_mouse_position())
	
	if Input.is_action_pressed("Click") and draggable: # Si el click está presionado
		self.move_to_front() # Mueve el objeto para que se renderize arriba de cualquier otro
		global.isdragging = true # Setea la variable global que algo está siendo arrastrado
		global_position = get_global_mouse_position() # Mueve el objeto arrastrado a la posición del mouse
		# Limita el área de movimiento del objeto
		global_position.y = clampi(global_position.y - offset.y, 382 + get_child(1, true).get_child(0).shape.extents.y / 2, 650 - get_child(1, true).get_child(0).shape.extents.y / 2)
		global_position.x = clampi(global_position.x - offset.x, get_child(1, true).get_child(0).shape.extents.x / 2, 700 - get_child(1, true).get_child(0).shape.extents.x / 2)
		
		print(global_position) # DEBUG
	elif Input.is_action_just_released("Click") and global.isdragging: # Si se está arrastrando algo y se suelta el mouse
		global.isdragging = false # Se informa que ya no se arrastra nada
		
	if Input.is_action_pressed("rClick") and draggable:
		textArea.move_to_front()
		readingWindow.global_position = Vector2(573, 324)
		readingWindow.show()
	elif Input.is_action_just_released("rClick"):
		readingWindow.hide()
	
