defmodule Elixirhub do
  alias Elixirhub.Github.Client, as: GithubClient

  defdelegate get_repos_info(user_nickname), to: GithubClient, as: :get_repos_info
end
