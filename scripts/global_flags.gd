extends Node

var room1_data: Room1Data
var room2_data: Room2Data
var room3_data: Room3Data
var room4_data: Room4Data
var room5_data: Room5Data

var camera: Camera2D

signal key_obtained()
signal go_to_final_level()
signal cat_awakened()
signal enter_room(room_id: int)

func _ready():
    room1_data = Room1Data.new()
    room2_data = Room2Data.new()
    room3_data = Room3Data.new()
    room4_data = Room4Data.new()
    room5_data = Room5Data.new()