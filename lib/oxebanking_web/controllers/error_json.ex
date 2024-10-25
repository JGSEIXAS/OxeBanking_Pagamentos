defmodule OxebankingWeb.ErrorHTML do

  # Define o que renderizar para erros 404
  def render("404.html", _assigns) do
    "<h1>Página não encontrada</h1>"
  end

  # Define o que renderizar para erros 500
  def render("500.html", _assigns) do
    "<h1>Erro interno do servidor</h1>"
  end

  # Caso queira adicionar outros tipos de erro, adicione mais funções aqui
end
