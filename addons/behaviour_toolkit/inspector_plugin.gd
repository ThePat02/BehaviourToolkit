extends EditorInspectorPlugin


func _can_handle(object):
	return true


func _parse_property(object, type, name, hint_type, hint_string, usage_flags, wide):
	# Leaf Tween
	if object is LeafTween:
		var tween_value_type: LeafTween.TweenValueType = object.tween_value_type
		if name == "tween_value_int":
			return not tween_value_type == LeafTween.TweenValueType.INT
		
		if name == "tween_value_float":
			return not tween_value_type == LeafTween.TweenValueType.FLOAT
		
		if name == "tween_value_vector2":
			return not tween_value_type == LeafTween.TweenValueType.VECTOR2
		
		if name == "tween_value_vector3":
			return not tween_value_type == LeafTween.TweenValueType.VECTOR3
		
		if name == "tween_value_color":
			return not tween_value_type == LeafTween.TweenValueType.COLOR
	
	# Leaf Condition
	if object is LeafCondition:
		var condition_type: LeafCondition.ConditionValue = object.value_type
		if name == "condition_value_string":
			return not condition_type == LeafCondition.ConditionValue.STRING
		
		if name == "condition_value_int":
			return not condition_type == LeafCondition.ConditionValue.INT
		
		if name == "condition_value_float":
			return not condition_type == LeafCondition.ConditionValue.FLOAT
		
		if name == "condition_value_bool":
			return not condition_type == LeafCondition.ConditionValue.BOOL

	return false
