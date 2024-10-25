defmodule OxebankingWeb.ChangesetJSON do
  def render("error.json", %{changeset: changeset}) do
    %{errors: changeset_errors(changeset)}
  end

  defp changeset_errors(changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(&translate_error/1)
  end

  defp translate_error({msg, _opts}) do
    # Aqui você pode usar Gettext se precisar traduzir mensagens de erro
    # gettext(msg, opts)
    msg
  end
end
