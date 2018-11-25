defmodule Gitstat.Cake.Libra do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def async_run(pid, receiver, path) do
    GenServer.cast(pid, { :run, receiver, path })
  end

  def init(:ok) do
    state = []
    { :ok, state }
  end

  def handle_cast({:run, receiver, path}, state) do
    { status, payload } = stat(path)
    send receiver, { status, payload }
    { :noreply, state }
  end

  defp stat(path) do
    %{size: size, type: type} = path |> File.stat!
    ext = Path.extname(path)
    { :ok, %{size: size, type: type, ext: ext, language: Gitstat.file_type(ext)} }
  end
end
