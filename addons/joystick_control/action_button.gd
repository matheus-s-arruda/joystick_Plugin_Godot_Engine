tool
extends "res://addons/joystick_control/click_control.gd"

export var texture : Texture
export var action : String


func _init():
	if not Engine.editor_hint:
		connect("clicked", self, "_emit_action")


func _draw():
	var min_size := min(rect_size.x, rect_size.y)
	var min_rect_size := Vector2(min_size, min_size)
	var rect := Rect2(Vector2.ZERO, min_rect_size)
	
	draw_texture_rect(texture, rect, false)


func _emit_action(value: bool):
		var act = InputEventAction.new()
		act.action = action
		act.pressed = value
		Input.parse_input_event(act)
		modulate.a = 0.3 + (0.7 * int(value))

