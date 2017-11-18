defmodule ShoppingSite.UserQueries do
    import Ecto.Query

    alias ShoppingSite.{Repo, Users}


    def login(username, password) do
        user = 
            Users
            |> where([u], u.username == ^username and u.password == ^password)
            |> select([u], %{ username: u.username,
                          id: u.id
                        })
            |> Repo.one
        if user do
            {:ok, user}
        else
            :error
        end
    end


    def create_user(username, password) do
        Repo.insert!(%Users{ username: username, password: password})
    end
end