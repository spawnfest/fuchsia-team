defmodule Gitstat.Cake do
  use GenServer

  # Client Interface

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def async_run(pid, receiver, path) do
    GenServer.cast(pid, { :run, receiver, path })
  end

  # Server Interface

  def init(:ok) do
    state = []
    { :ok, state }
  end

  def handle_cast({ :run, receiver, path }, state) do
    paths_to_analyze = analyse(path)
    result = process_results(receiver, %{}, paths_to_analyze)
    send receiver, { :total, result }
    { :noreply, state }
  end

  defp analyse(path) do
    paths = Path.wildcard("#{path}/**/*.*")
    paths
    |> Enum.each( fn(path) ->
      {:ok, libra } = Gitstat.Cake.Libra.start_link()
      Gitstat.Cake.Libra.async_run(libra, self(), path)
    end)
    Enum.count(paths)
  end

  defp process_results(receiver, result, 0) do
    result
  end

  defp process_results(receiver, result, expected_messages) do
    receive do
      { :ok,  %{ size: size, language: language } = payload } ->
        result = Map.update(result, language, size, &(&1 + size))
        send receiver, { :partial, result }
        process_results(receiver, result, expected_messages - 1)
      { :error, payload } ->
        process_results(receiver, result, expected_messages - 1)
    end
  end
end
