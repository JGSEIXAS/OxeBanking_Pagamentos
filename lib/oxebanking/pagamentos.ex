defmodule Oxebanking.Pagamentos do
  import Ecto.Query, only: [from: 2]
  alias Oxebanking.Repo
  alias Oxebanking.Pagamentos.Pagamento

  @doc """
  Processa um pagamento com todos os dados fornecidos.
  """
  def processar_pagamento(dados_pagamento) do
    %Pagamento{}
    |> Pagamento.changeset(dados_pagamento)
    |> Repo.insert()
  end

 @doc """
  Busca um pagamento pelo ID da fatura (id_usuario).
  """
# Função para buscar pagamentos por id_usuario (vários resultados)
def buscar_pagamento(id_usuario) do
  query = from(p in Pagamento, where: p.id_usuario == ^id_usuario)
  Repo.all(query)
end


  @doc """
  Lista todos os pagamentos armazenados no banco de dados.
  """
  def listar_todos do
    Repo.all(Pagamento)
  end

end
