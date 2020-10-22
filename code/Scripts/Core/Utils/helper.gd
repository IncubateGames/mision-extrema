extends Node

func _init():
	add_to_group("helper")

func instance_root(origin,target,object):
	var direction = origin.direction_to(target)
	object.global_position = origin + direction * 40.0
	object.rotation = direction.angle()
	get_tree().get_root().call_deferred("add_child",object)

func blood_splater(position,direction):
	var blood = Props.BloodSplater.instance()
	blood.global_position = position
	blood.rotation = direction.angle()
	get_tree().get_root().call_deferred("add_child",blood)

func muzzle_flash(origin,target):
	var muzzle = Props.MuzzleFlash.instance()
	var direction = origin.direction_to(target)
	muzzle.global_position = origin + direction * 40.0
	muzzle.rotation = direction.angle()
	get_tree().get_root().call_deferred("add_child",muzzle)

func fire_bullet(position,target):
	var bullet = Props.BulletTemplate.instance()
	bullet.set_values(position,target)
	get_tree().get_root().call_deferred("add_child",bullet)

func set_enabler_entity(object:Node,stop=false):
	object.set_process_internal(stop)
	object.set_process(stop)
	object.set_physics_process(stop) 
	object.set_physics_process_internal(stop)

func Screenshoot()->void:
	print("Screenshot")
	get_viewport().queue_screen_capture()
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	var screenshot = get_viewport().get_screen_capture()
	screenshot.save_png("user://screenshot.png")

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
#		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if event.is_action_pressed("test_load"):
# warning-ignore:unused_variable
		for i in range(10):
			get_tree().get_root().add_child(Props.GatoEnemyTemplate.instance())
	
	if event.is_action_pressed("stop_process"):
		set_process_internal(false)
		set_process(false)
		
	if event.is_action_pressed("stop_process_fixed"):
		set_physics_process(false) 
		set_physics_process_internal(false)
