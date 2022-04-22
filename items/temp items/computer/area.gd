extends Area

func _ready():
	set_process_input(false)

func _on_body_entered(body:KinematicBody):
	if body and body.is_in_group("player"):
		
		$"../../Control".visible = true
		set_process_input(true)


func _on_body_exited(body):
	if body and body.is_in_group("player"):
		
		$"../../Control".visible = false
		set_process_input(false)

func _input(event):
	if Input.is_action_just_pressed("Interact"):
		if Minigame.visible: return

		Minigame.start_minigames()

		$"../../Control".visible = false
