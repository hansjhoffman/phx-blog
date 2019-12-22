defmodule BlogWeb.Meta.AdminTitle do
  @moduledoc """
  Helpers for page titles
  """

  alias BlogWeb.Admin.PageView

  @prefix "Admin"

  def admin_page_title(assigns), do: assigns |> get()

  defp get(%{view_module: view}) do
    "#{@prefix} |> #{get_view_name(view)}s"
  end
  defp get(_), do: nil

  defp get_view_name(view) do
    view
    |> Module.split
    |> List.last
    |> String.replace("View", "")
    |> String.split(~r/(?=[A-Z])/)
    |> Enum.join(" ")
  end
end
