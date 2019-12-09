defmodule Blog.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :slug, :string, null: false
      add :title, :string, null: false

      timestamps()
    end

    create unique_index(:tags, [:slug])
  end
end
