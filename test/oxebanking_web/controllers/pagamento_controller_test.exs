defmodule OxebankingWeb.PagamentoControllerTest do
  use OxebankingWeb.ConnCase

  import Oxebanking.PagamentosFixtures

  alias Oxebanking.Pagamentos.Pagamento

  @create_attrs %{
    status: "some status",
    valor: 120.5,
    data_pagamento: ~D[2024-10-08],
    descricao: "some descricao"
  }
  @update_attrs %{
    status: "some updated status",
    valor: 456.7,
    data_pagamento: ~D[2024-10-09],
    descricao: "some updated descricao"
  }
  @invalid_attrs %{status: nil, valor: nil, data_pagamento: nil, descricao: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all pagamentos", %{conn: conn} do
      conn = get(conn, ~p"/api/pagamentos")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create pagamento" do
    test "renders pagamento when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/pagamentos", pagamento: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/pagamentos/#{id}")

      assert %{
               "id" => ^id,
               "data_pagamento" => "2024-10-08",
               "descricao" => "some descricao",
               "status" => "some status",
               "valor" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/pagamentos", pagamento: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update pagamento" do
    setup [:create_pagamento]

    test "renders pagamento when data is valid", %{conn: conn, pagamento: %Pagamento{id: id} = pagamento} do
      conn = put(conn, ~p"/api/pagamentos/#{pagamento}", pagamento: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/pagamentos/#{id}")

      assert %{
               "id" => ^id,
               "data_pagamento" => "2024-10-09",
               "descricao" => "some updated descricao",
               "status" => "some updated status",
               "valor" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, pagamento: pagamento} do
      conn = put(conn, ~p"/api/pagamentos/#{pagamento}", pagamento: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete pagamento" do
    setup [:create_pagamento]

    test "deletes chosen pagamento", %{conn: conn, pagamento: pagamento} do
      conn = delete(conn, ~p"/api/pagamentos/#{pagamento}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/pagamentos/#{pagamento}")
      end
    end
  end

  defp create_pagamento(_) do
    pagamento = pagamento_fixture()
    %{pagamento: pagamento}
  end
end
