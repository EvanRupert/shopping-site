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
        |> validate_field_lengths()
    end

    
    def validate_field_lengths(changeset) do
        changeset
        |> validate_length(:name, max: 100)
        |> validate_length(:description, max: 500)
        |> validate_length(:image_url, max: 200)
    end
end