extends Node

signal crosshair_entered_enemy
signal crosshair_exited_enemy

enum GunTypes {
	PISTOL,
	AUTO,
	GRENADE,
	#..
}

# сейчас очень упрощенно
# walk - мирно гуляет, патрулирует (можно назвать patrol)
# run - гонится за игроком (можно назвать chase)
# attack - атакует.
enum NpcStates {
	IDLE,
	WALK,
	RUN,
	ATTACK,
}

signal hp_changed(new_hp, old_hp)
signal hp_is_0


signal npc_dead(npc)

signal game_over


var player:KinematicBody

# gun_type = см. GunTypes
signal shoot_gun(gun_type)

# npc - нода зомби (Kinematic)
# state - int состояние (идет, бежит, атакует..)
signal npc_state_changed(npc, state)


signal ladder_entered
signal ladder_exited

signal weapon_reload_started
signal weapon_reload_finished


var current_weapon

# варианты состояний стрельбы
enum ShootStates {
	CAN_SHOOT,
	NO_AMMO,
	NO_WEAPON,
	RELOADING,
	COOLDOWN,
	
}
var shoot_state = ShootStates.CAN_SHOOT

# пул объектов, например боеприпасы:
# игрок зашел в Area боеприпаса - получил патроны, сцену Ammo-бокса удалили из дерева
# и добавляем ее напр по таймеру
var pool = {}


var is_mouse_visible = false


func reload_game():
	get_tree().call_group("npc", "free")
#	get_tree().reload_current_scene()

#	get_tree().change_scene("res://level/test_level2_nav.tscn")
	get_tree().change_scene_to(preload("res://level/minigame.tscn"))


func _input(event):
	event = event as InputEventKey
	if not event or not event.pressed: return
	if event.scancode == KEY_F5:
		get_tree().set_input_as_handled()
		reload_game()
		return


	if Input.is_action_just_pressed("ui_cancel"):
		if Minigame.visible:
			Minigame.quit_minigame()
			return

		match Input.get_mouse_mode():
			Input.MOUSE_MODE_VISIBLE:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				is_mouse_visible = false
#				get_tree().paused = false

			Input.MOUSE_MODE_CAPTURED:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				is_mouse_visible = true
#				get_tree().paused = true



func _ready():
	connect("weapon_reload_started", self, "_on_weapon_reload_started")
	connect("weapon_reload_finished", self, "_on_weapon_reload_finished")


func _on_weapon_reload_started():
	shoot_state = ShootStates.RELOADING
	

func _on_weapon_reload_finished():
	shoot_state = ShootStates.CAN_SHOOT


		
