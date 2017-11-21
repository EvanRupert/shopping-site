defmodule ShoppingSiteWeb.ItemController do
    use ShoppingSiteWeb.Web, :controller

    def list(conn, _params) do
        items = ShoppingSite.ItemQueries.get_all_items
        render conn, "item_list.html", items: items
    end


    def search(conn, %{"search" => %{"query" => query}}) do
        items = ShoppingSite.ItemQueries.search_items query
        render conn, "item_list.html", items: items
    end

end