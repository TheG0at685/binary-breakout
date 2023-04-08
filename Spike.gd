extends KinematicBody2D


var up = false
# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	$Collision/CollisionShape2D.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Delay_timer_timeout():
	$Collision/CollisionShape2D.disabled = false
	visible = true
	up = true
	
func hide():
	$Collision/CollisionShape2D.disabled = true
	visible = false
	if up:
		$"Hide timer".start()
	



func _on_Hide_timer_timeout():
	queue_free()
