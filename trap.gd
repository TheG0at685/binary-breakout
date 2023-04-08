extends Area2D


export var saw_trap = false
export var spike_trap = true
export var muilt_trap = true
export var delay = 0.25
onready var player = get_tree().current_scene.get_node("Player")
onready var spike_path = "res://level pieces/obsticles/Spike.tscn"
onready var spike = load(spike_path).instance()
onready var saw_path = "res://level pieces/obsticles/Saw.tscn"
onready var saw = load(saw_path).instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if overlaps_body(player):
		if muilt_trap:
			# Use muiltiple ifs instead of if, elif to trigger muiltiple traps
			if spike_trap and not spike in get_children():
				# Make sure that the original path isn't freed when spike is deleted
				spike = load(spike_path).instance()
				add_child(spike)
				spike.get_node("Delay timer").wait_time = delay
				spike.get_node("Delay timer").start()
			if saw_trap and not saw in get_children():
				saw = load(saw_path).instance()
				add_child(saw)
				saw.get_node("Delay timer").wait_time = delay
				saw.get_node("Delay timer").start()
	else:
		# Delete traps after the player has left their range
		for child in get_children():
			if child == spike and child.get_node("Hide timer").time_left == 0:
				child.get_node("Hide timer").start()
			
	
	
				
				
		
				
