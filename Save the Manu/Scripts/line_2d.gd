extends Line2D

@export var target_path : Path2D

func _ready():
	points = target_path.curve.get_baked_points()
	position = target_path.global_position
