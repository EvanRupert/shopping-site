defmodule ShoppingSiteWeb.AdminController do
    use ShoppingSiteWeb.Web, :controller
    alias Decimal, as: D

    alias ShoppingSite.{ItemQueries, Items}

    def admin(conn, _params) do
        id = Plug.Conn.get_session(conn, :current_user)
        if id do
            items = ItemQueries.get_all_items
            changeset = Items.changeset(%Items{})
            render conn, "admin.html", items: items, changeset: changeset, errors: %{}
        else
            redirect conn, to: "/login"
        end
    end


    def create(conn, %{"item" => %{ "description" => des, "name" => name,
                                    "image" => upload, "price" => price }}) do
        
        {p, _} = Float.parse price
        case ItemQueries.insert_item name, des, p do
            { :error, reason } ->
                items = ItemQueries.get_all_items
                changeset = Items.changeset(%Items{})

                render conn, "admin.html", items: items, errors: reason.errors,
                       changeset: changeset
            { :ok, %{ id: id } } ->
                new_filename = update_filename name, id, Path.extname(upload.filename)
                upload = %{ upload | filename: new_filename }

                ShoppingSiteWeb.ItemPicture.store(upload)
                ItemQueries.update_image_url id, new_filename
            
                redirect conn, to: "/admin"
        end
    end


    def create(conn, %{"item" => %{ "description" => des, "name" => name, 
                                    "price" => price}}) do

        {p, _} = Float.parse price
        
        case ItemQueries.insert_item name, des, p do
            { :error, reason } ->
                items = ItemQueries.get_all_items
                changeset = Items.changeset(%Items{})

                render conn, "admin.html", items: items, errors: reason.errors,
                       changeset: changeset
            { :ok, _ } ->
                redirect conn, to: "/admin"
        end
    end


    defp update_filename(filename, id, extension) do
        cleaned = filename
                  |> (fn name -> Regex.replace(~r/[^a-zA-Z0-9\. ]/, name, "") end).()
                  |> (fn name -> Regex.replace(~r/ /, name, "_") end).()
                  |> (&String.downcase/1).()
    
        cleaned <> to_string(id) <> extension
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


    def edit(conn, %{"submit" => "delete", "item" => %{ "id" => id }}) do

        {num, _} = Integer.parse id
        ShoppingSite.ItemQueries.delete_by_id num
        |> IO.inspect

        redirect conn, to: "/admin"
    end
end