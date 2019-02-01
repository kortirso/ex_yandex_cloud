defmodule YandexCloud.Translate do
  @moduledoc """
  Client requests to Translate service
  """

  @cloud_base_url "https://translate.api.cloud.yandex.net/translate/v1/"

  @doc """
  Get available languages for translation.

  ## Example

      iex> YandexCloud.Translate.langs([iam_token: ""])
      {:ok, %{"languages" => [%{"language" => "az"}, %{...}, ...]}}

  ### Options

      iam_token - IAM-token, required
      folder_id - folder ID of your account at YandexCloud, optional

  """
  @spec langs(keyword()) :: {:ok, %{}}

  def langs(options) when is_list(options), do: call("languages", options)

  @doc """
  Detect language for text.

  ## Example

      iex> YandexCloud.Translate.detect([iam_token: "", text: "Hello"])
      {:ok, %{"language" => "en"}}

  ### Options

      iam_token - IAM-token, required
      folder_id - folder ID of your account at YandexCloud, otional]
      text - text for detection, required
      hint - list of possible languages, optional, example - "en,ru"

  """
  @spec detect(keyword()) :: {:ok, %{}}

  def detect(options) when is_list(options), do: call("detect", options)

  @doc """
  Translate word or phrase.

  ## Example

      iex> YandexCloud.Translate.translate([iam_token: iam_token, text: "hello world", source: "en", target: "es"])
      {:ok, %{"translations" => [%{"text" => "hola mundo"}]}}

  ### Options

      iam_token - IAM-token, required
      folder_id - folder ID of your account at YandexCloud, optional
      text - text for detection, required
      source - source language, ISO 639-1 format (like "en"), optional
      target - target language, ISO 639-1 format (like "ru"), required
      format - text format, one of the [plain|html], default - plain, optional

  """
  @spec translate(keyword()) :: {:ok, %{}}

  def translate(options) when is_list(options), do: call("translate", options)

  # perform request
  defp call(type, args) do
    type
    |> fetch(args)
    |> parse()
  end

  # MAIN FUNCTIONS

  # make request
  defp fetch(type, args) do
    case HTTPoison.post(@cloud_base_url <> type, body(args, type), headers(args[:iam_token])) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %HTTPoison.Response{body: body}} -> {:error, body}
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
    end
  end

  # parse results
  defp parse({result, response}), do: {result, Poison.Parser.parse!(response)}

  # ADDITIONAL FUNCTIONS

  # generate body for request
  defp body(args, type) do
    args
    |> Keyword.put(:folderId, cloud_folder_id(args[:folder_id]))
    |> Stream.filter(fn {key, _} -> Enum.member?(valid_args(type), key) end)
    |> Stream.map(fn {key, value} -> "#{key}=#{URI.encode_www_form(value)}" end)
    |> Enum.join("&")
  end

  # list with available options based on request type
  defp valid_args(type) do
    case type do
      "languages" -> [:folderId]
      "detect" -> [:folderId, :text, :hint]
      "translate" -> [:folderId, :text, :source, :target, :format]
      _ -> []
    end
  end

  defp cloud_folder_id(nil), do: Application.get_env(:yandex_cloud, :translate_folder_id) || ""
  defp cloud_folder_id(folder_id), do: folder_id

  # define headers for request
  defp headers(iam_token), do: [{"Content-Type", "application/x-www-form-urlencoded"}, {"Authorization", "Bearer #{iam_token}"}]
end
