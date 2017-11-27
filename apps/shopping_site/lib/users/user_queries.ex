defmodule ShoppingSite.UserQueries do
    import Ecto.Query

    alias ShoppingSite.{Repo, Users}


    def login(username, password) do
        encrypted_password = Cipher.encrypt password
        user = 
            Users
            |> where([u], u.username == ^username 
                      and u.password == ^encrypted_password)
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


    def get_user(id) do
        Repo.get(Users, id)
    end


    def delete_user(id) do
        Users
        |> where([u], u.id == ^id)
        |> Repo.delete_all
    end


    def create_user(username, password) do
        encrypted_password = Cipher.encrypt(password)
        Repo.insert!(%Users{ username: username, 
                             password: encrypted_password
                           })
    end
end