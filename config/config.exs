import Config

config :logger, :console, format: "[$level] $message\n"


# Start up an instance of CFClient
config :cfclient,
       [api_key: System.get_env("FF_API_KEY"),
       # For additional config you can pass in, see Erlang SDK docs: https://github.com/harness/ff-erlang-server-sdk/blob/main/docs/further_reading.md#further-reading
       # we are just using the main config url here as an example.
        config: [config_url: "https://config.ff.harness.io/api/1.0"]]
