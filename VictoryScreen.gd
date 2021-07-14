extends Node2D


var menu_scene = load("res://Menu.tscn")

var actions



var select = 0
var selectable = {
	0: "Restart",
	1: "Menu",
	2: "Exit"
}

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	var action_1 = funcref(self, "restart")
	var action_2 = funcref(self, "menu")
	var action_3 = funcref(self, "exit")
	actions = {
		0: action_1,
		1: action_2,
		2: action_3
	}

func _input(event):
	if not is_visible_in_tree():
		return
	
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
		

func show_screen(winner):
	get_tree().paused = true
	$Text.text = winner + " Won!"
	show()

func update_arrow():
	$Arrow.position.y = get_node(selectable[select]).rect_position.y
	
func restart():
	get_tree().paused = false
	get_tree().reload_current_scene()
	
func menu():
	get_tree().paused = false
	get_tree().change_scene_to(menu_scene)
	
func exit():
	get_tree().quit()
