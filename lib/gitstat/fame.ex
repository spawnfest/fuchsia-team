defmodule Gitstat.Fame do
  use GenServer

  # Client Interface

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def run(pid, path) do
    GenServer.call(pid, { :run, path })
  end

  def async_run(pid, receiver, path) do
    GenServer.cast(pid, { :run, receiver, path })
  end

  # Server Interface

  def init(:ok) do
    state = []
    { :ok, state }
  end

  def handle_call({:run, path}, _from, state) do
    result = run(path)
    { :reply, result, state }
  end

  def handle_cast({:run, receiver, path}, state) do
    result = run(path)
    send receiver, { :fame, result }
    { :noreply, state }
  end

  defp run(path) do
    {output, 0} = System.cmd("git", ["shortlog", "--summary", "--numbered", "--all"], cd: path)

    output
    |> String.split("\n")
    |> Enum.map(fn(x) -> Regex.run(~r/\A\s+(\d+)\s+(.+)\z/u, x, capture: :all_but_first) end)
  end
end
