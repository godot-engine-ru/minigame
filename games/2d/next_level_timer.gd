extends Timer

func _on_timeout():
	owner.load_level(Game2dSingleton.level+1)

func _ready():
	start()
