defmodule ShoppingSiteWeb.ItemController do
    use ShoppingSiteWeb.Web, :controller

    def list(conn, _params) do
        items = IO.inspect ShoppingSite.ItemQueries.get_all_items
        render conn, "item_list.html", items: items
    end
end