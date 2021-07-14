extends CPUParticles2D


func _ready():
	one_shot = true
	emitting = true

func _process(delta):
	if !emitting:
		queue_free()
