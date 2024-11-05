defmodule Oxebanking.Repo.Migrations.UpdatePagamentos do
  use Ecto.Migration

  def change do
    alter table(:pagamentos) do
      # Adicionar coluna codigo_barras se não existir
      if !column_exists?(:pagamentos, :codigo_barras) do
        add :codigo_barras, :string
      end

      # Renomear coluna destinatario_pix para destinatario se não existir
      if column_exists?(:pagamentos, :destinatario_pix) and !column_exists?(:pagamentos, :destinatario) do
        rename :destinatario_pix, to: :destinatario
      end
    end
  end

  defp column_exists?(table, column) do
    query = """
    SELECT column_name
    FROM information_schema.columns
    WHERE table_name='#{table}' AND column_name='#{column}'
    """
    Ecto.Adapters.SQL.query!(Oxebanking.Repo, query).num_rows > 0
  end
end
