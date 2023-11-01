extends GutTest


func before_all():
	gut.p("Runs once before all tests")

func before_each():
	gut.p("Runs before each test.")

func after_each():
	gut.p("Runs after each test.")

func after_all():
	gut.p("Runs once after all tests")

func test_assert_eq_number_not_equal():
	assert_eq(1, 2, "Should fail.  1 != 2")

func test_assert_eq_number_equal():
	assert_eq('asdf', 'asdf', "Should pass")

class TestSomeAspects:
	extends GutTest

	func test_assert_eq_number_not_equal():
		assert_eq(1, 2, "Should fail.  1 != 2")

	func test_assert_eq_number_equal():
		assert_eq('asdf', 'asdf', "Should pass")

class TestOtherAspects:
	extends GutTest

	func test_assert_true_with_true():
		assert_true(true, "Should pass, true is true")
	