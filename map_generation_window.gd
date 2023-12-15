extends Window

var fieldResource = preload("res://field.tscn")
var boxesNumber = 30
var fieldsArray = []

func _ready():
	for i in boxesNumber:
		fieldsArray.append([])
		for j in boxesNumber:
			var newField = fieldResource.instantiate()
			add_child(newField)
			newField.position.x = (30*j) + 70
			newField.position.y = (30*i) + 70
			fieldsArray[i].append([])
			fieldsArray[i][j] = newField

func showInWindow(pointX, pointY):
	fieldsArray[pointY][pointX].texture = load("res://assets/zona1.png")
	fieldsArray[pointY][pointX].isVisited = true

func _on_close_requested():
	self.queue_free()

