@icon("res://addons/behaviour_toolkit/icons/Gear.svg")
class_name BehaviourToolkit extends Node
## Base class for Behaviour Toolkit plugin nodes.


enum LogType {
    DEFAULT,
    WARNING,
    ERROR,
}


class BTLogger:
    extends BehaviourToolkit
    ## Logger class for Behaviour Toolkit plugin.

    ## Main color for logger messages.
    const COLOR_MAIN: String = "Orange"
    ## Accent color for logger messages.
    const COLOR_ACCENT: String = "Blue"
    ## Warning color for logger messages.
    const COLOR_WARNING: String = "Yellow"
    ## Error color for logger messages.
    const COLOR_ERROR: String = "Red"

    ## Log a message to the console with the Behaviour Toolkit prefix.
    static func say(message: String, caller: Node = null, type: LogType = LogType.DEFAULT) -> void:
        var log_message: String
        log_message = colorize("[Behaviour Toolkit] ", COLOR_MAIN)

        if not type == LogType.DEFAULT:
            var color: String
            match type:
                LogType.WARNING:
                    color = COLOR_WARNING
                LogType.ERROR:
                    color = COLOR_ERROR
            
            log_message += colorize("[" + LogType.keys()[type] + "] ", color)

        if caller != null:

            log_message += colorize(caller.name + " ", COLOR_ACCENT)

            var actor: Node = null
            if "actor" in caller:
                actor = caller.actor
            
            if actor:
                log_message += colorize("@ " + actor.name + " ", COLOR_ACCENT)


        log_message += message

        print_rich(log_message)

    ## Colorize a message with a given color tag in BBCode format.
    static func colorize(message: String, color: String) -> String:
        return "[color=" + color + "]" + message + "[/color]"
