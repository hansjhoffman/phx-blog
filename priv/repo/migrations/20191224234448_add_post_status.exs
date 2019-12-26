defmodule Blog.Repo.Migrations.AddPostStatus do
  use Ecto.Migration

  def change do
    execute(
      "CREATE TYPE post_status AS ENUM ('ARCHIVED','DRAFT','PUBLISHED')",
      "drop type post_status"
    )

    alter table(:posts) do
      add :status, :post_status, null: false, default: "DRAFT"
    end
  end
end
