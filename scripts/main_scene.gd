extends Node2D

## Enables autopopulate function.
@export var autopopulate = true
## Number of rooms in a row.
var x_limit = 5
## Rooms to instantiate.
# var rooms = ["res://objects/room_template.tscn", "res://objects/room_template.tscn","res://objects/room_template.tscn","res://objects/room_template.tscn", "res://objects/room_template.tscn","res://objects/room_template.tscn","res://objects/room_template.tscn", "res://objects/room_template.tscn","res://objects/room_template.tscn","res://objects/room_template.tscn", "res://objects/room_template.tscn","res://objects/room_template.tscn","res://objects/room_template.tscn", "res://objects/room_template.tscn","res://objects/room_template.tscn","res://objects/room_template.tscn", "res://objects/room_template.tscn","res://objects/room_template.tscn","res://objects/room_template.tscn"]
@export var rooms: Array[Resource]
## Position of first room.
var base_location = Vector2(540, 960)

@export var final_room: Resource

var current_room_index: int = 0

func _ready() -> void:
	GlobalFlags.go_to_final_level.connect(load_final_level)
	# Autopopulate rooms.
	if autopopulate:
		var current_location = base_location
		var x_counter = 0
		var y_counter = 0
		for x in range(0, len(rooms)):
			
			# Instance room.
			var roomInstance: Room = rooms[x].instantiate()
			
			# Offset position by half of room.
			if x_counter == 0:
				current_location.y += roomInstance.room_size.y/2
			else:
				if y_counter % 2 == 0:
					current_location.x += roomInstance.room_size.x/2
				else:
					current_location.x -= roomInstance.room_size.x/2
			
			# Set position.
			roomInstance.position = current_location
			roomInstance.modulate = Color(0 ,0, 0)
			$Rooms.add_child(roomInstance)
			
			# Update next position.
			x_counter += 1
			if x_counter < x_limit:
				if y_counter % 2 == 0:
					current_location.x += roomInstance.room_size.x/2
				else:
					current_location.x -= roomInstance.room_size.x/2
			else:
				x_counter = 0
				y_counter += 1
				current_location.y += roomInstance.room_size.y/2
	
	# Initialize camera position.
	$Camera2D.position = $Rooms.get_child(0).position
	
	# # Tween camera between rooms.
	# var allRooms = $Rooms.get_children()
	# for x in range(0, len(allRooms)):
	var room = $Rooms.get_children()[0]
	var tween = get_tree().create_tween()
	tween.set_parallel()
	tween.tween_property($Camera2D, "position", room.position, 0.5)
	tween.tween_property(room, "modulate", Color(1,1,1), 0.5)
	# await tween.finished
	# # Uncomment out the following line for it to wait for room completion.
	# # await room.roomComplete
	# await get_tree().create_timer(1).timeout

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("left"):
		go_left()
	if Input.is_action_just_pressed("right"):
		go_right()

func go_left():
	if (current_room_index == 0): return
	var all_rooms = $Rooms.get_children()

	# get room to move to
	var room = all_rooms[current_room_index - 1]

	var tween = get_tree().create_tween()
	tween.set_parallel()
	tween.tween_property($Camera2D, "position", room.position, 0.5)
	tween.tween_property(all_rooms[current_room_index], "modulate", Color(0,0,0), 0.5)
	tween.tween_property(room, "modulate", Color(1,1,1), 0.5)

	current_room_index -= 1

func go_right():
	if (current_room_index == len(rooms) - 1): return
	var all_rooms = $Rooms.get_children()

	# get room to move to
	var room = all_rooms[current_room_index + 1]

	var tween = get_tree().create_tween()
	tween.set_parallel()
	tween.tween_property($Camera2D, "position", room.position, 0.5)
	tween.tween_property(all_rooms[current_room_index], "modulate", Color(0,0,0), 0.5)
	tween.tween_property(room, "modulate", Color(1,1,1), 0.5)

	current_room_index += 1

func load_final_level() -> void:
	var all_rooms: Array[Node] = $Rooms.get_children()

	var tween = get_tree().create_tween()
	tween.tween_property(all_rooms[current_room_index], "modulate", Color(0,0,0), 0.5)

	await tween.finished

	var saved_position = all_rooms[current_room_index].position
	all_rooms[current_room_index].queue_free()

	var new_room = final_room.instantiate()
	add_child(new_room)
	new_room.position = saved_position

	new_room.modulate = Color(0, 0, 0)
	var tween2 = get_tree().create_tween()
	tween2.tween_property(new_room, "modulate", Color(1, 1, 1), 0.5)
