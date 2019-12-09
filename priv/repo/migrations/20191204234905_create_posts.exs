defmodule Blog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :content, :text, null: false
      add :excerpt, :text
      add :slug, :string, null: false
      add :title, :string, null: false
      add :views, :integer, default: 0
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create unique_index(:posts, [:slug])
    create index(:posts, [:user_id])
  end
end
