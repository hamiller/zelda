extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_value(hearts):
	for i in $health.get_child_count():
		$health.get_child(i).visible = i < hearts

func _on_Player_player_hit(health):
	self.set_value(health) 
