defmodule BlogWeb.SitemapView do
  use BlogWeb, :public_view

  def format_timestamp(date) do
    date
    |> Timex.format!("%FT%T%:z", :strftime)

    # |> Timex.format("{ISO:Extended}")
  end

  # def format_timestamp(date) do
  #   date
  #   |> DateTime.from_naive!("Etc/UTC")
  #   |> DateTime.to_date()
  #   |> to_string()
  # end
end
