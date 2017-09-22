defmodule ShoppingSiteWeb.ItemChannel do
    use Phoenix.Channel

    def join("item:" <> event_id, _message, socket) do
        {:ok, socket}
    end


    def send_update(items) do
        payload = %{
            "payload" => encode_items items
        }

        ShoppingSiteWeb.Endpoint.broadcast("item:1", "items", payload)
    end


    defp encode_items(items) do
        items
        |> Enum.map(&price_to_float/1)
        |> Poison.encode!
    end


    defp price_to_float(item) do
        price = item.price
        %{ item | price: Decimal.to_float(price) }
    end
end