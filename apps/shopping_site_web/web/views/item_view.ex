defmodule ShoppingSiteWeb.ItemView do
    use ShoppingSiteWeb.Web, :view

  def encode_items(image_path, items) do
    items
    |> Enum.map(&(format_items(image_path, &1)))
    |> Poison.encode!
  end


  # def price_to_float(item = %{ price: price }) do
  #     %{ item | price: Decimal.to_float(price) }
  # end

  # def complete_image_path(image_path, item = %{ image_url: path }) do
  #   full_path = image_path <> path
  #   { item | image_url: full_path }
  # end


  def format_items(image_path, item = %{price: price, image_url: path}) do
    full_path = image_path <> "/" <> path
    %{ item | price: Decimal.to_float(price),
              image_url: full_path
    }    
  end
end