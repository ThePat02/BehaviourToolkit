# Quickstart Guide
This is a short guide to get you started with the plugin. For more information, read the [documentation](docs/DOCUMENTATION.md).

## Installation
There are two ways to install this plugin:
- Download the plugin from the [Godot Asset Library](https://godotengine.org/asset-library/asset) directly into your project using the `AssetLib` tab. Make sure to also include the `script_templates` folder!
- Download the laste release on the GitHub [releases page](https://github.com/ThePat02/BehaviourToolkit/releases) and extract the `addons` and `script_templates` folders into your project folder.

After you have installed the plugin, you need to enable it in the project settings.

## Usage
1. Add a `BTRoot` (BehaviourTree) or `FiniteStateMachine` node to your scene.
2. Configure the `actor` property of the node in the selector. Usually this is the node which behaviour you want to control.
3. Whenever a node of this plugin is selected in the editor, a specialised Interface will appear and allow you to add relevant nodes to your behaviour pattern.
4. Make sure to configure the nodes in the inspector. Read the [documentation](docs/DOCUMENTATION.md) for more information.

### Custom Behaviour
There are a few nodes which already come with implemented logic. Most of the time you will need to implement your own logic. This can be done by adding a new node (in this example a new `FSMState`) and extending it with a script. There are templates available in the `script_templates` folder. You can also reuse your own scripts by attaching them to the node.

![Interface](screenshot-extend-script.PNG)