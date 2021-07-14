tool
extends Area2D


export var size = Vector2() setget change_size


func change_size(new_size):
	size = new_size
	$Sprite.scale = new_size
	$CollisionShape2D.scale = new_size



func _ready():
	change_size(size)
	pass
