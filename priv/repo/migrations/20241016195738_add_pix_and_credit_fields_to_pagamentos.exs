defmodule Oxebanking.Repo.Migrations.AddPixAndCreditFieldsToPagamentos do
  use Ecto.Migration

  def change do
    alter table(:pagamentos) do
      add :destinatario_pix, :string
      add :fatura_pendente, :float
    end
  end
end
