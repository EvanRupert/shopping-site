defmodule ShoppingSite.Items do
    use Ecto.Schema

    schema "items" do
        field :name,        :string
        field :description, :string
        field :price,       :float
        field :image_url,   :string

        timestamps
    end
end