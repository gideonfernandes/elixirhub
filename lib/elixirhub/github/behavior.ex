defmodule Elixirhub.Github.Behaviour do
  alias Elixirhub.Error

  @typep github_response :: {:ok, map()} | {:error, %Error{}}

  @callback get_repos_info(String.t()) :: github_response
  @callback get_repos_info(String.t(), String.t()) :: github_response
end
