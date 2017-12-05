defmodule ShoppingSite.ItemQueries do
    import Ecto.Query

    alias ShoppingSite.{Repo, Items}

    def get_all_items do
        Items
        |> select([c], %{ name: c.name, 
                          description: c.description, 
                          price: c.price, 
                          image_url: c.image_url, 
                          inserted_at: c.inserted_at, 
                          updated_at: c.updated_at
                        })
        |> Repo.all
    end

    
    def get_item_by_id(id) do
        query = from itm in Items,
                    select: itm

        Repo.get(query, id)
    end


    def search_items(search) do

        search = "%" <> search <> "%"

        query = from itm in Items,
                    where: ilike(itm.name, ^search),
                    select: itm

        Repo.all(query)
    end


    def insert_item(name, description, price, image_url) do
        Repo.insert!(%Items{ name: name, description: description, price: price, image_url: image_url})
    end


    def delete_by_id(id) do
        %{ image_url: url} = get_item_by_id id

        unless url == Application.get_env(:shopping_site_web, :placeholder_url) do
            ShoppingSiteWeb.ItemPicture.delete("/uploads/" <> url)     
        end
        

        Repo.delete!(%Items{id: id})

    end


    def update_image_url(id, url) do
        %Items{id: id}
        |> Ecto.Changeset.cast(%{image_url: url}, [:id, :image_url])
        |> Repo.update
    end

end