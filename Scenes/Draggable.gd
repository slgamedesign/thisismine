extends Node2D

var draggable: bool # variable estática para saber si se puede arrastrar o no
@export var readingWindow : TileMapLayer # Pop-up del documento para leer
@export var textArea : RichTextLabel # Texto del Pop-up
var offset : Vector2

const Docs = preload("res://Prompts/Documents.gd")
var sourceArray = Docs.new().docs

# Añade el objeto al grupo "Draggable" para organizar
func _ready() -> void:
	draggable = false

	# TODO HACER UN SISTEMA PARA ALMACENAR EN CADA DOCUMENTO SI ES PARA APROBAR O NO

	# Añade el texto al Pop-up
	textArea.append_text(sourceArray[randi_range(0, 5)] + "\n")
	textArea.append_text(sourceArray[randi_range(6, 11)])
	
	# Esconde el Pop-up
	readingWindow.hide()
	add_to_group("Draggable", true) # Añande el objeto al grupo Draggable para organización


func _on_area_2d_mouse() -> void: # Llamada cuando el mouse SALE/ENTRA al area del documento
	if not global.isdragging: # Si no se está arrastrando algo...
		draggable = !draggable # (deja de) arrastrar el objeto que está debajo del mouse


func show_document() -> void:
	textArea.move_to_front()
	readingWindow.global_position = Vector2(573, 324)
	readingWindow.show()


func move_document():
	self.move_to_front() # Mueve el objeto para que se renderize arriba de cualquier otro
	global.isdragging = true # Setea la variable global que algo está siendo arrastrado
	global_position = get_global_mouse_position() # Mueve el objeto arrastrado a la posición del mouse
	# Limita el área de movimiento del objeto
	global_position.y = clampf(global_position.y - offset.y, 382 + get_child(1, true).get_child(0).shape.extents.y / 2, 650 - get_child(1, true).get_child(0).shape.extents.y / 2)
	global_position.x = clampf(global_position.x - offset.x, get_child(1, true).get_child(0).shape.extents.x / 2, 700 - get_child(1, true).get_child(0).shape.extents.x / 2)


func _input(_evt: InputEvent) -> void:
	
	if Input.is_action_pressed("Click") and draggable: # Si el click está presionado
		move_document()
		
	if Input.is_action_just_pressed("Click") and draggable:
		offset = -Vector2(global_position - get_global_mouse_position())
		
	elif Input.is_action_just_released("Click") and global.isdragging: # Si se está arrastrando algo y se suelta el mouse
		global.isdragging = false # Se informa que ya no se arrastra nada
		
	if Input.is_action_pressed("rClick") and draggable:
		show_document()
	
	elif Input.is_action_just_released("rClick"):
		readingWindow.hide()
