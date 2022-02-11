extends Node2D

func set_value(hearts):
	for i in $health.get_child_count():
		$health.get_child(i).visible = i < hearts

func _on_Player_player_hit(health):
	set_value(health) 
