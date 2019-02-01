defmodule YandexCloud.AuthTest do
  use ExUnit.Case
  alias YandexCloud.Auth

  test "request for getting iam_token with invalid key" do
    {:error, %{"code" => code, "details" => details, "message" => message}} = Auth.token([oauth_token: "12345"])

    assert code == 16
    assert is_list(details) == true
    assert message == "Token is invalid or has expired."
  end

  test "request for getting iam_token with valid key" do
    {:ok, %{"iamToken" => iam_token}} = Auth.token()

    assert is_binary(iam_token) == true
  end
end
