defmodule SimpleEmailList.Signups.ListKey do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "list_keys" do
    field :client_code, Ecto.UUID
    field :list_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(list_key, attrs) do
    list_key
    |> cast(attrs, [:client_code])
    |> validate_required([:client_code])
  end
end
