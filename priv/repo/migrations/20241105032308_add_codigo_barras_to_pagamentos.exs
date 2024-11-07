defmodule Oxebanking.Repo.Migrations.AddCodigoBarrasToPagamentos do
  use Ecto.Migration

  def change do
    # Adicionar coluna codigo_barras se não existir
    unless column_exists?(:pagamentos, :codigo_barras) do
      alter table(:pagamentos) do
        add :codigo_barras, :string
      end
    end

    # Se a coluna destinatario_pix existir e a coluna destinatario não existir, renomear destinatario_pix para destinatario
    if column_exists?(:pagamentos, :destinatario_pix) and not column_exists?(:pagamentos, :destinatario) do
      alter table(:pagamentos) do
        rename :destinatario_pix, to: :destinatario
      end
    end

    # Se a coluna destinatario não existir, adicioná-la
    unless column_exists?(:pagamentos, :destinatario) do
      alter table(:pagamentos) do
        add :destinatario, :string
      end
    end

    # Se a coluna destinatario_pix existir e a coluna destinatario existir, combinar os dados e remover a coluna destinatario_pix
    if column_exists?(:pagamentos, :destinatario_pix) do
      execute("""
      UPDATE pagamentos
      SET destinatario = COALESCE(destinatario, '') || ' ' || COALESCE(destinatario_pix, '')
      WHERE destinatario_pix IS NOT NULL
      """)
      alter table(:pagamentos) do
        remove :destinatario_pix
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
