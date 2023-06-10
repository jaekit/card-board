class_name Unit extends AnimatedSprite2D


@export var _name: String
var map_position: Vector2i = Vector2i(-1, -1)


func name() -> String:
	return _name
