defmodule YandexCloud.TranslateTest do
  use ExUnit.Case
  alias YandexCloud.Translate

  setup_all do
    {:ok, %{"iamToken" => iam_token}} = YandexCloud.get_iam_token
    {:ok, iam_token: iam_token}
  end

  test "request for getting languages with invalid key" do
    {:error, %{"error_message" => error_message}} = Translate.languages([iam_token: "1"])

    assert error_message == "rpc error: code = Unauthenticated desc = Unable to parse the signed token"
  end

  test "request for detecting language with invalid key" do
    {:error, %{"error_message" => error_message}} = Translate.detect([iam_token: "1", text: "Hello"])

    assert error_message == "rpc error: code = Unauthenticated desc = Unable to parse the signed token"
  end

  test "request for translating text with invalid key" do
    {:error, %{"error_message" => error_message}} = Translate.translate([iam_token: "1", text: "Hello", lang: "ru"])

    assert error_message == "rpc error: code = Unauthenticated desc = Unable to parse the signed token"
  end

  test "request for getting languages", state do
    {:ok, %{"languages" => languages}} = Translate.languages([iam_token: state[:iam_token]])

    assert is_list(languages) == true
  end

  test "request for detecting language", state do
    {:ok, %{"language" => language}} = Translate.detect([iam_token: state[:iam_token], text: "Hello"])

    assert language == "en"
  end

  test "request for translating text", state do
    {:ok, %{"translations" => [%{"text" => text}]}} = Translate.translate([iam_token: state[:iam_token], text: "Hello", target: "es"])

    assert text == "Saludar"
  end
end
