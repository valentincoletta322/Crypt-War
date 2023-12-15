extends Control

var random = RandomNumberGenerator.new()
var boxResource = preload("res://scenes/box.tscn")

var window
var generationWindow = preload("res://map_generation_window.tscn")

var boxesRemaining = (boxesNumber*boxesNumber) -1
const boxesNumber = 30
var boxesVisited = []
var wallNorth = []
var wallSouth = []
var wallEast = []
var wallWest = []

var pointX = 0
var pointY = 0

func _ready():
	
	get_viewport().set_embedding_subwindows(false)
	window = generationWindow.instantiate()
	add_child(window)
	window.visible = true
	window.position = Vector2(400, 40)
	window.size = Vector2(1000,1000)
	
	generateMap()
	generateWalls()

func _process(delta):
	pass
	
func generateMap():
	pointX = random.randi_range(0, boxesNumber-1)
	pointY = random.randi_range(0, boxesNumber-1)
	
	for i in boxesNumber:
		boxesVisited.append([])
		wallNorth.append([])
		wallSouth.append([])
		wallEast.append([])
		wallWest.append([])
		for j in boxesNumber:
			boxesVisited[i].append(false)
			wallNorth[i].append(true)
			wallSouth[i].append(true)
			wallEast[i].append(true)
			wallWest[i].append(true)
			
	boxesVisited[pointX][pointY] = true
	window.showInWindow(pointX, pointY)
	
	generateRooms()
	#generateMaze()
					
func generateWalls():
	
	#Generate the boxes on the 3D plane.
	for i in boxesNumber:
		for j in boxesNumber:
			var boxInstance = boxResource.instantiate()
			var boxUp = wallNorth[i][j]
			var boxDown = wallSouth[i][j]
			var boxRight = wallEast[i][j]
			var boxLeft = wallWest[i][j]
			
			boxInstance.createBox(boxUp, boxDown, boxRight, boxLeft, window.fieldsArray[i][j])
			boxInstance.position = Vector3(5.5*i, 0, 5.5*j) 
			boxInstance.scale = Vector3(3, 3, 3)
			add_child(boxInstance)

func generateMaze():
	
	#Generation of the maze
	while boxesRemaining > 0:
		
		var randomMovement = random.randi_range(0, 3)
		
		if randomMovement == 0:
			if pointX+1 <= boxesNumber-1:
				if boxesVisited[pointX+1][pointY] == false:
					boxesVisited[pointX+1][pointY] = true
					wallWest[pointX+1][pointY] = false
					wallEast[pointX][pointY] = false
					pointX += 1
					boxesRemaining -= 1
					window.showInWindow(pointX, pointY)
				
				else:
					pointX += 1
				
		elif randomMovement == 1:
			if pointY+1 <= boxesNumber-1:
				if boxesVisited[pointX][pointY+1] == false:
					boxesVisited[pointX][pointY+1] = true
					wallNorth[pointX][pointY+1] = false
					wallSouth[pointX][pointY] = false
					pointY += 1
					boxesRemaining -= 1
					window.showInWindow(pointX, pointY)
				
				else:
					pointY += 1
					
		elif randomMovement == 2:
			if pointX-1 >= 0:
				if boxesVisited[pointX-1][pointY] == false:
					boxesVisited[pointX-1][pointY] = true
					wallEast[pointX-1][pointY] = false
					wallWest[pointX][pointY] = false
					pointX -= 1
					boxesRemaining -= 1
					window.showInWindow(pointX, pointY)
				
				else:
					pointX -= 1
					
		elif randomMovement == 3:
			if pointY-1 >= 0:
				if boxesVisited[pointX][pointY-1] == false:
					boxesVisited[pointX][pointY-1] = true
					wallSouth[pointX][pointY-1] = false
					wallNorth[pointX][pointY] = false
					pointY -= 1
					boxesRemaining -= 1
					window.showInWindow(pointX, pointY)
				
				else:
					pointY -= 1
	
	
func generateRooms():
	
	#Generation of the "big rooms"
	var bigRooms = random.randi_range(3, 3)
	print("Cantidad de rooms: ", bigRooms)
	
	for i in bigRooms:
		var sizeRoom = random.randi_range(3, 6)
		var roomCreated = false
		
		while roomCreated == false:
			var randomX = random.randi_range(0, boxesNumber-1)
			var randomY = random.randi_range(0, boxesNumber-1)
			
			if (randomX+sizeRoom-1 < boxesNumber) and (randomX-sizeRoom-1 > 0) and (randomY+sizeRoom-1 < boxesNumber) and (randomY-sizeRoom-1 > 0):
				roomCreated = true
				var randomWallCompass = random.randi_range(0, 3)
				var randomWall = random.randi_range(0, sizeRoom-1)
				
				for j in range(sizeRoom):
					for k in range(sizeRoom):
						if j != 0:
							wallNorth[(randomX-1)+k][(randomY-1)+j] = false
						if j != sizeRoom-1:
							wallSouth[(randomX-1)+k][(randomY-1)+j] = false
						if k != 0:
							wallWest[(randomX-1)+k][(randomY-1)+j] = false
						if k != sizeRoom-1:
							wallEast[(randomX-1)+k][(randomY-1)+j] = false
						
						if boxesVisited[(randomX-1)+k][(randomY-1)+j] == false:
							boxesVisited[(randomX-1)+k][(randomY-1)+j] = true
							boxesRemaining -= 1
							
						window.showInWindow((randomX-1)+k, (randomY-1)+j)
