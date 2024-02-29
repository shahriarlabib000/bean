extends CharacterBody3D


const SPEED = 10.0
const JUMP_VELOCITY = 4.5
var def_sensitivity :=0.01
var sensitivity:=0.01
var bullet=preload("res://scenes/bullet.tscn")
var deatScreen=preload("res://scenes/death.tscn")
var zoom:=false
var flash:=false
var alive:=true
var captureTouchMotion:Vector2=Vector2(0,0)

@onready var viewPortSizeX=get_viewport().size.x
@onready var ray=$Head/Camera3D/RayCast3D
@onready var cam=$Head/Camera3D
@onready var flashlight=$Head/Camera3D/SpotLight3D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	if alive:
		if Input.is_action_just_pressed("shoot"):
			var b=bullet.instantiate()
			b.position=ray.global_position
			b.transform.basis=ray.global_transform.basis
			get_parent().get_node("bullets").add_child(b)
		
		if Input.is_action_pressed("jump") and is_on_floor():
			velocity.y=JUMP_VELOCITY
		
		if Input.is_action_just_pressed("reset"):
			var bulletNode=get_parent().get_node("bullets")
			for child in bulletNode.get_children():
				child.queue_free()
			
		if Input.is_action_just_pressed("ui_cut"):
			flash=!flash
		
		if Input.is_action_just_pressed("zoombtn"):
			zoom=!zoom
		
		if(zoom):
			cam.fov=5
			sensitivity=def_sensitivity/20
		else:
			cam.fov=75
			sensitivity=def_sensitivity/2
		
		flashlight.visible=flash
		

	# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		var direction = (transform.basis  * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction :
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
		move_and_slide()
	elif !is_on_floor():
		#activates when player is dead but is not on floor
		move_and_slide()
	
func _unhandled_input(event):
	if event is InputEventScreenDrag:
		if(event.position.x>viewPortSizeX/2):
			if(alive):
				rotation.y+= -event.relative.x * sensitivity
				$Head.rotation.x+= -event.relative.y * sensitivity
				$Head.rotation.x=clamp($Head.rotation.x,deg_to_rad(-90),deg_to_rad(90))
	
func death():
	$Head/Camera3D/ui.visible=false
	$Head/Camera3D.add_child(deatScreen.instantiate())
	alive=false
