defmodule ExTest.Assertion do
  @assertion [assert: "Assertion", refute: "Refute"]

  def assert(operator, lhs, rhs) do
    if apply(Kernel, operator, [lhs, rhs]),
      do: :ok,
      else: {:error, format_error_message(:assert, operator, lhs, rhs)}
  end

  def assert(result) when is_nil(result) or result == false,
    do: {:error, format_error_message(:assert, true)}

  def assert(_result), do: :ok

  def refute(result) do
    case assert(result) do
      :ok -> {:error, format_error_message(:refute, false)}
      {:error, _reason} -> :ok
    end
  end

  def refute(operator, lhs, rhs) do
    case assert(operator, lhs, rhs) do
      :ok -> {:error, format_error_message(:refute, operator, lhs, rhs)}
      {:error, _reason} -> :ok
    end
  end

  defp format_error_message(func_name, result) do
    """
    FAILURE:
    Expected #{result}, got #{!result}
    code: #{func_name} #{result}
    """
  end

  defp format_error_message(func_name, operator, lhs, rhs) do
    """
    FAILURE:
    #{@assertion[func_name]} with #{operator} failed
    code: #{func_name} #{lhs} #{operator} #{rhs}
    left: #{lhs}
    right: #{rhs}
    """
  end
end
