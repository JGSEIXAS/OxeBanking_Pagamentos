defmodule OxebankingWeb do
  def controller do
    quote do
      use Phoenix.Controller, namespace: OxebankingWeb
      import Plug.Conn
      import OxebankingWeb.Gettext
      alias OxebankingWeb.Router.Helpers, as: Routes
    end
  end

  def html do
    quote do
      import Phoenix.HTML
      import Phoenix.Component
      import OxebankingWeb.Gettext
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/oxebanking_web/templates",
        namespace: OxebankingWeb

      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      unquote(html())
    end
  end

  def static_paths do
    ~w(assets fonts images favicon.ico robots.txt)
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import OxebankingWeb.Gettext
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import OxebankingWeb.Gettext
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
