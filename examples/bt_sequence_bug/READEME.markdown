This example is here to provide a 'minimal' example reproducing https://github.com/ThePat02/BehaviourToolkit/issues/81

When running the example without the fix:

```
Setting target: (-78, -28)
Waiting
Timer timed out, firing `timeout` event.
Done Waiting
target reached
Setting target: (-174, 16)  <------
Waiting
Timer timed out, firing `timeout` event.
Done Waiting
target reached
Setting target: (123, 136)   <------
Waiting
```
Notice that the target is set before entering the `Waiting` state, event though this is the first task in the sequence.
This occurs after `MoveToTarget` reports success.


After the fix:
```
Setting target: (-20, 149)
target reached
Waiting
Timer timed out, firing `timeout` event.
Done Waiting
Setting target: (-176, -45)
target reached
Waiting
```
Notice that when the `MoveToTarget` action is successful, we transition to `Waiting` as expected.