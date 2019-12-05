defmodule BlogWeb.Helpers.SharedHelpers do
  # def active_class(conn, matchers, class_name \\ "is-active")
  # def active_class(conn, matchers, class_name), do: "fix_me"

  def slugify_title(title) do
    title
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9\s-]/, "")
    |> String.replace(~r/(\s|-)+/, "-")
  end
end
