defmodule ShoppingSiteWeb.PageController do
  use ShoppingSiteWeb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def test(conn, _params) do
    items = ShoppingSite.ItemQueries.get_all_items
    render conn, "test.html", items: items
  end
end
