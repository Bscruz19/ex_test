defmodule ExTest do
  defmacro __using__(_options) do
    quote do
      import unquote(__MODULE__)
      Module.register_attribute __MODULE__, :tests, accumulate: true

      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def run, do: ExTest.Runner.run(@tests, __MODULE__)
    end
  end

  defmacro test(description, do: test_block) do
    test_func = String.to_atom(description)

    quote do
      @tests {unquote(test_func), unquote(description)}
      def unquote(test_func)(), do: unquote(test_block)
    end
  end

  defmacro assert({operator, _, [lhs, rhs]}) do
    quote bind_quoted: [operator: operator, lhs: lhs, rhs: rhs] do
      ExTest.Assertion.assert(operator, lhs, rhs)
    end
  end

  defmacro assert(result) do
    quote do
      ExTest.Assertion.assert(unquote(result))
    end
  end

  defmacro refute({operator, _, [lhs, rhs]}) do
    quote bind_quoted: [operator: operator, lhs: lhs, rhs: rhs] do
      ExTest.Assertion.refute(operator, lhs, rhs)
    end
  end

  defmacro refute(result) do
    quote do
      ExTest.Assertion.refute(unquote(result))
    end
  end
end
