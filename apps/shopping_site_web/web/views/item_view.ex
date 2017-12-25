defmodule ShoppingSiteWeb.ItemView do
  use ShoppingSiteWeb.Web, :view

  def encode_items(image_path, items) do
    items
    |> Enum.map(&format_items(image_path, &1))
    |> Poison.encode!()
  end

  def format_items(image_path, item = %{price: price, image_url: path}) do
    full_path = image_path <> "/" <> path
    %{item | price: Decimal.to_float(price), image_url: full_path}
  end
end
