extends Timer



func _ready():
	pass

func _on_timeout():
	start(randi()%20*0.3)
	
func stop():
	disconnect("timeout", self, "_on_timeout")
