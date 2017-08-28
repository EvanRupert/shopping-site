defmodule ShoppingSite.Items do
    use Ecto.Schema

    schema "items" do
        field :name,        :string
        field :description, :string
        field :price,       :decimal
        field :image_url,   :string

        timestamps
    end
end