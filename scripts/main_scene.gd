extends Node2D

## Enables autopopulate function.
var autopopulate = true
## Number of rooms in a row.
var x_limit = 5
## Rooms to instantiate.
var rooms = ["res://objects/room_template.tscn", "res://objects/room_template.tscn","res://objects/room_template.tscn","res://objects/room_template.tscn", "res://objects/room_template.tscn","res://objects/room_template.tscn","res://objects/room_template.tscn", "res://objects/room_template.tscn","res://objects/room_template.tscn","res://objects/room_template.tscn", "res://objects/room_template.tscn","res://objects/room_template.tscn","res://objects/room_template.tscn", "res://objects/room_template.tscn","res://objects/room_template.tscn","res://objects/room_template.tscn", "res://objects/room_template.tscn","res://objects/room_template.tscn","res://objects/room_template.tscn"]
## Position of first room.
var base_location = Vector2(540, 960)

func _ready() -> void:
	# Autopopulate rooms.
	if autopopulate:
		var current_location = base_location
		var x_counter = 0
		var y_counter = 0
		for x in range(0, len(rooms)):
			
			# Instance room.
			var roomInstance = load(rooms[x]).instantiate()
			
			# Offset position by half of room.
			if x_counter == 0:
				current_location.y += roomInstance.roomSize.y/2
			else:
				if y_counter % 2 == 0:
					current_location.x += roomInstance.roomSize.x/2
				else:
					current_location.x -= roomInstance.roomSize.x/2
			
			# Set position.
			roomInstance.position = current_location
			roomInstance.modulate = Color(0 ,0, 0)
			$Rooms.add_child(roomInstance)
			
			# Update next position.
			x_counter += 1
			if x_counter < x_limit:
				if y_counter % 2 == 0:
					current_location.x += roomInstance.roomSize.x/2
				else:
					current_location.x -= roomInstance.roomSize.x/2
			else:
				x_counter = 0
				y_counter += 1
				current_location.y += roomInstance.roomSize.y/2
	
	# Initialize camera position.
	$Camera2D.position = $Rooms.get_child(0).position
	
	# Tween camera between rooms.
	var allRooms = $Rooms.get_children()
	for x in range(0, len(allRooms)):
		var room = allRooms[x]
		var tween = get_tree().create_tween()
		tween.set_parallel()
		tween.tween_property($Camera2D, "position", room.position, 0.5)
		if x > 0:
			tween.tween_property(allRooms[x - 1], "modulate", Color(0,0,0), 0.5)
		tween.tween_property(room, "modulate", Color(1,1,1), 0.5)
		await tween.finished
		# Uncomment out the following line for it to wait for room completion.
		# await room.roomComplete
		await get_tree().create_timer(1).timeout
