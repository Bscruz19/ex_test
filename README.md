# ExTest

Exercise from Metaprogramming Elixir.

The propose of this project is to create an Assertion test framework with the following features:

• Implement assert for every operator in Elixir.
• Add Boolean assertions, such as `assert true`.
• Implement a refute macro for refutations.
• Run test cases in parallel.
• Add reports for the module. Include pass/fail counts and execution time.

# Getting started

Define a test module and `use` the `ExTest` module.

```
defmodule MathTest do
  use ExTest

  test "integers can be added" do
    assert 1 + 1 == 2
  end

  test "integers can be multiplied" do
    refute 7 * 3 > 21
  end
end
```

To run the tests:

```
iex

iex(1)> c "ex_test/ex_test.exs"
iex(2)> c "ex_test/runner.exs"
iex(3)> c "ex_test/assertion.exs"
iex(4)> c "ex_test/your_test.exs"
iex(5)> YourTest.run()
```
