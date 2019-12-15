defimpl Phoenix.Param, for: Blog.CMS.Post do
  alias BlogWeb.Helpers.SharedHelpers

  def to_param(%{slug: slug, title: title}) do
    "#{slug}-#{SharedHelpers.slugify(title)}"
  end
end

defimpl Phoenix.Param, for: Blog.CMS.Tag do
  def to_param(%{slug: slug}) do
    slug
  end
end
