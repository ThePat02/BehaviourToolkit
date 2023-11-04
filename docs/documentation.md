# Documentation


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


## Blackboard


## Examples