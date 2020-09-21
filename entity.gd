extends KinematicBody2D
onready var anim = $texture/AnimationPlayer
onready var animTree = $texture/AnimationTree 
onready var animState = animTree.get("parameters/playback") 
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var motion = Vector2.ZERO
export var maxSpeed = 350
export var Acc = 300
export var dcc = 15000
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var last_anim = ""
func _physics_process(delta):
	var axis = get_input_axis()
	print(last_anim)
	#animTree.set("parameters/idle/blend_position", axis)
	#animTree.set("parameters/walk/blend_position", axis)
	if axis == Vector2.ZERO:
		apply_friction()
			
		anim.play(last_anim)
		last_anim = ""
	else:
		#animState.travel("walk")
		motion = axis * Acc
		
		if axis.x == 0 and axis.y <= -0.1 :
			if (anim.get_current_animation().get_basename() != "walk_up"):
				anim.play("walk_up")
			last_anim = "idle_up"
		elif axis.x >= 0.1 :
			if (anim.get_current_animation().get_basename() != "walk_right"):
				anim.play("walk_right")
			last_anim = "idle_right"
		elif axis.x == 0 and axis.y >= 0.1 :
			if (anim.get_current_animation().get_basename() != "walk_down"):
				anim.play("walk_down")
			last_anim = "idle_down"
		elif axis.x <= -0.1 :
			if (anim.get_current_animation().get_basename() != "walk_left"):
				anim.play("walk_left")
			last_anim = "idle_left"

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

