extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var player=null
var time:=0.01/1.5
var gravity=ProjectSettings.get_setting("physics/3d/default_gravity")
@export var player_path:="../Player"
func _ready():
	player= get_node(player_path)
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	

	# Handle jump

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	position.x=lerp(position.x,player.global_position.x,time)
	position.z=lerp(position.z,player.global_position.z,time)

	move_and_slide()


func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		body.death()
	
