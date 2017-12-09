defmodule ShoppingSite.Repo.Migrations.AddItemsTable do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name,        :string,  size: 100
      add :description, :string,  size: 2000
      add :price,       :numeric, default: 0.0
      add :image_url,   :string,  size: 100

      timestamps
    end
  end
end
