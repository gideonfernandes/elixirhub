defmodule Elixirhub.Github.ClientTest do
  use ExUnit.Case, async: true

  alias Plug.Conn
  alias Elixirhub.Error
  alias Elixirhub.Github.Client

  describe "get_repos_info/1" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "returns the repos info, when there is a valid github user nickname", %{bypass: bypass} do
      nickname = "danilo-vieira"

      url = endpoint_url(bypass.port)

      body = ~s({
          "id": "123",
          "name": "next-tailwind-framermotion",
          "description": "Interface completa utilizando Next.js, Tailwind e Framer Motion baseada no workshop do evento DoWhile 2020 produzido por Guilherme Rodz - @guilhermerodz",
          "html_url": "https://github.com/danilo-vieira/next-tailwind-framermotion",
          "stargazers_count": 0
        })

      Bypass.expect(bypass, "GET", "#{nickname}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      expected_response =
        {:ok,
         %{
           "description" =>
             "Interface completa utilizando Next.js, Tailwind e Framer Motion baseada no workshop do evento DoWhile 2020 produzido por Guilherme Rodz - @guilhermerodz",
           "html_url" => "https://github.com/danilo-vieira/next-tailwind-framermotion",
           "id" => "123",
           "name" => "next-tailwind-framermotion",
           "stargazers_count" => 0
         }}

      response = Client.get_repos_info(url, nickname)

      assert response === expected_response
    end

    test "returns an error, when the github user nickname is invalid", %{bypass: bypass} do
      nickname = "123456789000abc"

      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, "GET", "#{nickname}/repos", fn conn ->
        Conn.resp(conn, 404, "")
      end)

      expected_response = {:error, %Error{result: "Github user not found!", status: :not_found}}

      response = Client.get_repos_info(url, nickname)

      assert response === expected_response
    end

    test "returns an error, when there is a generic error", %{bypass: bypass} do
      nickname = "123456789000abc"

      url = endpoint_url(bypass.port)

      Bypass.down(bypass)

      expected_response = {:error, %Elixirhub.Error{result: :econnrefused, status: :bad_request}}

      response = Client.get_repos_info(url, nickname)

      assert response === expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
