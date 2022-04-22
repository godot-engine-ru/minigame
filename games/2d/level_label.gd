extends Label

func _ready():
	Game2dSingleton.connect("level_changed", self, "on_level_changed")

func on_level_changed():
	text = "Уровень: %d"%Game2dSingleton.level
