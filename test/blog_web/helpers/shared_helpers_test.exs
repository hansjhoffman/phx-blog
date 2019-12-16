defmodule BlogWeb.Helpers.SharedHelpersTest do
  use ExUnit.Case, async: true

  alias BlogWeb.Helpers.SharedHelpers

  test "slugify/1 with a valid, lowercase title" do
    assert SharedHelpers.slugify("this is a test") == "this-is-a-test"
  end

  test "slugify/1 with a valid, mix-case title" do
    assert SharedHelpers.slugify("tHiS iS a TeSt") == "this-is-a-test"
  end

  test "slugify/1 with a invalid chars" do
    assert SharedHelpers.slugify("%*(This) is *a test1") == "this-is-a-test1"
  end

  test "slugify/1 with no title" do
    assert SharedHelpers.slugify() == ""
  end
end
