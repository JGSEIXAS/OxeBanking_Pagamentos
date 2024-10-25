defmodule Oxebanking.PagamentosTest do
  use Oxebanking.DataCase

  alias Oxebanking.Pagamentos

  describe "pagamentos" do
    alias Oxebanking.Pagamentos.Pagamento

    import Oxebanking.PagamentosFixtures

    @invalid_attrs %{status: nil, valor: nil, data_pagamento: nil, descricao: nil}

    test "list_pagamentos/0 returns all pagamentos" do
      pagamento = pagamento_fixture()
      assert Pagamentos.list_pagamentos() == [pagamento]
    end

    test "get_pagamento!/1 returns the pagamento with given id" do
      pagamento = pagamento_fixture()
      assert Pagamentos.get_pagamento!(pagamento.id) == pagamento
    end

    test "create_pagamento/1 with valid data creates a pagamento" do
      valid_attrs = %{status: "some status", valor: 120.5, data_pagamento: ~D[2024-10-08], descricao: "some descricao"}

      assert {:ok, %Pagamento{} = pagamento} = Pagamentos.create_pagamento(valid_attrs)
      assert pagamento.status == "some status"
      assert pagamento.valor == 120.5
      assert pagamento.data_pagamento == ~D[2024-10-08]
      assert pagamento.descricao == "some descricao"
    end

    test "create_pagamento/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pagamentos.create_pagamento(@invalid_attrs)
    end

    test "update_pagamento/2 with valid data updates the pagamento" do
      pagamento = pagamento_fixture()
      update_attrs = %{status: "some updated status", valor: 456.7, data_pagamento: ~D[2024-10-09], descricao: "some updated descricao"}

      assert {:ok, %Pagamento{} = pagamento} = Pagamentos.update_pagamento(pagamento, update_attrs)
      assert pagamento.status == "some updated status"
      assert pagamento.valor == 456.7
      assert pagamento.data_pagamento == ~D[2024-10-09]
      assert pagamento.descricao == "some updated descricao"
    end

    test "update_pagamento/2 with invalid data returns error changeset" do
      pagamento = pagamento_fixture()
      assert {:error, %Ecto.Changeset{}} = Pagamentos.update_pagamento(pagamento, @invalid_attrs)
      assert pagamento == Pagamentos.get_pagamento!(pagamento.id)
    end

    test "delete_pagamento/1 deletes the pagamento" do
      pagamento = pagamento_fixture()
      assert {:ok, %Pagamento{}} = Pagamentos.delete_pagamento(pagamento)
      assert_raise Ecto.NoResultsError, fn -> Pagamentos.get_pagamento!(pagamento.id) end
    end

    test "change_pagamento/1 returns a pagamento changeset" do
      pagamento = pagamento_fixture()
      assert %Ecto.Changeset{} = Pagamentos.change_pagamento(pagamento)
    end
  end
end
