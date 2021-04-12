defmodule ElixirhubWeb.ErrorView do
  use ElixirhubWeb, :view

  def render("error.json", %{result: result}), do: %{message: result}

  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
