# Documentation
> 🚧 Work in progress


## ![FiniteStateMachine Icon](../addons/behaviour_toolkit/icons/FiniteStateMachine.svg) Finite State Machine
 A finite-state machine (FSM) [...] is an abstract machine that can be in exactly one of a finite number of states at any given time. The FSM can change from one state to another in response to some inputs; the change from one state to another is called a transition. ([Wikipedia](https://en.wikipedia.org/wiki/Finite-state_machine))


###  Nodes
#### ![FiniteStateMachine Icon](../addons/behaviour_toolkit/icons/FiniteStateMachine.svg) FiniteStateMachine
This is the root node of the State Machine. All `FSMStates` must be children of this node.

##### Properties
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

##### Methods
- void `start()`
    - Starts the State Machine. This is called automatically when `autostart` is `true`.
- void `fire_event(event: String)`
    - Fires an event. This will trigger any transitions that are listening for this event.


#### Signals
- `state_changed(state: FSMState)`
    - Emitted when the current state changes.


#### ![FSM State Icon](../addons/behaviour_toolkit/icons/FSMState.svg) FSMState
This is the base class for all states. On ready, all `FSMTransition` child nodes will be set up as transitions. To implement your logic you can override the `_on_enter`, `_on_update` and `_on_exit` methods when extending the node's script.

##### Methods
- void `_on_enter(actor: Node, blackboard: Blackboard)`
    - Called when the state is entered.
- void `_on_update(actor: Node, blackboard: Blackboard)`
    - Called every frame while the state is active.
- void `_on_exit(actor: Node, blackboard: Blackboard)`
    - Called when the state is exited.


#### ![FSM Transition Icon](../addons/behaviour_toolkit/icons/FSMTransition.svg) FSMTransition
This is the base class for all transitions. To implement your logic you can override the `_on_transition` method when extending the node's script. To setup custom conditions you can override the `is_valid` method. If you want to use events to trigger the transition, set `use_event` to `true` and set the `event` property to the name of the event you want to listen for.

##### Properties
- FSMState `next_state`
    - The state that is entered when the transition is triggered.
- bool `use_event`
    - If `true` the transition will be triggered if the given event is fired.
- String `event`
    - The event that triggers the transition.


##### Methods
- void `_on_transition(actor: Node, blackboard: Blackboard)`
    - Called when the transition is triggered.
- bool `is_valid`
    - Should return `true` if the conditions for the transition are met.


## Behaviour Tree
> 🚧 Work in progress



## ![BLACKBOARD ICON](../addons/behaviour_toolkit/icons/Blackboard.svg) Blackboard
A blackboard is a simple key-value store that can be used to share data between different nodes. It is used by the `BehaviourTree` and `FiniteStateMachine` nodes to store and retrieve data.

### Creating a new Blackboard
To create a new `Blackboard` you can instantiate it like any other `Resource` in code with `Blackboard.new()`, right-click in the FileSystem dock and select `New -> Resource` or by clicking the `Blackboard` icon in the toolbox.

### When to use a Blackboard
You want to use a `Blackboard` to share data between different Behaviour Nodes. For example, you can use it to store the target position of an enemy that is shared between different states in a `FiniteStateMachine` or `BehaviourTree`. Whenever you don't define a `Blackboard` a new local one will be created for you, that can only be accessed by its own `BehaviourTree` or `FiniteStateMachine`.

### Adding and retrieving data
The `Blackboard` stores its data inside a `Dictionary`. You can add and retrieve data by using the following methods:

- void `set_value(key: StringName, value: Variant)`
    - Sets the value of the given key.
- Variant `get_value(key: StringName)`
    - Returns the value of the given key. If the key does not exist, `null` will be returned.

Additionally can also directly access the dictionary through the `content` property.



## Examples
> 🚧 Work in progress