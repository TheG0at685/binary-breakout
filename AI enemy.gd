extends Node2D

onready var player = get_tree().current_scene.get_node("Player")

# How many frames into the future are we predicting
# The higher the number, the less acurat and less common the prediction will be
const future_check = 10
var checking = false
var prediction
var counter = future_check

func _ready():
	pass
	
func _process(delta):
	if not checking:
		prediction = predict_player_location()
		checking = true
	else:
		if counter > 0:
			counter -= 1
		else:
			$trap.position = prediction
			checking = false
			counter = future_check
		
			
		
	
func predict_player_location():
	return player.position + (player.vel/20) * future_check/2

