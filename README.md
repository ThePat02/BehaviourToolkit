# BehaviourToolkit

<p align="center">
    <img src="addons/behaviour_toolkit/icons/FiniteStateMachine.svg">
    <img src="addons/behaviour_toolkit/icons/FSMState.svg">
    <img src="addons/behaviour_toolkit/icons/FSMTransition.svg">
    <img src="addons/behaviour_toolkit/icons/BTRoot.svg">
    <img src="addons/behaviour_toolkit/icons/BTBehaviour.svg">
    <img src="addons/behaviour_toolkit/icons/BTComposite.svg">
    <img src="addons/behaviour_toolkit/icons/BTCompositeSequence.svg">
    <img src="addons/behaviour_toolkit/icons/BTCompositeSelector.svg">
    <img src="addons/behaviour_toolkit/icons/BTCompositeRandom.svg">
    <img src="addons/behaviour_toolkit/icons/BTCompositeRandomSequence.svg">
    <img src="addons/behaviour_toolkit/icons/BTCompositeRandomSelector.svg">
    <img src="addons/behaviour_toolkit/icons/BTLeaf.svg">
    <img src="addons/behaviour_toolkit/icons/BTDecorator.svg">
    <img src="addons/behaviour_toolkit/icons/BTDecoratorSucceed.svg">
    <img src="addons/behaviour_toolkit/icons/BTDecoratorFail.svg">
    <img src="addons/behaviour_toolkit/icons/BTDecoratorLimiter.svg">
    <img src="addons/behaviour_toolkit/icons/BTDecoratorRepeat.svg">

</p>

This plugin provides a set of tools to create custom and complex behaviour in the Godot 4.x Game Engine.

### Features & Design Goals
- A lightweight and customizable approach to behaviour.
- Fusion and extension of different behaviour paradigms, such as:
    - ![FMS ICON](addons/behaviour_toolkit/icons/FiniteStateMachine.svg) Finite State Machines
    - ![BT ICON](addons/behaviour_toolkit/icons/BTRoot.svg) Behaviour Trees
- [Templates](#using-templates) for easy extension and integration.

## Documentation
- ![FMS ICON](addons/behaviour_toolkit/icons/FiniteStateMachine.svg) [Finite State Machine](docs/docs_finite_state_machine.md)
- ![BT ICON](addons/behaviour_toolkit/icons/BTRoot.svg) [Behaviour Tree](docs/behaviour_tree.md)

## Using templates
When cloning this repository/importing the plugin, make sure to not only add the `addons` directory to your project, but also the `script_templates` directory. This allows you to have preconfigured script templates when extending behaviour nodes, providing you with virtual methods and a logical naming scheme.


## Resources and references
- [Behavior Trees and how to implement them in Godot](https://thisisvini.com/behavior-trees) (Blog Entry)
- [Game AI Pro](http://www.gameaipro.com/) (Website with many free articles on AI)
- [Game AI Pro 360: Guide to Architecture](https://www.amazon.de/Game-AI-Pro-360-Architecture/dp/0367151049) (Book on Amazon)
