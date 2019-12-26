defmodule BlogWeb.Admin.PostView do
  use BlogWeb, :protected_view

  def format_date(date) do
    if Timex.diff(Timex.now(), date, :hours) < 24 do
      case Timex.format(date, "{relative}", :relative) do
        {:ok, formatted} ->
          formatted

        {:error, _reason} ->
          "Unknown"
      end
    else
      case Timex.format(date, "%m/%d/%Y", :strftime) do
        {:ok, formatted} ->
          formatted

        {:error, _reason} ->
          "Unknown"
      end
    end
  end

  def post_label_class(status) do
    case status do
      "ARCHIVED" -> "ds-btn__label--danger"
      "DRAFT" -> "ds-btn__label--info"
      "PUBLISHED" -> "ds-btn__label--success"
    end
  end
end
