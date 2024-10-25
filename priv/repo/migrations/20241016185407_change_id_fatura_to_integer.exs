defmodule Oxebanking.Repo.Migrations.ChangeIdFaturaToInteger do
  use Ecto.Migration

  def change do
    alter table(:pagamentos) do
      modify :id_fatura, :integer, using: "id_fatura::integer"
    end
  end

  def up do
    execute "ALTER TABLE pagamentos ALTER COLUMN id_fatura TYPE integer USING (id_fatura::integer)"
  end

  def down do
    execute "ALTER TABLE pagamentos ALTER COLUMN id_fatura TYPE varchar"
  end
end
