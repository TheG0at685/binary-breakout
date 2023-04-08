extends Node2D

var parts = ["res://level pieces/platforms/Platforms1.tscn", "res://level pieces/platforms/Platforms2.tscn"]
var part_cords = []


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	generate_part()
	generate_part(Vector2(1, 0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player_cord = Vector2()
	player_cord.x = round($Player.position.x/1000)
	player_cord.y = round($Player.position.y/1000)
	if not player_cord in part_cords:
		# Create a new part if the player hasn't been to an area yet
		generate_part(player_cord)
		

func generate_part(cord=Vector2(0, 0), type=rand_choice(parts)):
	"""Cords are automatticly muiltiplied by 1000"""
	var level = load(type).instance()
	add_child(level)
	level.position = cord * 1000
	part_cords.append(cord)
	
func rand_choice(array):
	randomize()
	return array[rand_range(0, len(array))]
