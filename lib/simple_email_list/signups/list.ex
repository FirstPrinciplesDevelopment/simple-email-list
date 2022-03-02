defmodule SimpleEmailList.Signups.List do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "lists" do
    field :name, :string

    # field :user_id, :binary_id
    belongs_to :user, SimpleEmailList.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:name])
    |> validate_required([:name, :user_id])
    |> unique_constraint([:name, :user_id])
  end
end
