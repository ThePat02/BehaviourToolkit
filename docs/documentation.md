# Documentation
> 🚧 The documentation is still work in progress and will be updated over time.

This documenation will give you an overview of the most important properties & methods of the different nodes and how to use them. If you want to dive deeper into the code, you can also check out the in-engine documentation [F1] or read the comments in the source code.

**Table of Contents**
- [Documentation](#documentation)
- [Finite State Machine](#finite-state-machine)
  - [Usage](#usage)
  - [Nodes](#nodes)
    - [ FiniteStateMachine](#-finitestatemachine)
      - [Properties](#properties)
      - [Methods](#methods)
      - [Signals](#signals)
    - [ FSMState](#-fsmstate)
      - [Methods](#methods-1)
    - [ FSMTransition](#-fsmtransition)
      - [Properties](#properties-1)
      - [Methods](#methods-2)
- [Behaviour Tree](#behaviour-tree)
  - [Usage](#usage-1)
  - [Tree Nodes](#tree-nodes)
    - [ BTRoot](#-btroot)
      - [Properties](#properties-2)
    - [ BTComposite](#-btcomposite)
      - [Properties](#properties-3)
    - [ BTLeaf](#-btleaf)
    - [ BTDecorator](#-btdecorator)
    - [Status Enum](#status-enum)
- [ Blackboard](#-blackboard)
  - [Creating a new Blackboard](#creating-a-new-blackboard)
  - [When to use a Blackboard](#when-to-use-a-blackboard)
    - [Adding and retrieving data](#adding-and-retrieving-data)
- [Nesting Behaviours inside Behaviours](#nesting-behaviours-inside-behaviours)
  - [State Machine nested in Behaviour Tree](#state-machine-nested-in-behaviour-tree)
  - [Behaviour Tree nested in State Machine](#behaviour-tree-nested-in-state-machine)
- [Using Script Templates](#using-script-templates)
- [Examples](#examples)



# Finite State Machine
 A finite-state machine (FSM) [...] is an abstract machine that can be in exactly one of a finite number of states at any given time. The FSM can change from one state to another in response to some inputs; the change from one state to another is called a transition. ([Wikipedia](https://en.wikipedia.org/wiki/Finite-state_machine))


## Usage
1. Create a new `FiniteStateMachine` node.
2. Add `FSMState` child nodes to the `FiniteStateMachine` node and set the `initial_state` property to the state you want to start with.
3. Add `FSMTransition` child nodes to the `FSMState` nodes and set the `next_state` property to the state you want to transition to.
4. To customize the states/transitions, right-click the node and select "Extend Script".


##  Nodes
### ![FiniteStateMachine Icon](../addons/behaviour_toolkit/icons/FiniteStateMachine.svg) FiniteStateMachine
This is the root node of the State Machine. All `FSMStates` must be children of this node.

#### Properties
- bool `autostart`
    - If `true` the FSM will start automatically when ready.
- bool `active`
    - When `true` the State Machine will run and update its current state.
- FSMState `initial_state`
    - The state that is entereted when the State Machine starts.
- Node `actor`
    - The actor is the different states. Most of the time you want to use the root node of your current scene.
- Blackboard `blackboard`
    - When left empty, a new local blackboard will be created. Otherwise the given blackboard will be used, which can be shared between multiple State Machines and Behaviour Trees.

#### Methods
- void `start()`
    - Starts the State Machine. This is called automatically when `autostart` is `true`.
- void `fire_event(event: String)`
    - Fires an event. This will trigger any transitions that are listening for this event.


#### Signals
- `state_changed(state: FSMState)`
    - Emitted when the current state changes.


### ![FSM State Icon](../addons/behaviour_toolkit/icons/FSMState.svg) FSMState
This is the base class for all states. On ready, all `FSMTransition` child nodes will be set up as transitions. To implement your logic you can override the `_on_enter`, `_on_update` and `_on_exit` methods when extending the node's script.

#### Methods
- void `_on_enter(actor: Node, blackboard: Blackboard)`
    - Called when the state is entered.
- void `_on_update(actor: Node, blackboard: Blackboard)`
    - Called every frame while the state is active.
- void `_on_exit(actor: Node, blackboard: Blackboard)`
    - Called when the state is exited.


### ![FSM Transition Icon](../addons/behaviour_toolkit/icons/FSMTransition.svg) FSMTransition
This is the base class for all transitions. To implement your logic you can override the `_on_transition` method when extending the node's script. To setup custom conditions you can override the `is_valid` method. If you want to use events to trigger the transition, set `use_event` to `true` and set the `event` property to the name of the event you want to listen for.

#### Properties
- FSMState `next_state`
    - The state that is entered when the transition is triggered.
- bool `use_event`
    - If `true` the transition will be triggered if the given event is fired.
- String `event`
    - The event that triggers the transition.


#### Methods
- void `_on_transition(actor: Node, blackboard: Blackboard)`
    - Called when the transition is triggered.
- bool `is_valid`
    - Should return `true` if the conditions for the transition are met.


# Behaviour Tree
A behavior tree is a mathematical model of plan execution used in computer science, robotics, control systems and video games. They describe switchings between a finite set of tasks in a modular fashion. Their strength comes from their ability to create very complex tasks composed of simple tasks, without worrying how the simple tasks are implemented. ([Wikipedia](https://en.wikipedia.org/wiki/Behavior_tree_(artificial_intelligence,_robotics_and_control)))


## Usage
1. Create a new `BTRoot` node.
2. Add a `BTComposite` as a child node.
3. Define your behaviour by adding `BTLeaf`, `BTDecorator` and `BTComposite` nodes.
4. To customize the nodes, right-click the node and select "Extend Script".


## Tree Nodes
### ![BTRoot Icon](../addons/behaviour_toolkit/icons/BTRoot.svg) BTRoot
This is the root of your behaviour tree. It is designed to only have one child node, which should be a `BTComposite` node. The root node is responsible for updating the tree.

#### Properties
- bool `autostart`
    - If `true` the FSM will start automatically when ready.
- bool `active`
    - When `true` the State Machine will run and update its current state.
- FSMState `initial_state`
    - The state that is entereted when the State Machine starts.
- Node `actor`
    - The actor is the different states. Most of the time you want to use the root node of your current scene.
- Blackboard `blackboard`
    - When left empty, a new local blackboard will be created. Otherwise the given blackboard will be used, which can be shared between multiple State Machines and Behaviour Trees.


### ![BTComposite Icon](../addons/behaviour_toolkit/icons/BTComposite.svg) BTComposite
Composites nodes are used to combine multiple leaves into a single node and evalute/execute them in a specific order. There are different types of composites:

- ![BTCompositeSequence Icon](../addons/behaviour_toolkit/icons/BTCompositeSequence.svg) BTSequence
  - Succeeds if all leaves succeed, fails if one leaf fails.
  - ![BTCompositeRandomSequence Icon](../addons/behaviour_toolkit/icons/BTCompositeRandomSequence.svg) BTRandomSequence can be used to randomize the order of the leaves.
- ![BTCompositeSelector Icon](../addons/behaviour_toolkit/icons/BTCompositeSelector.svg) BTSelector
  - Selects the first leaf that succeeds, fails if all leaves fail.
  - ![BTCompositeRandomSelector Icon](../addons/behaviour_toolkit/icons/BTCompositeRandomSelector.svg) BTRandomSelector can be used to randomize the order of the leaves.
- ![BTCompositeRandom Icon](../addons/behaviour_toolkit/icons/BTCompositeRandom.svg) BTRandom
  - One leaf is selected at random and executed.

#### Properties
- Array[BTLeaf] `leaves`
    - The leaves that are the children of this node.


### ![BTLeaf Icon](../addons/behaviour_toolkit/icons/BTLeaf.svg) BTLeaf
A leaf is where the actual behaviour logic is implemented. It is the base class for all leaves and can be extended to implement custom behaviour. The `tick(actor: Node, blackboard: Blackboard)` method is called every frame and should return a `Status`. There are a few example leaves that you can use out of the box:

- Print
  - Prints a message to the console. Very handy for debugging.
- Wait
  - Waits for a given amount of ticks.

A script template is also available to make it easier to extend the `BTLeaf` class.


### ![BTDecorator Icon](../addons/behaviour_toolkit/icons/BTDecorator.svg) BTDecorator
Decorators are used to augment the behaviour of a leaf. Think of it as another layer of logic that is executed before the leaf. There are a few example decorators that you can use out of the box:

- ![BTDecoratorFail Icon](../addons/behaviour_toolkit/icons/BTDecoratorFail.svg) AlwaysFail
  - The leaf always fails.
- ![BTDecoratorSucceed Icon](../addons/behaviour_toolkit/icons/BTDecoratorSucceed.svg) AlwaysSucceed
  - The leaf always succeeds.
- ![BTDecoratorLimiter Icon](../addons/behaviour_toolkit/icons/BTDecoratorLimiter.svg) Limiter
  - Limits the number of times a leaf can be executed.
- ![BTInverter Icon](../addons/behaviour_toolkit/icons/BTDecoratorNot.svg) Inverter
  - Inverts the result of the leaf.
- ![BTDecoratorRepeat Icon](../addons/behaviour_toolkit/icons/BTDecoratorRepeat.svg) Repeater
  - Repeats the leaf a given number of times.


### Status Enum
All nodes extending from `BTBehaviour`, which are `BTLeaf` , `BTDecorator` and `BTComposite` have access to the `Status` enum. It is used to determine the result of a node. The following values are available:

- `SUCCESS` = 0
  - The node succeeded.
- `FAILURE` = 1
  - The node failed.
- `RUNNING` = 2
  - The node is still running and will be executed again next frame.



# ![BLACKBOARD ICON](../addons/behaviour_toolkit/icons/Blackboard.svg) Blackboard
A blackboard is a simple key-value store that can be used to share data between different nodes. It is used by the `BehaviourTree` and `FiniteStateMachine` nodes to store and retrieve data.

## Creating a new Blackboard
To create a new `Blackboard` you can instantiate it like any other `Resource` in code with `Blackboard.new()`, right-click in the FileSystem dock and select `New -> Resource` or by clicking the `Blackboard` icon in the toolbox.

## When to use a Blackboard
You want to use a `Blackboard` to share data between different Behaviour Nodes. For example, you can use it to store the target position of an enemy that is shared between different states in a `FiniteStateMachine` or `BehaviourTree`. Whenever you don't define a `Blackboard` a new local one will be created for you, that can only be accessed by its own `BehaviourTree` or `FiniteStateMachine`.

### Adding and retrieving data
The `Blackboard` stores its data inside a `Dictionary`. You can add and retrieve data by using the following methods:

- void `set_value(key: StringName, value: Variant)`
    - Sets the value of the given key.
- Variant `get_value(key: StringName)`
    - Returns the value of the given key. If the key does not exist, `null` will be returned.

Additionally can also directly access the dictionary through the `content` property.



# Nesting Behaviours inside Behaviours
You can nest `BTRoot` nodes inside `FinitStateMachine` nodes and vice versa! Think of the respective node as another State/Leaf and you can use all the same logic to control the behaviour. This allows you to create very complex behaviours by combining different architectures.

## State Machine nested in Behaviour Tree
To nest a State Machine you need to use ![IntegradeFSM Icon](../addons/behaviour_toolkit/icons/BTCompositeIntegration.svg) `IntegratedFSM` composite node and add a `FiniteStateMachine` as a child. The `IntegratedFSM` node will then act as a leaf and execute the State Machine. If you want to exit the State Machine, you let it navigate to a ![Icon Return](../addons/behaviour_toolkit/icons/FSMStateIntegrationReturn.svg) `IntegratioReturn` state and the `IntegratedFSM` will return `SUCCESS` or `FAILURE` depending on the state's `return_status` property.

## Behaviour Tree nested in State Machine
To nest a Behaviour Tree you need to use ![IntegradeBT Icon](../addons/behaviour_toolkit/icons/FSMStateIntegration.svg) `IntegrationBT` state and add a `BTRoot` as a child. When this state is entered, the Behaviour Tree is set to active. You can use the `fire_event_on_status` property to fire an event when the Behaviour Tree returns a specific status. This allows you to trigger transitions based on the status of the Behaviour Tree. You can also use the `FSMEvent` leaf to trigger custom events inside the nested State Machine.



# Using Script Templates
You can find all templates inside the `script_templates` directory, so make sure to add it to your project.  Whenever you extend a script, the template will automatically be suggested by the editor.

**Available Templates:**
- FSMState
- FSMTransition
- BTLeaf



# Examples
> 🚧 Work in progress 🚧

Examples are located in the `examples` directory. (What a surprise!)
