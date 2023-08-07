extends Node2D

var arrow = load("res://icons/arrow.png")
var is_setting_target = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_setting_target():
	is_setting_target = true
	Input.set_custom_mouse_cursor(arrow, Input.CURSOR_ARROW)
	
func _on_place_target_button_pressed():
	print("placing target")
	start_setting_target()

func _input(event):
	if is_setting_target and event is InputEventMouseButton:
		is_setting_target = false
		$TargetIndicator.position = event.position
		$TargetIndicator.show()
		print("target set")
		$GridContainer/XCoordDisplay.text = str(event.position.x)
		$GridContainer/YCoordDisplay.text = str(event.position.y)
		# set default cursor
		Input.set_custom_mouse_cursor(null, Input.CURSOR_ARROW)
