extends Room

var complete = false

func color_received():
	for receiver in get_tree().get_nodes_in_group("Receivers"):
		if !receiver.correct:
			return
	for color_drag in get_tree().get_nodes_in_group("Colors"):
		if color_drag is ColorDrag:
			color_drag.disable()
	complete = true
	print("room complete")
