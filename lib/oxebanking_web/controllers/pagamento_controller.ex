defmodule OxebankingWeb.PagamentoController do
  use OxebankingWeb, :controller
  alias Oxebanking.Pagamentos
  alias Oxebanking.Pagamentos.Pagamento
  alias Oxebanking.Repo

  def index(conn, _params) do
    pagamentos = Pagamentos.listar_todos()
    conn
    |> put_view(OxebankingWeb.PagamentoHTML)
    |> render("index.html", pagamentos: pagamentos)
  end

  def show(conn, %{"id" => id}) do
    pagamento = Repo.get!(Pagamento, id)
    conn
    |> put_view(OxebankingWeb.PagamentoView)
    |> render("show.html", pagamento: pagamento)
  end

  def criar(conn, %{
    "descricao" => descricao,
    "id_usuario" => id_usuario,
    "metodo_pagamento" => metodo_pagamento,
    "valor" => valor,
    "saldo" => saldo  # Adicione o saldo como parâmetro
  } = params) do
    IO.inspect(params, label: "Parâmetros Recebidos")

    valor_float = String.to_float(valor)
    saldo_float = String.to_float(saldo)

    # Verificação do saldo: bloqueia se o saldo for insuficiente
    if saldo_float < valor_float do
      conn
      |> put_status(:unprocessable_entity)
      |> json(%{status: "erro", motivo: "Saldo insuficiente"})
    else
      # Processando os dados de pagamento
      dados_pagamento = case metodo_pagamento do
        "pix" -> %{
          "id_usuario" => id_usuario,
          "metodo_pagamento" => metodo_pagamento,
          "valor" => valor_float,
          "descricao" => descricao,
          "destinatario_pix" => Map.get(params, "destinatario")
        }
        "credito" ->
          # Pega `fatura_pendente` ou define como 0.0
          fatura_pendente_float = Map.get(params, "fatura_pendente", "0.00") |> String.to_float()
          IO.inspect(fatura_pendente_float, label: "Fatura Pendente Processada")

          %{
            "id_usuario" => id_usuario,
            "metodo_pagamento" => metodo_pagamento,
            "valor" => valor_float,
            "descricao" => descricao,
            "fatura_pendente" => valor_float + fatura_pendente_float
          }
        _ -> %{
          "id_usuario" => id_usuario,
          "metodo_pagamento" => metodo_pagamento,
          "valor" => valor_float,
          "descricao" => descricao
        }
      end

      IO.inspect(dados_pagamento, label: "Dados processados")

      case Pagamentos.processar_pagamento(dados_pagamento) do
        {:ok, resposta} ->
          conn
          |> put_status(:created)
          |> json(%{status: "sucesso", dados: resposta})

        {:error, changeset} when is_struct(changeset, Ecto.Changeset) ->
          errors = Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
            Enum.reduce(opts, msg, fn {key, val}, acc ->
              String.replace(acc, "%{#{key}}", to_string(val))
            end)
          end)
          conn
          |> put_status(:unprocessable_entity)
          |> json(%{status: "erro", motivo: errors})

        {:error, motivo} ->
          conn
          |> put_status(:unprocessable_entity)
          |> json(%{status: "erro", motivo: motivo})
      end
    end
  end

  def listar(conn, _params) do
    pagamentos = Pagamentos.listar_todos()
    conn
    |> put_status(:ok)
    |> json(%{status: "sucesso", dados: pagamentos})
  end

  def mostrar(conn, %{"id" => id_usuario}) do
    case Pagamentos.buscar_pagamento(id_usuario) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{status: "erro", motivo: "Pagamento não encontrado"})
      pagamento ->
        conn
        |> put_status(:ok)
        |> json(%{status: "sucesso", dados: pagamento})
    end
  end
end
