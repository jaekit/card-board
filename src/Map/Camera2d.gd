extends Camera2D


@export_range(1.0, 10.0, 0.1) var speed: float = 1.0


func _process(delta: float) -> void:
	if Input.is_action_pressed("camera_up"):
		offset += Vector2.UP * delta * speed * 500
	if Input.is_action_pressed("camera_down"):
		offset += Vector2.DOWN * delta * speed * 500
	if Input.is_action_pressed("camera_left"):
		offset += Vector2.LEFT * delta * speed * 500
	if Input.is_action_pressed("camera_right"):
		offset += Vector2.RIGHT * delta * speed * 500
