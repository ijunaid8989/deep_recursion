defmodule Deep do
  @registry "http://registry.npmjs.org/"

  alias HTTPoison.Response, as: Resp

  def go(package) do
    HTTPoison.get(@registry <> package <> "/latest")
    |> handle_response()
    |> get_deps()
    |> List.flatten()
    |> Enum.uniq()
  end

  defp get_deps(nil),  do: []
  defp get_deps(deps), do: Enum.map(deps, fn({k, _v}) -> [k | go(k)] end)

  defp handle_response({:ok, %Resp{status_code: 200, body: body}}), do:
    Poison.decode!(body)["dependencies"]
  defp handle_response(_), do: nil
end
