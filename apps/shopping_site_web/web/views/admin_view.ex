defmodule ShoppingSiteWeb.AdminView do
  use ShoppingSiteWeb.Web, :view

  def decimal_to_float(d) do
    Decimal.to_float(d)
  end

  def sort_items(items) do
    items |> Enum.sort_by(fn x -> x.name end)
  end
end
