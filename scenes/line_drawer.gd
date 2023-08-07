extends Node2D

var coordinates = []
var lines = []
var guide_line_x = Line2D.new()
var guide_line_y = Line2D.new() 
var is_active = false;
var mouse_pos;
var show_guides = false;

var line_started = null;
var start_coords = Vector2(0,0)

func _ready():
	add_child(guide_line_x)
	add_child(guide_line_y)

func _process(_delta):
	if(!is_active):
		return
	if show_guides:
		draw_guides()
	if line_started is Line2D:
		line_started.clear_points()
		line_started.add_point(start_coords)
		line_started.add_point(mouse_pos)

func _input(event):

	if !is_active:
		return
	if event is InputEventMouse and $ControlsArea.get_rect().has_point(event.position):
		return
	if event is InputEventMouseButton and event.is_pressed():
		if !(line_started is Line2D):
			line_started = Line2D.new()
			line_started.add_point(event.position)
			start_coords = event.position
			add_child(line_started)
			print("line started")
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			remove_child(line_started)
			line_started = null;
			print("line removed")
		else:
			line_started.clear_points()
			line_started.add_point(start_coords)
			line_started.add_point(event.position)
			lines.push_back(line_started)
			line_started = null;
			print("line finished")
				
	if event is InputEventMouseMotion:
		mouse_pos = event.position
			
func _on_line_drawer_reset_button_pressed():
	for l in lines:
		remove_child(l)
	lines = []

func draw_guides():
	var vp = get_viewport()
	var mp = vp.get_mouse_position()
	guide_line_x.clear_points()
	guide_line_x.add_point(Vector2(0,mp[1]))
	guide_line_x.add_point(Vector2(vp.size[0],mp[1]))
	guide_line_x.width = 1
	guide_line_y.clear_points()
	guide_line_y.add_point(Vector2(mp[0],0))
	guide_line_y.add_point(Vector2(mp[0], vp.size[0]))
	guide_line_y.width = 1

func disable_guides():
	guide_line_x.clear_points()
	guide_line_y.clear_points()
	
func set_active(active: bool): 
	is_active = active
	if(!active):
		disable_guides();
	
func _on_control_draw_lines_toggled(button_pressed):
	set_active(button_pressed);


func _on_control_toggle_guides_toggled(button_pressed):
	show_guides = button_pressed
	if !button_pressed:
		disable_guides()
