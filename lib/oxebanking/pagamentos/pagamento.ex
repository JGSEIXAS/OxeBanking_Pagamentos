defmodule Oxebanking.Pagamentos.Pagamento do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Jason.Encoder, only: [:id, :id_usuario, :metodo_pagamento, :valor, :descricao, :destinatario_pix, :fatura_pendente, :inserted_at, :updated_at]}

  schema "pagamentos" do
    field :id_usuario, :integer, primary_key: true  # Aqui definimos id_usuario como a chave primária
    field :metodo_pagamento, :string
    field :valor, :float
    field :descricao, :string
    field :destinatario_pix, :string, default: nil
    field :fatura_pendente, :float, default: nil

    timestamps()
  end

  @doc false
  def changeset(pagamento, attrs) do
    pagamento
    |> cast(attrs, [:id_usuario, :metodo_pagamento, :valor, :descricao, :destinatario_pix, :fatura_pendente])
    |> validate_required([:id_usuario, :metodo_pagamento, :valor, :descricao])
    |> validate_inclusion(:metodo_pagamento, ["pix", "debito", "boleto", "credito"])
    |> validate_number(:valor, greater_than: 0, message: "O valor deve ser maior que zero.")
    |> unique_constraint(:id_usuario)  # Garante que o id_usuario seja único
  end
end
