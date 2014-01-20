# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Server::Application.config.secret_key_base = 'a35f61890f98f9ead2315de7c46efcb6a3642c773b45bd3643194116d45a1d630a122cbc9ea0026cc9ee59d5004f1c5ab2b87c275b1f472d3a4ffce96c57ec9b'
