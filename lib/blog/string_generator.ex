defmodule Blog.CMS.StringGenerator do
  @chars "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789" |> String.codepoints()

  def unique_string_of_length(length \\ 5) do
    1..length
    |> Enum.map(fn _i -> Enum.random(@chars) end)
    |> Enum.join("")
  end
end
