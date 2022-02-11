extends StaticBody2D

enum SwortQuest { NOT_STARTED, STARTED, FINISHED }
var sword_quest = SwortQuest.NOT_STARTED
var sword_found = false
var dialoguePopup

func _ready():
	dialoguePopup = get_parent().get_node("HUD/DialogPopup")

func talk():
	print(dialoguePopup)
	if !dialoguePopup.is_visible_in_tree():
		print("NPC angesprochen")
		dialoguePopup.dialog = "Hallo lieber Spieler!"
		dialoguePopup.open()
