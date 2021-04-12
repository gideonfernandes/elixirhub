defmodule ElixirhubWeb.GithubController do
  use ElixirhubWeb, :controller

  alias ElixirhubWeb.FallbackController

  action_fallback FallbackController

  def index(conn, %{"nickname" => nickname}) do
    with {:ok, repos} <- Elixirhub.get_repos_info(nickname) do
      conn
      |> put_status(:ok)
      |> render("repos.json", repos: repos)
    end
  end
end
