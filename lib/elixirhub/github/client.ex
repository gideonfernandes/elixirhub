defmodule Elixirhub.Github.Client do
  use Tesla

  @behaviour Elixirhub.Github.Behaviour
  @base_url "https://api.github.com/users/"

  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.Headers, [{"user-agent", "Tesla"}]

  alias Elixirhub.Error
  alias Tesla.Env

  def get_repos_info(url \\ @base_url, user_nickname) do
    with {:ok, %Env{status: 200, body: body}} <- get("#{url}#{user_nickname}/repos") do
      {:ok, body}
    else
      {:ok, %Env{status: 404, body: _body}} ->
        {:error, Error.build(:not_found, "Github user not found!")}

      {:error, reason} ->
        {:error, Error.build(:bad_request, reason)}
    end
  end
end
