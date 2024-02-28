defmodule Utils do
def random_string do
    :base64.encode(:crypto.strong_rand_bytes(32))
end
end