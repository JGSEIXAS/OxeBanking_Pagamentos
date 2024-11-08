defmodule Oxebanking.PagamentosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Oxebanking.Pagamentos` context.
  """

  @doc """
  Generate a pagamento.
  """
  def pagamento_fixture(attrs \\ %{}) do
    {:ok, pagamento} =
      attrs
      |> Enum.into(%{
        data_pagamento: ~D[2024-10-08],
        descricao: "some descricao",
        status: "some status",
        valor: 120.5
      })
      |> Oxebanking.Pagamentos.processar_pagamento()

    pagamento
  end
end
