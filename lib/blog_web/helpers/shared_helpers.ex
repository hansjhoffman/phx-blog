defmodule BlogWeb.Helpers.SharedHelpers do
  @moduledoc """
  Project wide helpers
  """

  # def active_class(conn, matchers, class_name \\ "is-active")
  # def active_class(conn, matchers, class_name), do: "fix_me"

  def slugify(title \\ "") do
    title
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9\s-]/, "")
    |> String.replace(~r/(\s|-)+/, "-")
  end
end
