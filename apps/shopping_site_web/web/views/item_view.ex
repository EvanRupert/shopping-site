defmodule ShoppingSiteWeb.ItemView do
    use ShoppingSiteWeb.Web, :view

    # FIXME: group_into function is causing problems with the eex file
    # datatype list of maps with id, name, description, price, inserted_at, and updated_at fields with values

    def group_into([], _), do: []
    def group_into(l, n) when n > 0 do
        left = Enum.take(l, n)
        right = Enum.drop(l, n)
        [left | group_into(right, n)]
    end

end