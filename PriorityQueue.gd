class_name PriorityQueue extends RefCounted


var trees := []
var least: FibonacciTree = null
var size := 0


class FibonacciTree:
	var value # Variant
	var priority: int
	var child := []
	var order := 0
	
	func _init(value, priority) -> void:
		self.value = value
		self.priority = priority
	
	func add_at_end(t: FibonacciTree) -> void:
		child.append(t)
		order += 1


# Add a value with given priority
func add(value, priority: int) -> void:
	var new_tree = FibonacciTree.new(value, priority)
	trees.append(new_tree)
	if least == null or priority < least.priority:
		least = new_tree
	size += 1


# Returns the value with the lowest priority
func get_min():
	if least == null:
		return 0
	return least.value


# Removes and returns the value with the lowest priority
func extract_min():
	var smallest := least
	if smallest == null:
		return 0
	for child in smallest.child:
		trees.append(child)
	trees.erase(smallest)
	if trees == []:
		least = null
	else:
		least = trees[0]
		_consolidate()
	size -= 1
	return smallest.value


func _consolidate() -> void:
	var aux: Array = []
	var phi := (1 + sqrt(5)) / 2
	var Dofn := int(log(size) / log(phi))
	for i in range(Dofn + 1):
		aux.append(null)
	
	while trees != []:
		var x: FibonacciTree = trees[0]
		var order := x.order
		trees.erase(x)
		while aux[order] != null:
			var y: FibonacciTree = aux[order]
			if x.priority > y.priority:
				var temp := x
				x = y
				y = temp
			x.add_at_end(y)
			aux[order] = null
			order = order + 1
		aux[order] = x
	
	least = null
	for k in aux:
		if k != null:
			trees.append(k)
			if least == null or k.priority < least.priority:
				least = k
