defmodule ShoppingSiteWeb.ItemChannel do
    use Phoenix.Channel

    def join("item:" <> event_id, _message, socket) do
        {:ok, socket}
    end


    def send_update(items) do
        payload = %{
            "payload" => Poison.encode! items
        }

        ShoppingSiteWeb.Endpoint.broadcast("item:1", "items", payload)
    end
end