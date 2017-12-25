defmodule ShoppingSiteWeb.SessionController do
  use ShoppingSiteWeb.Web, :controller

  def new(conn, _params) do
    render(conn, "login.html")
  end

  def create(conn, %{"session" => session_params}) do
    case ShoppingSite.UserQueries.login(session_params["username"], session_params["password"]) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        |> redirect(to: "/admin")

      :error ->
        conn
        |> render("login.html")
    end
  end

  def delete(conn, _) do
    conn
    |> delete_session(:current_user)
    |> redirect(to: "/")
  end
end
