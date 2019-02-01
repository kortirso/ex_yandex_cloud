defmodule YandexCloud do
  @moduledoc """
  Documentation for YandexCloud.
  """

  alias YandexCloud.Auth

  @doc """
  Get IAM-token for using it in requests to Yandex Cloud API. Valid 12 hours.

  ## Example

      iex> YandexCloud.get_iam_token
      {:ok, %{"iamToken" => ""}}

      iex> YandexCloud.get_iam_token([oauth_token: "12345"])
      {:ok, %{"iamToken" => ""}}

  """

  def get_iam_token, do: Auth.token()
  def get_iam_token(params) when is_list(params), do: Auth.token(params)
end
