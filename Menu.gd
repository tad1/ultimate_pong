extends CanvasLayer

var main_scene = preload("res://Main.tscn")
var actions

var setting_key = false

var selectable = {
	0: "Play",
	1: "Player Select",
	2: "Exit"
}

var select = 0
var action_script
enum ACTIONS {ui_player1_up,ui_player1_down,ui_player1_enter,ui_player2_up,ui_player2_down,ui_player2_enter}

func _ready():
	#set function refs
	var action_1 = funcref(self, "start_game")
	var action_2 = funcref(self, "change_number_of_players")
	var action_3 = funcref(self, "exit")
	
	actions = {
		0: action_1,
		1: action_2,
		2: action_3
	}
	_set_keys()
	
func update_arrow():
	$Arrow.position.y = get_node(selectable[select]).rect_position.y
	
func _input(event):
	if Input.is_action_just_pressed("ui_player1_up") or Input.is_action_just_pressed("ui_player2_up"):
		if select > 0:
			select -= 1
			update_arrow()
		
	if Input.is_action_just_pressed("ui_player1_down") or Input.is_action_just_pressed("ui_player2_down"):
		if select < 2:
			select += 1
			update_arrow()
			
	if Input.is_action_just_pressed("ui_player1_enter") or Input.is_action_just_pressed("ui_player2_enter"):
		#Action
		actions[select].call_func()
		
		


func is_waiting_for_input():
	for j in ACTIONS:
		var temp_node = get_node("HBOX_"+str(j)+"/Button")
		if temp_node.waiting_input == true:
			return true
	return false

func start_game():
	#Play Animation
	get_tree().change_scene_to(main_scene)
	
func change_number_of_players():
	pass

func exit():
	get_tree().quit()

func _set_keys():
	for j in ACTIONS:
		var temp_node = get_node("HBOX_"+str(j)+"/Button")
		temp_node.set_pressed(false)
		temp_node.action = str(j)
		if !InputMap.get_action_list(j).empty():
				temp_node.set_text(InputMap.get_action_list(j)[0].as_text())
			



func _on_menu_hover(index):
	select = index
	update_arrow()


func _handle_label_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
			actions[select].call_func()
