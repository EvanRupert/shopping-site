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

    def get_item_by_prefix(prefix) do

        search = "%" <> prefix <> "%"

        query = from itm in Items,
                    where: ilike(itm.name, ^search),
                    select: itm

        Repo.all(query)
    end
end