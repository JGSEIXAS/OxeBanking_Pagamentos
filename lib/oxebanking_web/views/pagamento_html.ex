defmodule OxebankingWeb.PagamentoHTML do
  use OxebankingWeb, :html
  require Phoenix.Template
  embed_templates "pagamento_html/*"

  def render("index.html", assigns) do
    ~H"""
    <h1>Lista de Pagamentos</h1>
    <ul>
      <%= for pagamento <- @pagamentos do %>
        <li>ID: <%= pagamento.id %>, Método: <%= pagamento.metodo_pagamento %>, Fatura: <%= pagamento.id_fatura %>, Valor: <%= pagamento.valor %>, Descrição: <%= pagamento.descricao %></li>
      <% end %>
    </ul>
    """
  end
end
