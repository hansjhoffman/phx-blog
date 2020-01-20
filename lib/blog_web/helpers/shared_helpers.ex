defmodule BlogWeb.Helpers.SharedHelpers do
  @moduledoc """
  Project wide helpers
  """

  def slugify(title \\ "") do
    title
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9\s-]/, "")
    |> String.replace(~r/(\s|-)+/, "-")
  end
end
