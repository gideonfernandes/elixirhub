defmodule ElixirhubWeb.GithubView do
  use ElixirhubWeb, :view

  def render("repos.json", %{repos: repos}) do
    Enum.map(repos, fn repo -> render("repo.json", repo: repo) end)
  end

  def render("repo.json", %{repo: repo}) do
    %{
      id: repo["id"],
      name: repo["name"],
      description: repo["description"],
      html_url: repo["html_url"],
      stargazers_count: repo["stargazers_count"]
    }
  end
end
