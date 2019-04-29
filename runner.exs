defmodule ExTest.Runner do
  def run(tests, module) do
    start_time = Time.utc_now()

    results = execute_tests(tests, module)

    time = Time.diff(start_time, Time.utc_now())

    errors = Enum.count(results, & &1 != :ok)

    IO.puts """
    Finished in #{time} seconds
    #{length(results)} tests, #{errors} failures"
    """
  end

  defp execute_tests(tests, module) do
    tests
    |> Enum.map(fn {test_func, description} ->
      Task.async(fn ->
        module
        |> apply(test_func, [])
        |> log(description)
      end)
    end)
    |> Enum.map(&Task.await/1)
  end

  defp log(:ok, _description) do
    [:green, "."]
    |> IO.ANSI.format()
    |> IO.write()

    :ok
  end

  defp log({:error, reason} = error, description) do
    [
      :red,
      """
      \n=============================\n
      #{description}\n
      #{reason}
      """
    ]
    |> IO.ANSI.format()
    |> IO.puts()

    error
  end
end
