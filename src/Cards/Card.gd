class_name Card extends Node2D


@export var _name: String
@export_multiline var description: String
var unit: Unit


func name() -> String:
	return _name


func play_effects(game: Game) -> void:
	for effect in get_children():
		effect.play(game, unit)
