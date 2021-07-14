extends RigidBody2D

signal score
signal bounce

export var size = 10
export var speed = 500
export var max_y_speed = 300
var velocity = Vector2()
var screen_size

func change_size(new_size):
	$Sprite.scale = Vector2(new_size, new_size)
	$CollisionShape2D.scale = Vector2(new_size, new_size)
	

	
func _ready():
	screen_size = get_viewport_rect().size
	change_size(size)
	
	

func init():
	speed = 500
	#velocity.x = randi() % 100 - 50
	velocity.y = randi() % 100 - 50
	velocity = velocity.normalized()
	
func start(position):
	position = position
	
	
func _physics_process(delta):
	#update position
	position += velocity * delta * speed
	#check collisions
	if position.y < 0:
		#position.y += screen_size.y
		velocity.y = -velocity.y
		
		emit_signal("bounce")
	elif position.y > screen_size.y:
		#position.y -= screen_size.y
		velocity.y = -velocity.y
		emit_signal("bounce")
	
	if position.x < 0:
		emit_signal("score",2)
	elif position.x > screen_size.x:
		emit_signal("score",1)


func bounce_vertical():
	velocity.y = -velocity.y
	
func bounce_horizontal():
	velocity.x = -velocity.x

func calculate_angle(pos):
	var delta_x = pos.x - position.x
	var delta_y = pos.y - position.y
	var theta_rad = atan2(delta_x, delta_y)
	theta_rad -= rotation
	return theta_rad
	pass
	




func _on_Palete_body_entered(pad_speed):
	velocity.x = -velocity.x
	velocity.y += pad_speed / 1800
	velocity.y = clamp(velocity.y, -max_y_speed, max_y_speed)
	emit_signal("bounce")
	
	speed += speed * 0.1


func _on_player2_deflect():
	pass # Replace with function body.


