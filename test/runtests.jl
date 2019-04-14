import Test

import DelayedErrors

# ENV["JULIA_DEBUG"] = "all"

DelayedErrors.process_delayed_error_list()

DelayedErrors.delayederror("This is ", "a test.", a = 1, b = "2",)

Test.@test_throws(
    ErrorException,
    DelayedErrors.process_delayed_error_list(),
    )
