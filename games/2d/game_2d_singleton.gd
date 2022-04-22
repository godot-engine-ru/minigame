extends Node

var level = 1
#const speed_multiplier = 0.5
const speed_multiplier = 1

var missed = 0

signal ball_missed()
signal level_changed()

func _ready():
	# на самом деле рандомизировать уже не надо
	randomize()
