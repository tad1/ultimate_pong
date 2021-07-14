extends Node


var hit = {
	0: "Hit1",
	1: "Hit2",
	2: "Hit3",
	3: "Hit4"
} 

var explosion = {
	0: "Explosion1",
	1: "Explosion2"
}

func hit_sfx():
	var temp = randi() % hit.size()
	get_node(hit[temp]).play()
	
func explosion_sfx():
	var temp = randi() % explosion.size()
	get_node(explosion[temp]).play()
