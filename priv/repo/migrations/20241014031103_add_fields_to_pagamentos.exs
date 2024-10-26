defmodule Oxebanking.Repo.Migrations.AddFieldsToPagamentos do
  use Ecto.Migration

  def change do
    alter table(:pagamentos) do
      add :id_compra, :string
    end
  end
end
