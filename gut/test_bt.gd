extends GutTest


class TestBTSequence:
	extends GutTest

	var sequence: BTSequence
	var actor: Node
	var blackboard: Blackboard


	func before_each():
		sequence = BTSequence.new()
		actor = Node.new()
		blackboard = Blackboard.new()
	

	func after_each():
		if sequence.leaves != null:
			for leaf in sequence.leaves:
				leaf.free()

		sequence.free()
		actor.free()
		blackboard.unreference()
	
	
	func test_tick_returns_success_when_all_leaves_succeed():
		sequence.leaves = [TestLeaf.new(), TestLeaf.new(), TestLeaf.new()]
		for leaf in sequence.leaves:
			leaf.return_value = BTBehaviour.Status.SUCCESS

		var result_status: BTBehaviour.Status

		for i in range(sequence.leaves.size() + 1):
			assert_eq(sequence.current_leaf, i, "Current leaf should match current iteration")
			
			result_status = sequence.tick(actor, blackboard)
			
			if i < sequence.leaves.size():
				assert_eq(result_status, BTBehaviour.Status.RUNNING, "Status should be RUNNING until all leaves have been processed")

		assert_eq(
			result_status,
			BTBehaviour.Status.SUCCESS,
			"Return value should be SUCCESS when all leaves succeed"
		)

	func test_tick_returns_running_when_leaf_is_running():
		sequence.leaves = [TestLeaf.new(), TestLeaf.new(), TestLeaf.new()]
		sequence.leaves[0].return_value = BTBehaviour.Status.RUNNING

		assert_eq(sequence.tick(actor, blackboard), BTBehaviour.Status.RUNNING)


	func test_tick_returns_failure_when_any_leaf_fails():
		sequence.leaves = [TestLeaf.new(), TestLeaf.new(), TestLeaf.new()]
		sequence.leaves[0].return_value = BTBehaviour.Status.SUCCESS
		sequence.leaves[1].return_value = BTBehaviour.Status.FAILURE	

		assert_eq(sequence.tick(actor, blackboard), BTBehaviour.Status.RUNNING)
		assert_eq(sequence.tick(actor, blackboard), BTBehaviour.Status.FAILURE)


class TestBTSelector:
	extends GutTest

	var selector: BTSelector
	var actor: Node
	var blackboard: Blackboard


	func before_each():
		selector = BTSelector.new()
		actor = Node.new()
		blackboard = Blackboard.new()


	func after_each():
		if selector.leaves != null:
			for leaf in selector.leaves:
				leaf.free()

		selector.free()
		actor.free()
		blackboard.unreference()


	func test_tick_returns_running_when_leaf_is_running():
		selector.leaves = [TestLeaf.new(), TestLeaf.new(), TestLeaf.new()]
		selector.leaves[0].return_value = BTBehaviour.Status.RUNNING

		assert_eq(selector.tick(actor, blackboard), BTBehaviour.Status.RUNNING)


	func test_tick_returns_success_when_any_leaf_succeeds():
		selector.leaves = [TestLeaf.new(), TestLeaf.new(), TestLeaf.new()]
		selector.leaves[0].return_value = BTBehaviour.Status.FAILURE
		selector.leaves[1].return_value = BTBehaviour.Status.SUCCESS

		assert_eq(selector.tick(actor, blackboard), BTBehaviour.Status.RUNNING)
		assert_eq(selector.tick(actor, blackboard), BTBehaviour.Status.SUCCESS)


	func test_tick_returns_failure_when_all_leaves_fail():
		selector.leaves = [TestLeaf.new(), TestLeaf.new(), TestLeaf.new()]
		for leaf in selector.leaves:
			leaf.return_value = BTBehaviour.Status.FAILURE

		assert_eq(selector.tick(actor, blackboard), BTBehaviour.Status.RUNNING)
		assert_eq(selector.tick(actor, blackboard), BTBehaviour.Status.RUNNING)
		assert_eq(selector.tick(actor, blackboard), BTBehaviour.Status.RUNNING)
		assert_eq(selector.tick(actor, blackboard), BTBehaviour.Status.FAILURE)
	
