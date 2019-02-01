# YandexCloud

A simple Elixir wrapper to Yandex Cloud API

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `yandex_cloud` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:yandex_cloud, "~> 0.1.0"}
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

### Get IAM-token for cloud API access

Request for getting IAM-token for access to cloud API. Valid 12 hours.

```elixir
# without params
YandexCloud.get_iam_token

# or with key
YandexCloud.get_iam_token([oauth_token: "API_KEY"])
```

#### Options

    oauth_token - API KEY, optional

#### Responses

```elixir
# successful response
{:ok, %{"iamToken" => iam_token}}

# response with errors
{:error, %{"code" => code, "details" => details, "message" => message}}
```

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
