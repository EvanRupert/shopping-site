defmodule ShoppingSiteWeb.ItemView do
    use ShoppingSiteWeb.Web, :view

    def take([], _), do: []
    def take(_, 0), do: []
    def take([x|xs], n), do: [x | take(xs, n - 1)] 

    def group_into([], _), do: []
    def group_into(l, n) when n > 0 do
        left = take(l, n)
        right = l |> Enum.drop(n) |> group_into(n)
        Enum.concat(left, right)
    end

end