extends StaticBody2D

enum SwortQuest { NOT_STARTED, STARTED, FINISHED }
var sword_quest = SwortQuest.NOT_STARTED
var sword_found = false
var dialoguePopup

func _ready():
	dialoguePopup = get_parent().get_node("CanvasLayer/DialogPopup")

func _input(event):
	if event.is_action_pressed("hack_and_slay"):
		print("NPC geklickt")
		dialoguePopup.close()
	
func talk():
	dialoguePopup.dialog = "Hallo lieber Spieler!"
	dialoguePopup.open()
