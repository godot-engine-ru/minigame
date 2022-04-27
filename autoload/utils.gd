tool
extends Node

static func dir_contents(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")


static func get_folders(path:String):
	var dirs: = []
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin(true, true)
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				dirs.push_back(file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return dirs

static func get_files(path:String):
	var files: = []
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin(true, true)
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				files.push_back(file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return files
