@tool
extends Sprite3D

@export_multiline var text: String

@onready var subView=$SubViewport
@onready var label=$SubViewport/Label
# Called when the node enters the scene tree for the first time.
func _ready():
	label.text=text
	await label.resized
	subView.size=label.size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
