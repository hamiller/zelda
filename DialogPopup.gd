extends Popup

var dialog setget dialogue_set

# In its default state (hidden), this panel should not receive input. 
# So, in the _ready() function, we must call the set_process_input() 
# function to disable input handling:
func _ready():
	set_process_input(false)
	
func open():
	get_tree().paused = true
	toggle_input_for_all_player(false)
	set_process_input(true)
	popup()
	
func close():
	get_tree().paused = false
	toggle_input_for_all_player(true)
	set_process_input(false)
	hide()

func toggle_input_for_all_player(enabled):
	for node in get_tree().get_nodes_in_group("PLAYER"):
		node.set_process_input(enabled)

func dialogue_set(data):
	$Dialog.text = data
	
func _input(event):
	if event.is_action_pressed("hack_and_slay"):
		close()
