extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Delay_timer_timeout():
	$AnimationPlayer.play("move")
	


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "move":
		queue_free()
