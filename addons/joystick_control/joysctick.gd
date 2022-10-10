tool
extends "res://addons/joystick_control/click_control.gd"

signal drag_position(direction)

export(Texture) var background_texture : Texture
export(Texture) var analog_texture : Texture
export(float, 0.0, 1.0) var analog_radius := 0.5 setget _refresh

var drag_direction : Vector2
var dragging := false

onready var min_size := min(rect_size.x, rect_size.y)
onready var min_rect_size := Vector2(min_size, min_size)
onready var center_position := min_rect_size / 2.0 
onready var analog_size := min_rect_size * analog_radius


func _init():
	if not Engine.editor_hint:
		connect("clicked", self, "_handle_click")


func _refresh(value):
	analog_radius = value
	update()


func _draw():
	if not background_texture or not analog_texture:
		return
	
	if Engine.editor_hint:
		var m = min(rect_size.x, rect_size.y)
		var _m = Vector2(m, m)
		var rect := Rect2(Vector2.ZERO, _m)
		
		draw_texture_rect(background_texture, rect, false)
		draw_texture_rect(analog_texture, Rect2(_m / 4, _m / 2), false)
	
	else:
		var rect := Rect2(Vector2.ZERO, min_rect_size)
		draw_texture_rect(background_texture, rect, false)
		
		var analog_pos = (drag_direction * center_position) + center_position
		var analog_rect := Rect2(analog_pos - (analog_size / 2), analog_size)
		draw_texture_rect(analog_texture, analog_rect, false)


func _input(event: InputEvent):
	if not can_click or touch_idx == -1: return
	
	if event is InputEventScreenDrag and touch_idx == event.index:
		drag_direction = (event.position - rect_global_position - center_position) / center_position
		
		if drag_direction.length() > 1.0:
			drag_direction = drag_direction.normalized()
		
		atualize_position(drag_direction)
	
	elif event is InputEventScreenTouch and not event.is_pressed() and touch_idx == event.index:
		touch_idx = -1
		drag_direction = Vector2.ZERO
		atualize_position(drag_direction)


func atualize_position(position: Vector2):
	emit_signal("drag_position", position)
	get_tree().set_input_as_handled()
	update()


func _handle_click(value: bool):
	dragging = value


