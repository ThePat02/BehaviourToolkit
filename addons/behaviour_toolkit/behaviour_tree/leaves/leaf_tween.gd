@tool
@icon("res://addons/behaviour_toolkit/icons/BTLeafTween.svg")
class_name LeafTween extends BTLeaf
## Tween a property of an actor.
##
## Leaf that allows you to specify a property that you want to
## animate/interpolate using a tween.


## The value type of the tween value.
enum TweenValueType {
	INT, ## Integer value type.
	FLOAT, ## Float value type.
	VECTOR2, ## Vector2 value type.
	VECTOR3, ## Vector3 value type.
	COLOR, ## Color value type.
	CUSTOM_SCRIPT, ## Custom script that returns a value.
}


## The default custom script template.
const DEFAULT_CUSTOM_SCRIPT = "# Custom Tween Value\nstatic func get_tween_value(_actor: Node, _blackboard: Blackboard) -> Variant:\n\t# Compute your custom logic here\n\treturn 0\n"


## The transition type of the tween.
@export var transition_type: Tween.TransitionType = Tween.TransitionType.TRANS_LINEAR
## The ease type of the tween.
@export var ease_type: Tween.EaseType = Tween.EaseType.EASE_IN
## The duration of the tween.
@export var duration: float = 2.0
## The property to tween.
## For example: "rotation:y" or "scale"
@export var tween_property: String:
	set(value):
		tween_property = value
		update_configuration_warnings()
## The value type of the tween.
@export var tween_value_type: TweenValueType: set = set_tween_value_type
## The integer value to tween to.
@export var tween_value_int: int
## The float value to tween to.
@export var tween_value_float: float
## The vector2 value to tween to.
@export var tween_value_vector2: Vector2
## The vector3 value to tween to.
@export var tween_value_vector3: Vector3
## The color value to tween to.
@export var tween_value_color: Color
## The custom script to use for the tween value.
@export var tween_value_custom_script: Script:
	set(value):
		if value == null:
			tween_value_custom_script = null
			return
		
		if not value.has_source_code():
			value.source_code = DEFAULT_CUSTOM_SCRIPT
		
		tween_value_custom_script = value

@export_group("Advanced")
## If true, the tween will be relative to the node's current value.
@export var as_relative = false
## How many times to loop the tween. (0 = infinite)
@export var loops: int = 1
## Scales the speed of tweening.
@export var speed_scale: float = 1.0
## Determines the behavior of the Tween when the SceneTree is paused.
@export var tween_pause_mode: Tween.TweenPauseMode
## Determines whether the Tween should run after process frames or physics frames.
@export var tween_process_mode: Tween.TweenProcessMode = Tween.TweenProcessMode.TWEEN_PROCESS_IDLE


## Setter function for the tween_value_type property.
func set_tween_value_type(value):
	tween_value_type = value
	# Update inspector
	notify_property_list_changed()


## The tween instance.
var tween : Tween


func tick(_delta: float, actor: Node, blackboard: Blackboard) -> BTStatus:
	# Initialize tween, if not already initialized
	_init_tween(actor, blackboard)

	if tween.is_running():
		return BTStatus.RUNNING

	# Invalidate tween instance
	tween.kill()
	tween = null
	return BTStatus.SUCCESS


func _init_tween(actor: Node, blackboard: Blackboard):
	if tween == null:
		# Create new tween instance
		tween = get_tree().create_tween().bind_node(actor)

		# Set tween properties
		tween.set_trans(transition_type)
		tween.set_ease(ease_type)
		tween.set_loops(loops)
		tween.set_speed_scale(speed_scale)
		tween.set_pause_mode(tween_pause_mode)
		tween.set_process_mode(tween_process_mode)

		# Set tween value
		var tween_value: Variant
		match tween_value_type:
			TweenValueType.INT:
				tween_value = tween_value_int
			TweenValueType.FLOAT:
				tween_value = tween_value_float
			TweenValueType.VECTOR2:
				tween_value = tween_value_vector2
			TweenValueType.VECTOR3:
				tween_value = tween_value_vector3
			TweenValueType.COLOR:
				tween_value = tween_value_color
			TweenValueType.CUSTOM_SCRIPT:
				tween_value = tween_value_custom_script.get_tween_value(actor, blackboard)

		# Start tween
		if as_relative:
			tween.tween_property(actor, tween_property, tween_value, duration).as_relative()
		else:
			tween.tween_property(actor, tween_property, tween_value, duration)


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: Array = []

	warnings.append_array(super._get_configuration_warnings())

	if tween_property == "":
		warnings.append("Tween property is empty.")

	return warnings
