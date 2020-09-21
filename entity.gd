extends KinematicBody2D
onready var animTree = $texture/AnimationTree
onready var animState = animTree.get("parameters/playback")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var motion = Vector2.ZERO
var maxSpeed = 350
var Acc = 2000
var dcc = 15000
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var axis = get_input_axis()
	animTree.set("parameters/idle/blend_position", axis)
	animTree.set("parameters/walk/blend_position", axis)
	if axis == Vector2.ZERO:
		apply_friction()
		animState.travel("idle")
	else:
		
		animState.travel("walk")
		apply_movement(axis * Acc*delta)
	motion = move_and_slide(motion)
	



func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down"))-int(Input.is_action_pressed("ui_up"))
	return axis.normalized()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func apply_friction():
	motion = Vector2.ZERO
func apply_movement(acceleration):
	motion += acceleration
	if motion.length() > maxSpeed :
		motion = motion.normalized()* maxSpeed
