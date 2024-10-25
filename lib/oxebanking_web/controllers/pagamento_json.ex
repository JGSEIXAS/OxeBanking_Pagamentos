defmodule OxebankingWeb.PagamentoJSON do
  alias Oxebanking.Pagamentos.Pagamento

  @doc """
  Renders a list of pagamentos.
  """
  def index(%{pagamentos: pagamentos}) do
    %{data: for(pagamento <- pagamentos, do: data(pagamento))}
  end

  @doc """
  Renders a single pagamento.
  """
  def show(%{pagamento: pagamento}) do
    %{data: data(pagamento)}
  end

  defp data(%Pagamento{} = pagamento) do
    %{
      id: pagamento.id,
      descricao: pagamento.descricao,
      valor: pagamento.valor,
      metodo_pagamento: pagamento.metodo_pagamento,
      id_fatura: pagamento.id_fatura
    }
  end
end
