defmodule ShoppingSiteWeb.PageView do
  use ShoppingSiteWeb.Web, :view

  def encode_items(items) do
    items
    |> Enum.map(&price_to_float/1)
    |> Poison.encode!()
  end

  def price_to_float(item) do
    price = item.price
    %{item | price: Decimal.to_float(price)}
  end
end
