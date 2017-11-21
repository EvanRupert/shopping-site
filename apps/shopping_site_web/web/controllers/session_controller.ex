defmodule ShoppingSiteWeb.SessionController do
    use ShoppingSiteWeb.Web, :controller

    def new(conn, _params) do
        render conn, "login.html"
    end


    def create(conn, %{"session" => session_params}) do
        case ShoppingSite.UserQueries.login(session_params["username"], session_params["password"]) do
            {:ok, user} ->
                conn
                |> put_session(:current_user, user.id)
                |> redirect(to: "/admin")
            :error ->
                conn
                |> put_flash(:info, "Wrong username or password")
                |> render("login.html")
        end
    end
end
