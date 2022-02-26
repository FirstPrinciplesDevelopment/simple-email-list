defmodule SimpleEmailList.Signups.Signup do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "signups" do
    field :email, :string
    field :name, :string

    # field :user_id, :binary_id
    belongs_to :user, SimpleEmailList.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(signup, attrs) do
    signup
    |> cast(attrs, [:email, :name, :user_id])
    |> validate_required([:email, :user_id])
    |> unique_constraint([:email, :user_id])
  end
end
