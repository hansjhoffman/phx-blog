defmodule Blog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string, null: false
      add :content, :text, null: false
      add :views, :integer, default: 0
      add :slug, :string, null: false
      add :excerpt, :text

      timestamps()
    end

    create unique_index(:posts, [:slug])
  end
end
