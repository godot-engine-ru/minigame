extends Node2D

# ===== API ======

# имя сцены с игрой должно быть game.tscn
# имя скрипта должно быть game.gd
# все буквы строчные!

# будет так в списке игр
const game_name = "Стреляй в блоки!"

# game_state =  недавнее состояние игры, с которого можно начать игру (номер уровня или данные недавнего чекпоинта)
# а также кастомные данные, типа лучший рекорд,
# в game_state поддерживаются только числа, строки, Vector2D, Vector3D, массив, словарь.
# простейший словарь game_state это {level = 1}
# get_state() и load_game() - виртуальные функции, их нужно создать, их будет вызывать основная игра (Шутер)

func get_state()->Dictionary:
	return {level = Game2dSingleton.level}


func load_game(game_state:={}):
	for node in get_tree().get_nodes_in_group("2d_balls"):
		node.queue_free()

	var level

	if game_state:
		# обычный случай, когда game_state словарь заполнен какими-то данными (не пустой)
		level = game_state.level

	else:
		# при первом запуске миниигры game_state - пустой словарь (*)
		# значит игру надо запустить с самого начала
		# этот случай надо обязательно учесть!
		
		level = 1

		# (*) сохранение состояний миниигр пока не реализовано,
		# то есть при кадом запуске основной игры (ЗомбиШутера) будем играть с самого начала
		# в настройках миниигры нужен выбор любого чекпоинта, с которого можно запустить игру.

	load_level(level)

	$Timer.start()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	get_node("Camera2D").make_current()

# ===========================================



func load_level(level:int):
	Game2dSingleton.level = level
	Game2dSingleton.emit_signal("level_changed")

	Game2dSingleton.missed = 0
	Game2dSingleton.emit_signal("ball_missed")


# миниигра сама не начинается!
# она запускается системой миниигр, с помощью вызова load_game()
func _ready():
	return
#	load_game() # так не надо!


func _on_Timer_timeout():
	var ball = preload("res://games/2d/ball.tscn").instance()
	add_child(ball)


func _on_Area2D_body_entered(body):
	Game2dSingleton.missed+=1
	Game2dSingleton.emit_signal("ball_missed")
	body.queue_free()

	if Game2dSingleton.missed == 3:
		load_level(Game2dSingleton.level)
