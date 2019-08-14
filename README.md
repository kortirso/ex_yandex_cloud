# YandexCloud

A simple Elixir wrapper to Yandex Cloud API

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `yandex_cloud` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:yandex_cloud, "~> 0.3.2"}
  ]
end
```

## Get access to API

### Getting a Cloud API KEY

To make api requests in Yandex.Cloud you must include IAM-token in request headers and for getting IAM-token you must have Oauth token.

Instruction for getting Oauth token is [here](https://cloud.yandex.com/docs/iam/operations/iam-token/create)

### Configuration

The default behaviour is to configure using the application environment:

In config/config.exs, add:

```elixir
config :yandex_cloud, cloud_api_key: "API_KEY"
```

## Usage

## Get IAM-token for cloud API access

Request for getting IAM-token for access to cloud API. Valid 12 hours.

```elixir
# without params
YandexCloud.get_iam_token

# or with key
YandexCloud.get_iam_token(%{oauth_token: "API_KEY"})
```

#### Options

    oauth_token - API KEY, optional

#### Responses

```elixir
# successful response
{:ok, %{"iamToken" => iam_token}}

# response with errors
{:error, %{"code" => code, "message" => message}}
```

## Translate service

### Configuration

For using Translate service you need additionally add FOLDER_ID.

Instruction for getting FOLDER_ID is [here](https://cloud.yandex.com/docs/translate/concepts/auth)

In config/config.exs, add:

```elixir
config :yandex_cloud, translate_folder_id: "FOLDER_ID"
```

Or you can add folder_id param to each request.

### Supported languages

Request for getting list of supported languages is #languages.

```elixir
YandexCloud.Translate.languages(%{iam_token: ""})
```

#### Options

    iam_token - IAM-token, required
    folder_id - folder ID of your account at Yandex.Cloud, optional

### Detection

Request for detecting language of text is #detect.

```elixir
YandexCloud.Translate.detect(%{iam_token: "", text: "Hello"})
```

#### Options

    iam_token - IAM-token, required
    folder_id - folder ID of your account at Yandex.Cloud, optional
    text - text for detection, required
    hint - list of possible languages, optional, example - "en,ru"

### Translation

Request for translating text is #translate.

```elixir
YandexCloud.Translate.translate(%{iam_token: "", text: "Hello", target: "ru"})
```

#### Options

    iam_token - IAM-token, required
    folder_id - folder ID of your account at Yandex.Cloud, optional
    text - text for detection, required
    source - source language, ISO 639-1 format (like "en"), optional
    target - target language, ISO 639-1 format (like "ru"), required
    format - text format, one of the [plain|html], default - plain, optional

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kortirso/ex_yandex_cloud.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Disclaimer

Use this package at your own peril and risk.

## Documentation

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/yandex_translator](https://hexdocs.pm/yandex_cloud).
