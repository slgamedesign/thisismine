extends Node2D

var draggable: bool # variable estática para saber si se puede arrastrar o no
@export var readingWindow : TileMapLayer # Pop-up del documento para leer
@export var textArea : RichTextLabel # Texto del Pop-up
var offset : Vector2

var docs = preload("res://Prompts/Documents.gd").new()

var sues : Array = docs.sue.map(func (doc) -> Dictionary : return {
	"text" : doc["text"],
	"license" : doc["license"],
})
var statements : Array = docs.statements


# correct_responses / Infractions
var infractions = docs.sue.map(
	func (doc) -> Dictionary: return {
		"license": doc["license"],
		"att": doc["att"],
		"sa": doc["sa"],
		"nc": doc["nc"],
		"nd": doc["nd"],
		"app": true
		}
	)


var randSt : int
# Añade el objeto al grupo "Draggable" para organizar
func _ready() -> void:
	draggable = false

	# TODO HACER UN SISTEMA PARA ALMACENAR EN CADA DOCUMENTO SI ES PARA APROBAR O NO
	
	change_text_pop_up()
	
	# Esconde el Pop-up
	readingWindow.hide()
	add_to_group("Draggable", true) # Añande el objeto al grupo Draggable para organización


func change_text_pop_up() -> void:
	textArea.clear()
	
	# Añade el texto al Pop-up
	if randi_range(0,100) < 25:
		
		randSt = randi_range(1, statements.size()-1)
	else:
		randSt = 0
	
	var randSue = randi_range(0, sues.size()-1)
	
	textArea.append_text(statements[randSt]["text"] + statements[randSt]["license"] + "\n")
	textArea.append_text(sues[randSue]["text"] + sues[randSue]["license"])
	
	
	#se envian a las variable global 
	#las respuestas correctas de la ronda jugada 
	#para compararlas con las respuestas de jugador
	if (statements[randSt]["license"] == sues[randSue]["license"] or 
	statements[randSt]["license"] == "all"):
		global.correct_responses.append(infractions[randSue])
	else:
		global.correct_responses.append({
			"license" : statements[randSt]["license"], 
			"att" : false, 
			"sa" : false, 
			"nc" : false, 
			"nd" : false, 
			"app" : false})
	
	print(global.correct_responses)


func _on_area_2d_mouse_entered() -> void: # Llamada cuando el mouse ENTRA al area del documento
	draggable = false if global.isdragging else true


func _on_area_2d_mouse_exited() -> void: # Llamada cuando el mouse SALE al area del documento
	draggable = false


func show_document() -> void:
	textArea.move_to_front()
	readingWindow.global_position = Vector2(573, 324)
	readingWindow.show()


func move_document() -> void:
	self.z_index = 4090 # Mueve el objeto para que se renderize arriba de cualquier otro
	global_position = get_global_mouse_position() # Mueve el objeto arrastrado a la posición del mouse
	global.isdragging = true # Se informa que se arrastra un objeto
	# Limita el área de movimiento del objeto
	global_position.y = clampf(global_position.y - offset.y, 382 + get_child(1, true).get_child(0).shape.extents.y / 2, 650 - get_child(1, true).get_child(0).shape.extents.y / 2)
	global_position.x = clampf(global_position.x - offset.x, get_child(1, true).get_child(0).shape.extents.x / 2, 700 - get_child(1, true).get_child(0).shape.extents.x / 2)


func _input(_evt: InputEvent) -> void:
	if Input.is_action_just_pressed("Click") and draggable:
		offset = -Vector2(global_position - get_global_mouse_position())
	
	if Input.is_action_pressed("Click") and draggable: # Si el click está presionado
		move_document()
		
	if Input.is_action_just_released("Click") and global.isdragging: # Si se está arrastrando algo y se suelta el mouse
		global.isdragging = false # Se informa que ya no se arrastra nada
		
	if Input.is_action_pressed("rClick") and draggable:
		show_document()
	
	elif Input.is_action_just_released("rClick"):
		readingWindow.hide()


func _on_app_or_napp(_buttonName: String, _tab_index: int) -> void:
	change_text_pop_up()
