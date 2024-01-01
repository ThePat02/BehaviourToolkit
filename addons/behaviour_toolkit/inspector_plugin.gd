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
		
		if name == "tween_value_custom_script":
			return not tween_value_type == LeafTween.TweenValueType.CUSTOM_SCRIPT
	
	# Leaf Condition
	if object is LeafCondition:
		var value_type: LeafCondition.ConditionValue = object.value_type
		var condition_type: LeafCondition.ConditionType = object.condition_type

		if name == "condition_property":
			return condition_type == LeafCondition.ConditionType.CUSTOM_SCRIPT

		if name == "condition_value_string":
			return not value_type == LeafCondition.ConditionValue.STRING or condition_type == LeafCondition.ConditionType.CUSTOM_SCRIPT
		
		if name == "condition_value_int":
			return not value_type == LeafCondition.ConditionValue.INT or condition_type == LeafCondition.ConditionType.CUSTOM_SCRIPT
		
		if name == "condition_value_float":
			return not value_type == LeafCondition.ConditionValue.FLOAT or condition_type == LeafCondition.ConditionType.CUSTOM_SCRIPT
		
		if name == "condition_value_bool":
			return not value_type == LeafCondition.ConditionValue.BOOL or condition_type == LeafCondition.ConditionType.CUSTOM_SCRIPT
		
		if name == "custom_script":
			return not condition_type == LeafCondition.ConditionType.CUSTOM_SCRIPT

		if name == "value_type":
			return condition_type == LeafCondition.ConditionType.CUSTOM_SCRIPT

	return false
