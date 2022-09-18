extends Path2D
tool

var curve_class = Curve2D

export(Array, Resource) var curves = [] setget set_curves
func set_curves(curves_new):
	curves = curves_new
	update_curve()

export(Array, Vector2) var curve_percents = [] setget set_percents 
func set_percents(curve_percents_new):
	curve_percents = curve_percents_new
	update_curve()

func update_curve():
	curve = curve_class.new()
	for i in range(curves.size()):
		# we skip nulls and incorrect elements
		if not curves[i] is curve_class:
			continue
		
		var new_curve = curves[i]
		var percents = curve_percents[i] if curve_percents.size() > i else Vector2.DOWN
		var start = percents[0] # equals zero by default
		var end = percents[1] # equals one by default
		curve = CurveUtils.append(curve, CurveUtils.split(new_curve, start, end))
	
	update()

func _draw():
	if Engine.editor_hint and curve.get_baked_points().size() > 1:
		draw_polyline(curve.get_baked_points(), Color.aqua, 1, true)
