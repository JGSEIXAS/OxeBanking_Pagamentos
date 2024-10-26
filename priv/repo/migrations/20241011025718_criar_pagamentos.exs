defmodule Oxebanking.Repo.Migrations.CriarPagamentos do
  use Ecto.Migration

  def change do
    create table(:pagamentos) do
      add :id_usuario, :integer
      add :metodo_pagamento, :string
      add :valor, :float
      add :descricao, :string
      timestamps()
    end
  end
end
