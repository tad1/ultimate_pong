extends Button

var action = "player_up"
export var key = "W"
var value

var waiting_input = false

func _ready():
	text = key
	value = ord(key)
	

func _change_key(new_key):
	#Delete Previous key
	if !InputMap.get_action_list(action).empty():
		InputMap.action_erase_event(action, InputMap.get_action_list(action)[0])
		
	#Unassign conflicts
	
		
	#Add New Key
	InputMap.action_add_event(action,new_key)
	

func _input(event):
	if waiting_input:
		if event is InputEventKey:
			value = event.scancode
			text = OS.get_scancode_string(value)

			#change the key
			_change_key(event)
			
			
			pressed = false
			waiting_input = false
			$Timer.stop()
		if event is InputEventMouseButton:
			text = OS.get_scancode_string(value)
			pressed = false
			waiting_input = false
			$Timer.stop()
			pass

func _on_Player1Special_button_up():
	waiting_input = true
	text = "_"
	$Timer.start()


func _on_Timer_timeout():
	text = "_" if text == " " else " "
