defmodule Oxebanking.Repo.Migrations.RemoveDataPagamentoFromPagamentos do
  use Ecto.Migration

  def change do
    alter table(:pagamentos) do
      remove :data_pagamento
    end
  end
end
