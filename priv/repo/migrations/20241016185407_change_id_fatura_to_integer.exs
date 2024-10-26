defmodule Oxebanking.Repo.Migrations.ChangeIdFaturaToInteger do
  use Ecto.Migration

  def change do
    alter table(:pagamentos) do
      modify :id_usuario, :integer, using: "id_usuario::integer"
    end
  end

  def up do
    execute "ALTER TABLE pagamentos ALTER COLUMN id_usuario TYPE integer USING (id_usuario::integer)"
  end

  def down do
    execute "ALTER TABLE pagamentos ALTER COLUMN id_usuario TYPE varchar"
  end
end
