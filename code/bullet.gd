extends RigidBody3D

var speed=50
var killCount:=0
@onready var ray=$RayCast3D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position+= transform.basis * Vector3(0,0,-speed) * delta
	if ray.is_colliding():
		if ray.get_collider().is_in_group("enemy"):
			ray.get_collider().queue_free()
			get_parent().get_parent().enemyKilled() #world
		queue_free()

