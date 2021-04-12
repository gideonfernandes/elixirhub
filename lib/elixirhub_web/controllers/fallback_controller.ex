defmodule ElixirhubWeb.FallbackController do
  use ElixirhubWeb, :controller

  alias Elixirhub.Error
  alias ElixirhubWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
