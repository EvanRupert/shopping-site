defmodule ShoppingSiteWeb.AdminView do
    use ShoppingSiteWeb.Web, :view

    def decimal_to_float(d) do
        Decimal.to_float d
    end
    
end