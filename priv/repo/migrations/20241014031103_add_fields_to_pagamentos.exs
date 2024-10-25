defmodule Oxebanking.Repo.Migrations.AddFieldsToPagamentos do
  use Ecto.Migration

  def change do
    alter table(:pagamentos) do
      add :id_fatura, :string
      add :id_compra, :string
      add :metodo_pagamento, :string
    end
  end
end
