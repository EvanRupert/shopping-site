defmodule ShoppingSiteWeb.ItemView do
    use ShoppingSiteWeb.Web, :view

  def encode_items(image_path, items) do
    items
    |> Enum.map(&price_to_float/1)
    |> Enum.map(&(complete_image_path(image_path, &1)))
    |> Poison.encode!
  end


  def price_to_float(%{ price: price } = item) do
      %{ item | price: Decimal.to_float(price) }
  end

  def complete_image_path(image_path, %{ image_url: path } = item) do
    full_path = image_path <> path
    { item | image_url: full_path }
  end

end