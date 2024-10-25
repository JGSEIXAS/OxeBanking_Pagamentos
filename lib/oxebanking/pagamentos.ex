defmodule Oxebanking.Pagamentos do
  alias Oxebanking.Repo
  alias Oxebanking.Pagamentos.Pagamento  # Certifique-se de que estamos fazendo alias corretamente

  @doc """
  Processa um pagamento com todos os dados fornecidos.
  """
  def processar_pagamento(dados_pagamento) do
    %Pagamento{}
    |> Pagamento.changeset(dados_pagamento)
    |> Repo.insert()
  end

 @doc """
  Busca um pagamento pelo ID da fatura (id_fatura).
  """
  def buscar_pagamento(id_fatura) do
    Repo.get_by(Pagamento, id_fatura: id_fatura)
  end

  @doc """
  Lista todos os pagamentos armazenados no banco de dados.
  """
  def listar_todos do
    Repo.all(Pagamento)
  end

end
