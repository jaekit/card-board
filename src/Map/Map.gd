class_name Map extends TileMap


var direction_vectors = [
	Vector2i(1, 0), Vector2i(1, -1), Vector2i(0, -1),
	Vector2i(-1, 0), Vector2i(-1, 1), Vector2i(0, 1),
]
var astar: AStar2D


func _ready() -> void:
	_debug_label_hexes()
	_create_graph()


# Create graph for astar
func _create_graph() -> void:
	astar = AStar2D.new()
	
	for y in range(10):
		var start := -y/2
		for x in range(10):
			var id := 10*y + x
			astar.add_point(id, Vector2(start + x, y), 1)
			if astar.has_point(id + 1):
				astar.connect_points(id, id + 1)
			if astar.has_point(id - 1):
				astar.connect_points(id, id - 1)
			if astar.has_point(id - 11 + y % 2):
				astar.connect_points(id, id - 11 + y % 2)
			if astar.has_point(id - 11 + y % 2 + 1):
				astar.connect_points(id, id - 11 + y % 2 + 1)
			if astar.has_point(id + 9 + y % 2):
				astar.connect_points(id, id + 9 + y % 2)
			if astar.has_point(id + 9 + y % 2 + 1):
				astar.connect_points(id, id + 9 + y % 2 + 1)


func _cell_pos_to_id(cell_pos: Vector2i) -> int:
	return cell_pos.y * 10 + cell_pos.x + cell_pos.y / 2


func get_tiles_in_range(map_pos: Vector2i, range: int) -> Array:
	var visited := {} # set of hexes
	visited[map_pos] = true
	var fringes := [] # array of arrays of hexes
	fringes.append([map_pos])
	
	for k in range(1, range + 1):
		fringes.append([])
		for hex in fringes[k-1]:
			for dir in range(0, 6):
				var neighbour = hex + direction_vectors[dir]
				if neighbour not in visited and is_traversable(neighbour):
					visited[neighbour] = true
					fringes[k].append(neighbour)
	return visited.keys()


func is_traversable(_map_pos: Vector2i) -> bool:
	return true


# Hex distance between two hex cells
func distance(a: Vector2i, b: Vector2i) -> int:
	return (abs(a.x - b.x) + abs(a.y - b.y) + abs(-(a - b).x - (a - b).y)) / 2


func highlight_tile(map_pos: Vector2i) -> void:
	pass


func is_tile_highlighted(map_pos: Vector2i) -> bool:
	return true


#func heuristic(a: Vector2i, b: Vector2i) -> int:
#	# Manhattan distance on a square grid
#	return abs(a.x - b.x) + abs(a.y - b.y)
#
#
#func shortest_path(start: Vector2i, goal: Vector2i, graph) -> void:
#	var frontier = PriorityQueue.new()
#	frontier.add(start, 0)
#	var came_from: Dictionary
#	var cost_so_far: Dictionary
#	came_from[start] = null
#	cost_so_far[start] = 0
#
#	while !frontier.empty():
#		var current = frontier.get_min()
#		if current == goal:
#			break
#		for next in graph.neighbors(current):
#			var new_cost = cost_so_far[current] + graph.cost(current, next)
#			if next not in cost_so_far or new_cost < cost_so_far[next]:
#				cost_so_far[next] = new_cost
#				var priority = new_cost + heuristic(goal, next)
#				frontier.add(next, priority)
#				came_from[next] = current


func _debug_label_hexes() -> void:
	for y in range(10):
		var start := -y/2
		for x in range(10):
			var label := Label.new()
			label.position = map_to_local(Vector2i(start + x, y))
			label.text = "%d, %d" % [start + x, y]
			add_child(label)
