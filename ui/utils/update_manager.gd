@tool
class_name UpdateManager extends HTTPRequest
## This class is used to check for updates of the plugin.


## Emitted when the request to the repository is completed.
signal update_request_completed
## Emitted when the request to the repository is completed and an update is available.
signal update_available


## If this is set to false, the plugin will not check for updates.
@export var auto_start: bool = false
## The path to the addon config file.
@export_file("*.cfg") var addon_config_path = ""
## The URL to the repository config file. This file has to be the raw version!
@export var repo_config_url = ""

## Error flag to prevent the error message from printing twice.
static var had_error: bool = false

## The current version of the plugin.
var current_version: String
## The newest version of the plugin.
var newest_version: String


func _ready():
	current_version = get_current_version()

	# Connect signals
	connect("request_completed", _on_http_request_request_completed)

	# Check if active
	if not auto_start:
		return
	
	start()


func start():
	# Get versions
	get_newest_version()


## Returns true if an update is available.
func is_update_available() -> bool:
	if current_version != newest_version:
		return true
	
	return false


## Returns the current version of the plugin.
func get_current_version() -> String:
	var config = ConfigFile.new()
	var err = config.load(addon_config_path)

	var result = config.get_value("plugin", "version")
	config.clear()

	return result


## Requests the newest version of the plugin from the repository.
func get_newest_version() -> void:
	var err = request(repo_config_url)


## Called when the request to the repository is completed, parses the config file and sets the newest version.
func _on_http_request_request_completed(result:int, response_code:int, headers:PackedStringArray, body:PackedByteArray):
	if result != OK:
		if not had_error:
			BehaviourToolkit.BTLogger.say(
				"Unable to fetch newest version from GitHub. Check your internet connection and reload the editor!",
				null,
				BehaviourToolkit.LogType.WARNING
			)
			had_error = true
		
		emit_signal("update_request_completed")
		return

	var config = ConfigFile.new()
	var err = config.parse(body.get_string_from_ascii())

	newest_version = config.get_value("plugin", "version")
	config.clear()

	# Emit signals
	emit_signal("update_request_completed")

	if is_update_available():
		emit_signal("update_available")
