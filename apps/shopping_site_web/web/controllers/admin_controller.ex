defmodule ShoppingSiteWeb.AdminController do
    use ShoppingSiteWeb.Web, :controller

    alias ShoppingSite.{ItemQueries, Items}

    def admin(conn, _params) do
        id = Plug.Conn.get_session(conn, :current_user)
        if id do
            items = ItemQueries.get_all_items
            changeset = Items.changeset(%Items{})
            render conn, "admin.html", items: items, changeset: changeset
        else
            redirect(conn, "/login")
        end
    end
end