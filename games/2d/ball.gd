extends KinematicBody2D

var speed

func _init():
	set_physics_process(false)

func _ready():
	var size = get_viewport_rect().size
	speed = rand_range(1.0, 5.0)*Game2dSingleton.level*Game2dSingleton.speed_multiplier

	position.x = randi()%int(size.x)

	set_physics_process(true)

	scale.x *=rand_range(1.0, 10)

func _on_input_event(viewport, event, shape_idx):
	event = event as InputEventMouseButton
	if not event or not event.pressed: return
	
	print("bam!")

	queue_free()

func _physics_process(delta):
	move_and_slide(Vector2(0,10)*speed)


