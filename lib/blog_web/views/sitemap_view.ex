defmodule BlogWeb.SitemapView do
  use BlogWeb, :public_view

  def format_timestamp(date) do
    date
    |> Timex.format!("%FT%T%:z", :strftime)
    # |> Timex.format("{ISO:Extended}")
  end
end
