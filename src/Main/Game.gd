class_name Game extends Node2D


@onready var map: Map = $Map
signal move_unit


enum State {
	DEFAULT,
	MOVE_UNIT,
}

var STATE: int = State.DEFAULT
var hand: CardPile
var selected_unit: Unit:
	set(value):
		if selected_unit == value:
			return
		selected_unit = value
		if selected_unit == null:
			pass
		else:
			pass
		print("Selected Unit: ", value)
var selected_tile: Vector2i:
	set(value):
		if selected_tile == value:
			return
		selected_tile = value
		if value == Vector2i(-1, -1):
			# TODO: hide tile info
			selected_unit = null
		else:
			# TODO: show tile info
			if units.has(selected_tile):
				selected_unit = units[selected_tile]
var hovered_tile: Vector2i:
	set(value):
		if hovered_tile == value:
			return
		hovered_tile = value
		# TODO: show relevant tile info
var units: Dictionary


func _ready() -> void:
	var unit = preload("res://src/Units/unit.tscn").instantiate()
	add_unit_to_map(unit, Vector2i(1,0))
	request_move_unit(unit, 2)


func _process(_delta: float) -> void:
	hovered_tile = map.local_to_map(to_local(get_global_mouse_position()))


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		if STATE == State.MOVE_UNIT:
			emit_signal("move_unit", event.position)
		else:
			selected_tile = hovered_tile
	elif event.is_action_pressed("right_click"):
		selected_tile = Vector2i(-1, -1)


# Add the unit to the map for the first time
func add_unit_to_map(unit: Unit, map_pos: Vector2i) -> void:
	set_unit_position(unit, map_pos)
	add_child(unit)
	# TODO: attach signals
	# unit.connect()


# Change unit's position
func set_unit_position(unit: Unit, map_pos: Vector2i) -> void:
	if unit.map_position == map_pos:
		return
	units.erase(unit.map_position)
	unit.map_position = map_pos
	unit.position = map.map_to_local(map_pos)
	units[map_pos] = unit


func play_card_effect(card: Card) -> void:
	card.play_effects(self)


func request_move_unit(unit: Unit, range: int) -> void:
	var tiles := map.get_tiles_in_range(unit.map_position, range)
	for tile in tiles:
		map.highlight_tile(tile)
	STATE = State.MOVE_UNIT
	# TODO: connect.
