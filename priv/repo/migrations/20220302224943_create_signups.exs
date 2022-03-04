defmodule SimpleEmailList.Repo.Migrations.CreateSignups do
  use Ecto.Migration

  def change do
    create table(:signups, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string, null: false
      add :name, :string
      add :list_id, references(:lists, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:signups, [:list_id])
    create unique_index(:signups, [:email, :list_id])
  end
end
