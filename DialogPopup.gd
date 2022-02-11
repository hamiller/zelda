extends Popup

var dialog setget dialogue_set

# In its default state (hidden), this panel should not receive input. 
# So, in the _ready() function, we must call the set_process_input() 
# function to disable input handling:
func _ready():
	set_process_input(false)
	
func open():
	get_tree().paused = true
	set_process_input(true)
	popup()
	
func close():
	get_tree().paused = false
	set_process_input(false)
	hide()

func dialogue_set(data):
	$Dialog.text = data
	
func _input(event):
	if event.is_action_pressed("hack_and_slay"):
		print("Im dialog space, so closing it.")
		close()
