@icon("res://addons/behaviour_toolkit/icons/Gear.svg")
class_name BehaviourToolkit extends Node
## Base class for Behaviour Toolkit plugin nodes.


class Logger:
    extends BehaviourToolkit
    ## Logger class for Behaviour Toolkit plugin.

    ## Main color for logger messages.
    const COLOR_MAIN: String = "Orange"

    ## Log a message to the console with the Behaviour Toolkit prefix.
    static func say(message: String) -> void:
        var log_message: String
        log_message = colorize("[Behaviour Toolkit] ", COLOR_MAIN)
        log_message += message

        print_rich(log_message)

    ## Colorize a message with a given color tag in BBCode format.
    static func colorize(message: String, color: String) -> String:
        return "[color=" + color + "]" + message + "[/color]"
