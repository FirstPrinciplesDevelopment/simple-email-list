defmodule SimpleEmailList.Repo.Migrations.CreateListKeys do
  use Ecto.Migration

  def change do
    create table(:list_keys, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :client_code, :uuid, null: false
      add :list_id, references(:lists, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:list_keys, [:list_id])
    create unique_index(:list_keys, [:client_code])
  end
end
