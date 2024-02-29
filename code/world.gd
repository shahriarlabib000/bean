extends Node3D

@onready var enemy=preload("res://scenes/enemy.tscn")
var killCount:=0
var spawnEnemy=false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("tscn_reload"):
		get_tree().reload_current_scene()
	$Player/Head/Camera3D/ui/killCount.text=str(killCount)


func _on_timer_timeout():
	if(spawnEnemy):
		var inst=enemy.instantiate()
		inst.position.x=100
		inst.position.y=4
		add_child(inst)
	
func enemyKilled():
	killCount+=1
	
	
