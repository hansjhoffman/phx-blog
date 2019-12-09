defmodule BlogWeb.Meta.AdminTitle do
  @moduledoc """
  SEO helpers for page titles
  """

  alias BlogWeb.Admin.PageView

  @suffix "Admin"

  def admin_page_title(assigns) do
    assigns
    |> get()
    |> put_suffix()
  end

  defp get(_), do: "FTW"
  # defp get(_), do: nil

  defp put_suffix(nil), do: @suffix
  defp put_suffix(title), do: "#{title} |> #{@suffix}"
end
