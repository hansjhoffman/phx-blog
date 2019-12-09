defmodule BlogWeb.Helpers.SharedHelpersTest do
  use ExUnit.Case, async: true

  alias BlogWeb.Helpers.SharedHelpers

  test "slugify_title/1 with a valid, lowercase title" do
    assert SharedHelpers.slugify_title("this is a test") == "this-is-a-test"
  end

  test "slugify_title/1 with a valid, mix-case title" do
    assert SharedHelpers.slugify_title("tHiS iS a TeSt") == "this-is-a-test"
  end

  test "slugify_title/1 with no title" do
    assert SharedHelpers.slugify_title() == ""
  end
end
