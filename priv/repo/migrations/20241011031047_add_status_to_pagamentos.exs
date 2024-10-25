defmodule Oxebanking.Repo.Migrations.AddStatusToPagamentos do
  use Ecto.Migration

  def change do
    alter table(:pagamentos) do
      add :status, :string
    end
  end
end
