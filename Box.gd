extends Node3D

func _ready():
	pass

func _process(delta):
	pass

func createBox(boxUp, boxDown, boxRight, boxLeft, fieldArray):
		$WallUp.visible = boxUp
		$WallUp/StaticBody3D/CollisionShape3D.disabled = !boxUp
		
		$WallDown.visible = boxDown
		$WallDown/StaticBody3D/CollisionShape3D.disabled = !boxDown
		
		$WallRight.visible = boxRight
		$WallRight/StaticBody3D/CollisionShape3D.disabled = !boxRight
		
		$WallLeft.visible = boxLeft
		$WallLeft/StaticBody3D/CollisionShape3D.disabled = !boxLeft
	
		#if fieldArray.isVisited:
			#print(fieldArray.isVisited)
			#$Floor.get_surface_override_material(0).albedo_color = Color(0, 255, 0, 1.0)
		#else:
			#$Floor.get_surface_override_material(0).albedo_color = Color(0, 0, 0, 1.0)
