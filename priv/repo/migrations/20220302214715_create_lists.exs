defmodule SimpleEmailList.Repo.Migrations.CreateLists do
  use Ecto.Migration

  def change do
    create table(:lists, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:lists, [:user_id])
    create unique_index(:lists, [:name, :user_id])
  end
end
