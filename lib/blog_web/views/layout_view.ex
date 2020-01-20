defmodule BlogWeb.LayoutView do
  use BlogWeb, :public_view
  import BlogWeb.Meta.AdminTitle

  alias Phoenix.{Controller, Naming}

  @doc """
  Returns `class_name` for a given connection if it matches any of the provided
  'matchers'. A 'matcher' could be a string representation of a controller/
  action combo, or it could be a regular expression.
  """
  def active_class(conn, matchers, class_name \\ "is-active")

  def active_class(conn, matchers, class_name) when is_binary(matchers),
    do: active_class(conn, [matchers], class_name)

  def active_class(conn, matchers, class_name) when is_list(matchers) do
    active_id = controller_action_combo(conn)

    if Enum.any?(matchers, fn x ->
         matcher = if Regex.regex?(x), do: x, else: ~r/#{x}/
         String.match?(active_id, matcher)
       end) do
      class_name
    end
  end

  defp controller_name(conn),
    do: Controller.controller_module(conn) |> Naming.resource_name("Controller")

  defp controller_action_combo(conn),
    do: [controller_name(conn), action_name(conn)] |> Enum.join("-")

  defp controller_action_combo_matches?(conn, list) when is_list(list) do
    combo = controller_action_combo(conn)
    Enum.any?(list, &(&1 == combo))
  end

  defp action_name(conn), do: Controller.action_name(conn)
end
