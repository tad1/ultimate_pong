
extends Area2D

signal deflect

export var player_no = 1

export var speed = 100
export var palete_width = 400 setget change_size
var velocity = Vector2()
var screen_size

func change_size(new_size):
	palete_width = new_size
	scale.y = new_size

func _ready():
	screen_size = get_viewport_rect().size
	change_size(palete_width)



func _process(delta):
	
	velocity = Vector2()
	
	if Input.is_action_pressed("ui_player"+str(player_no)+"_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_player"+str(player_no)+"_down"):
		velocity.y += 1
	
	velocity = velocity * speed
	position.y += velocity.y * delta
	position.y = clamp(position.y, 0, screen_size.y)


func _on_Palete_body_entered(body):
	emit_signal("deflect", velocity.y)
