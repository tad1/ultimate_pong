extends Node

var bounce_particle = preload("res://BounceParticle.tscn")
var explosion_particle = preload("res://ExplosionParticle.tscn")

var storedVelocity = Vector2(-50,0)
var game_on = false
var player1_ready = false
var player2_ready = false
var player1_points = 0
var player2_points = 0


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pause()

# Called when the node enters the scene tree for the first time.
func _ready():
	var special1 = InputMap.get_action_list("ui_player1_enter")[0].as_text()
	var special2 = InputMap.get_action_list("ui_player2_enter")[0].as_text()
	
	$Player1Ready/Key.text = "(Press "+special1+")"
	$Player2Ready/Key.text = "(Press "+special2+")"
	
	$Player1Ready.add_color_override("font_color",Color.red)
	$Player2Ready.add_color_override("font_color",Color.red)
	$PauseMenu.hide()
		
	
	randomize()
	$Ball.position = $BallPosition.position
	
	pass # Replace with function body.

func _process(delta):
	
	
	if !player1_ready || !player2_ready:
		$Ball.velocity = Vector2()
		if Input.is_action_pressed("ui_player1_enter"):
			player1_ready = true
			$Player1Ready.text = "ready"
			$Player1Ready.add_color_override("font_color",Color.white)
			
		if Input.is_action_pressed("ui_player2_enter"):
			player2_ready = true
			$Player2Ready.text = "ready"
			$Player2Ready.add_color_override("font_color",Color.white)
			
	else:
		if !game_on:
			game_on = true
			$Ball.velocity = storedVelocity
			$Ball.init()
		
		

func pause():
	$PauseMenu.show()
	get_tree().paused = true

func restart():
	$SoundManager.explosion_sfx()
	var temp_instance = explosion_particle.instance()
	temp_instance.position = $Ball.position
	add_child(temp_instance)
	
	if player1_points >= 10:
		$VictoryScreen.show_screen("Player 1")
	if player2_points >= 10:
		$VictoryScreen.show_screen("Player 2")
	
	$Ball.position = $BallPosition.position
	pass

func player1_score():
	player1_points += 1
	$Player1Score.text = str(player1_points)
	player2_ready = false
	$Player2Ready.text = "not ready"
	$Player2Ready.add_color_override("font_color",Color.red)
	game_on = false
	restart()
	storedVelocity.x = 50

func player2_score():
	player2_points += 1
	$Player2Score.text = str(player2_points)
	player1_ready = false
	$Player1Ready.text = "not ready"
	$Player1Ready.add_color_override("font_color",Color.red)
	game_on = false
	restart()
	storedVelocity.x = -50


func _on_Ball_score(player):
	if player == 1:
		player1_score()
	else:
		player2_score()


func _on_Ball_bounce():
	var temp_instance = bounce_particle.instance()
	temp_instance.position = $Ball.position
	add_child(temp_instance)
