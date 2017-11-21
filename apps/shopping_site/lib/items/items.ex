defmodule ShoppingSite.Items do
    use Ecto.Schema
    import Ecto.Changeset

    schema "items" do
        field :name,        :string
        field :description, :string
        field :price,       :decimal
        field :image_url,   :string

        timestamps()
    end


    def changeset(item, params \\ %{}) do
        item
        |> cast(params, [:name, :description, :price, :image_url])
        |> validate_required([:name, :price, :image_url])
        |> validate_format(:image_url, ~r/.+\.jpg/)
    end
end