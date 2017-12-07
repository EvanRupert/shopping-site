defmodule ShoppingSiteWeb.AdminController do
    use ShoppingSiteWeb.Web, :controller
    alias Decimal, as: D

    alias ShoppingSite.{ItemQueries, Items}

    def admin(conn, _params) do
        id = Plug.Conn.get_session(conn, :current_user)
        if id do
            items = ItemQueries.get_all_items
            changeset = Items.changeset(%Items{})
            render conn, "admin.html", items: items, changeset: changeset
        else
            redirect conn, to: "/login"
        end
    end


    def create(conn, %{"item" => %{ "description" => des, "name" => name,
                                    "image" => upload, "price" => price }}) do
        
        ShoppingSiteWeb.ItemPicture.store(upload)

        {p, _} = Float.parse price
        ItemQueries.insert_item name, des, p, upload.filename

        redirect conn, to: "/admin"
    end


    def create(conn, %{"item" => %{ "description" => des, "name" => name, 
                                    "price" => price}}) do

        {p, _} = Float.parse price
        ItemQueries.insert_item name, des, p

        redirect conn, to: "/admin"
    end


    def search(conn, %{"search" => %{"query" => query}}) do
        items = ShoppingSite.ItemQueries.search_items query
        render conn, "admin.html", items: items
    end


    def edit(conn, %{"submit" => "edit", 
                     "item" => %{ "id" => id, "name" => name, 
                     "description" => des, "price" => price}}) do
        
        {num_id, _} = Integer.parse(id)
        {num, _} = Float.parse(price)

        item = %{ id: num_id, name: name, description: des, price: D.new(num)}

        ShoppingSite.ItemQueries.update_item item
        
        redirect conn, to: "/admin"
    end


    # FIXME: this is broken, update dosen't do anything and delete is throwing 'no matching clause'
    def edit(conn, %{"submit" => "delete", "item" => %{ "id" => id }}) do

        {num, _} = Integer.parse id
        ShoppingSite.ItemQueries.delete_by_id num
        |> IO.inspect

        redirect conn, to: "/admin"
    end
end