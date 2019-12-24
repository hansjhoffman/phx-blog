defmodule BlogWeb.Admin.PostView do
  use BlogWeb, :protected_view

  def format_date(date) do
    case Timex.format(date, "%m/%d/%Y", :strftime) do
      {:ok, formatted_date} ->
        formatted_date

      {:error, _reason} ->
        "Unknown"
    end
  end
end
