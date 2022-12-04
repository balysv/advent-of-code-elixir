import Config

config :advent_of_code, AdventOfCode.Input,
  allow_network?: true

try do
  import_config "secrets.exs"
rescue
  _ -> :ok
end
