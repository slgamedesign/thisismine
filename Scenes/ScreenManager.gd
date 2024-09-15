extends Node2D

@export var licTab : Node2D
@export var infTab : Node2D
var tabs : Array[Node]


func _ready() -> void:
	tabs = get_children(false)
	_on_button_was_clicked("", 0)

#Hace el cambio de tabs a partir de un indice
func _on_button_was_clicked(_buttonName : String, tab_index : int) -> void:
	tabs.map(
		func (tab):
			if tab == tabs[tab_index]:
				tab.show()
			else:
				tab.hide())

#informa la licencencia a la variable global
func send_license(buttonName : String, _tab_index : int) -> void:
	global.sendInfo["license"] = buttonName
	print("license: ", global.sendInfo["license"])

#informa si fue aprovada a la variable global
func is_approved(buttonName : String, _tab_index : int) -> void:
	global.sendInfo["app"] = !!buttonName
	print("app: ", global.sendInfo["app"])
