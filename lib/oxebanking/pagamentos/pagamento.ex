defmodule Oxebanking.Pagamentos.Pagamento do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Jason.Encoder, only: [:id, :id_usuario, :metodo_pagamento, :valor, :descricao, :destinatario, :codigo_barras, :fatura_pendente, :inserted_at, :updated_at]}

  schema "pagamentos" do
    field :id_usuario, :integer, primary_key: true  # Definimos id_usuario como a chave primária
    field :metodo_pagamento, :string
    field :valor, :float
    field :descricao, :string
    field :destinatario, :string # Substituído `destinatario_pix` por `destinatario`
    field :codigo_barras, :string
    field :fatura_pendente, :float, default: nil

    timestamps()
  end

  @doc false
  def changeset(pagamento, attrs) do
    pagamento
    |> cast(attrs, [:id_usuario, :metodo_pagamento, :valor, :descricao, :destinatario, :codigo_barras, :fatura_pendente])
    |> validate_required([:id_usuario, :metodo_pagamento, :valor, :descricao])
    |> validate_inclusion(:metodo_pagamento, ["pix", "debito", "boleto", "credito"])
    |> validate_number(:valor, greater_than: 0, message: "O valor deve ser maior que zero.")
    |> unique_constraint(:id_usuario)  # Garante que o id_usuario seja único
  end
end
