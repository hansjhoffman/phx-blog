defmodule Blog.Repo.Migrations.AddTagsToPost do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :tags, {:array, :string}
    end
  end
end
