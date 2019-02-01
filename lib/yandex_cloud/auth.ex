defmodule YandexCloud.Auth do
  @moduledoc """
  Auth requests
  """

  @iam_token_url "https://iam.api.cloud.yandex.net/iam/v1/tokens"
  @iam_token_headers [{"Content-Type", "application/json"}]

  @doc """
  Get IAM-token for using it in requests to YandexCloud. Valid 12 hours.

  ## Example

      iex> YandexCloud.Auth.token
      {:ok, %{"iamToken" => ""}}

  """
  @spec token() :: {:ok, %{iamToken: String.t()}}

  def token, do: token([])

  @doc """
  Get IAM-token for using it in requests to YandexCloud. Valid 12 hours.

  ## Examples

      iex> YandexCloud.Auth.token([oauth_token: oauth_token])
      {:ok, %{"iamToken" => ""}}

  """
  @spec token(keyword()) :: {:ok, %{iamToken: String.t()}}

  def token(params) when is_list(params) do
    params[:oauth_token]
    |> fetch_iam_token()
    |> parse()
  end

  defp fetch_iam_token(api_key) do
    body = Poison.encode!(%{"yandexPassportOauthToken" => cloud_api_key(api_key)})

    case HTTPoison.post(@iam_token_url, body, @iam_token_headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %HTTPoison.Response{body: body}} -> {:error, body}
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
    end
  end

  defp cloud_api_key(nil), do: Application.get_env(:yandex_cloud, :cloud_api_key) || ""
  defp cloud_api_key(api_key), do: api_key

  # parse results
  defp parse({result, response}), do: {result, Poison.Parser.parse!(response)}
end
