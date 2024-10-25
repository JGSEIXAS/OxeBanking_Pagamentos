defmodule Oxebanking.Repo.Migrations.AddDataPagamentoToPagamentos do
  use Ecto.Migration

  def change do
    alter table(:pagamentos) do
      add :data_pagamento, :string
    end
  end
end
