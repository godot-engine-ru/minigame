extends Label

func _ready():
	Game2dSingleton.connect("ball_missed", self, "on_ball_missed")

func on_ball_missed():
	text = "Пропущено: %d"%Game2dSingleton.missed
