defmodule Blog.Repo.Migrations.AddUserLastLogin do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :last_login, :naive_datetime
    end
  end
end
