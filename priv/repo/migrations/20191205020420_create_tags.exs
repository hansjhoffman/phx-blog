defmodule Blog.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :title, :string, null: false
      add :slug, :string, null: false

      timestamps()
    end

    create unique_index(:tags, [:slug])
  end
end
