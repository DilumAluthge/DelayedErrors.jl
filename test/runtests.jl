import Test

using DelayedErrors

@noinline function grandparent1()::Nothing
    parent1()
    return nothing
end
@noinline function grandparent2()::Nothing
    parent2()
    return nothing
end
@noinline function grandparent3()::Nothing
    parent3()
    return nothing
end
@noinline function grandparent4()::Nothing
    parent4()
    return nothing
end

@noinline function parent1()::Nothing
    child1()
    return nothing
end
@noinline function parent2()::Nothing
    child2()
    return nothing
end
@noinline function parent3()::Nothing
    child3()
    return nothing
end
@noinline function parent4()::Nothing
    child4()
    return nothing
end

@noinline function child1()::Nothing
    push_delayed_error("This is ","a test.";a = 1,b = "2",)
    return nothing
end
@noinline function child2()::Nothing
    push_delayed_error("Test";st = "hello",bt = "goodbye",)
    return nothing
end
@noinline function child3()::Nothing
    push_delayed_error(
        "Test";
        st = "hello", st1 = "hello", bt = "goodbye", bt1 = "goodbye",
        )
    return nothing
end
@noinline function child4()::Nothing
    push_delayed_error(
        "Test";
        st = "hello", st1 = "hello", st11 = "hello",
        bt = "goodbye", bt1 = "goodbye", bt11 = "goodbye",
        )
    return nothing
end

pop_delayed_errors()
grandparent1()
grandparent2()
grandparent3()
grandparent4()
Test.@test_throws(
    ErrorException,
    pop_delayed_errors(),
    )
