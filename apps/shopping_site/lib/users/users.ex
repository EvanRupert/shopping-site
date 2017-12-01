defmodule ShoppingSite.Users do
    use Ecto.Schema
    import Ecto.Changeset


    schema "users" do
        field :username, :string
        field :password, :string

        timestamps
    end


    def changeset(user, params \\ %{}) do
        user
        |> cast(params, [:username, :password])
        |> validate_required([:username, :password])
        |> validate_length(:username, max: 100)
        |> validate_length(:password, max: 100, min: 8)
    end


end
