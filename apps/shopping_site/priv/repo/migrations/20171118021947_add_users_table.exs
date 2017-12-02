defmodule ShoppingSite.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, size: 100
      add :password, :string, size: 100

      timestamps
    end
  end
end
