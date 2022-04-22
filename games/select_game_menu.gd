extends PopupMenu




func _on_index_pressed(index:int):
	Minigame.start_minigame(Minigame.games_paths[index])

