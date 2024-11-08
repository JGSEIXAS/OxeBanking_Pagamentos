defmodule OxebankingWeb.Router do
  use OxebankingWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/api", OxebankingWeb do
    pipe_through :api

    post "/pagamentos", PagamentoController, :criar
    get "/pagamentos", PagamentoController, :listar
    get "/pagamentos/:id", PagamentoController, :mostrar
  end

  scope "/", OxebankingWeb do
    pipe_through :browser

    get "/", PagamentoController, :index
    get "/pagamentos", PagamentoController, :index
    get "/pagamentos/:id", PagamentoController, :show
  end
end
