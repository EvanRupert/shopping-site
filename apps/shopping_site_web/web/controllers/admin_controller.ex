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
            conn |> redirect(to: "/login")
        end
    end


    def create(conn, %{"item" => %{ "description" => des, "name" => name,
                                    "image" => upload, "price" => price }}) do
        
        File.rename upload.path, "/images/#{upload.filename}"
        p = price |> Float.parse() |> Decimal.new()
        ItemQueries.insert_item name, des, p, upload.filename

        render conn, "admin.html"
    end


    def remove(conn, _params) do
        #TODO: implement
        render conn, "admin.html" 
    end
end