defmodule SimpleEmailList.Signups.Signup do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "signups" do
    field :email, :string
    field :name, :string

    # field :list_id, :binary_id
    belongs_to :list, SimpleEmailList.Signups.List

    timestamps()
  end

  @doc false
  def changeset(signup, attrs) do
    signup
    |> cast(attrs, [:email, :name])
    |> validate_required([:email, :list_id])
    |> unique_constraint([:email, :list_id])
    |> validate_email_address(:email)
  end

  # TODO: implement
  defp validate_email_address(changeset, field) when is_atom(field) do
    validate_change(changeset, field, fn field, value ->
      []
    end)
  end
end
