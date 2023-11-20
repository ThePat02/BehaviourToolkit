@icon("res://addons/behaviour_toolkit/icons/Gear.svg")
class_name BehaviourToolkit extends Node
## The main node of the BehaviourToolkit plugin.


enum ProcessType {
    IDLE, ## Updates every frame, as often as possible.
    PHYSICS ## Updates on a fixed rate, 60 times per second by default. This is independent of your game's actual framerate, and keeps physics running smoothly
}
