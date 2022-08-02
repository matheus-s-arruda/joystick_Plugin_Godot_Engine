tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("JoyStick", "Control", preload("res://addons/joystick_control/joysctick.gd"), preload("res://addons/joystick_control/icon.svg"))


func _exit_tree():
	remove_custom_type("JoyStick")
