defmodule ElixirPercentageRollout.Application do
  require Logger

  use Application

  def start(_type, _args) do
    ElixirPercentageRollout.Supervisor.start_link()
  end
end