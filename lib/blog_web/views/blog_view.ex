defmodule BlogWeb.BlogView do
  use BlogWeb, :public_view

  def format_date(date) do
    case Timex.format(date, "%d %B %Y", :strftime) do
      {:ok, formatted} ->
        formatted

      {:error, _reason} ->
        "Unknown"
    end
  end

  # 265 WPM
  def read_time(content) do
    "5 min read"
  end

  def as_html(content) do
    content
    |> Earmark.as_html!()
    |> raw
  end
end
