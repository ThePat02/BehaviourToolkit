# Documentation: Finite State Machine

This is a simple and light-weigth implementation of a Finite State Machine in the Godot Engine.

> A finite-state machine (FSM) [...] is an abstract machine that can be in exactly one of a finite number of states at any given time. The FSM can change from one state to another in response to some inputs; the change from one state to another is called a transition. ([Wikipedia](https://en.wikipedia.org/wiki/Finite-state_machine))


## Nodes
![FiniteStateMachine Icon](../addons/behaviour_toolkit/icons/FiniteStateMachine.svg)
**FiniteStateMachine**<br>
The root node of every FSM and the parent of all FSMStates. After setting up the `initial_state` you can either use `autostart` to start the FSM on `_ready` or call `start()` manually. The FSM will be paused when the `active` is set to `false`.

![FSM State Icon](../addons/behaviour_toolkit/icons/FSMState.svg)
**FSMState**<br>
The base class for all `FSMState`s. You can add as many as you want to the FSM.

![FSM Transition Icon](../addons/behaviour_toolkit/icons/FSMTransition.svg)
**FSMTransition**<br>
The base class for all `FSMTransition`s. It has to be added as a child of an `FSMState` and the `next_state` has to be set to a valid `FSMState`, in order to work. 


## Usage
1. Create a new `FiniteStateMachine` node and add it to your scene. Setup your states and transitions as shown in the **Architecture Structure** below. Set the `initial_state` to the state you want to start with. You can also set `autostart` to `true` to start the FSM on `_ready`, when you don't need anything that is initialized after the `FiniteStateMachine` node.

2. Right click on the `FSMState`/`FSMTransition` node you want to customize and select "`Extend script`" from the context menu. This will create a new script file. I **strongly** suggest [utilizing the correct Script Template](../README.md#using-templates) and using a logical naming scheme (like `state_idle.gd` or `transition_on_jump.gd`).

3. Now you can override and implement the provided virtual methods. Use the script templates or in-engine documentation to get more information about those.

> **Advanced:** You can extend from `FSMState` / `FSMTransition` and assign a `class_name` to redefine the behaviour of the FiniteStateMachine!

### Architecture Structure
```
CharacterRootNode
    FiniteStateMachine
        Idle
            onStartMoving
            onJump
        Walking
            onStartRunning
            onStopMoving
            onJump
        Running
            onStopRunning
            onJump
        Jumping
            onPeak
        Falling
            onLanding
```
