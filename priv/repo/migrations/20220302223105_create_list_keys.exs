defmodule SimpleEmailList.Repo.Migrations.CreateListKeys do
  use Ecto.Migration

  def change do
    create table(:list_keys, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :client_code, :uuid
      add :list_id, references(:lists, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:list_keys, [:list_id])
  end
end
