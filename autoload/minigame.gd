extends Node2D

var games_paths: = []

var games_states = {}


func _ready():
	var games_path = "res://games"
	var games_folders = Utils.get_folders(games_path)
	for f in games_folders:
		games_paths.push_back(games_path.plus_file(f).plus_file("game.tscn"))
	
	var games_popup:PopupMenu = get_node("PopupMenu")
	games_popup.clear()

	for path in games_paths:
		path = path as String
		games_popup.add_item(path.get_base_dir().get_file())




func quit_minigame():
	var game = get_node_or_null("Game")
	if game:
		games_states[game.filename] = game.get_state()
	
	$CanvasLayer.visible = false
	
	if visible:
		if game:
			game.queue_free()
		visible = false
		
		if Input.get_mouse_mode() ==Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			Game.is_mouse_visible = false
	else:
		if game:
			print("GAME EXISTS")

	Game.player.propagate_call("set_process_input",[true])
	Game.player.propagate_call("set_physics_process",[true])

func start_minigames():
	var games_popup:PopupMenu = get_node("PopupMenu")

	visible  = true
	games_popup.popup_centered()

	if Input.get_mouse_mode() !=Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		Game.is_mouse_visible = true





func start_minigame(file_name:String):

	visible = true
	$CanvasLayer.visible = true
	
	Game.player.propagate_call("set_process_input",[false])
	Game.player.propagate_call("set_physics_process",[false])

	var game:Node = load(file_name).instance()
	game = game as Node2D
	add_child(game)

	var game_state = games_states.get(file_name, {})
	if not game_state:
		games_states[game_state] = game_state

	game.load_game(game_state)

