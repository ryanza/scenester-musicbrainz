# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.

# Although this is not needed for an api-only application, rails4
# requires secret_key_base or secret_token to be defined, otherwise an
# error is raised.
# Using secret_token for rails3 compatibility. Change to secret_key_base
# to avoid deprecation warning.
# Can be safely removed in a rails3 api-only application.
ScenesterMusicbrainz::Application.config.secret_token = 'adcda2cd37d5b1c20e2339b44be4293ef05d57ad0dd6357d21113b179dac456ddb9cb527a7ea5f1f4613856d7bbdd9874c226c03f806f7cd37dc28f4178a0efc'
ScenesterMusicbrainz::Application.config.secret_key_base = 'ab62cc0bd5218eb234b5320b53fea281f6f7b5311c2ae6f1e246aa6207eb7368be8066a9ca5cfb2c6b0ae2eeddf5de69851e2f1922f3071dc899368247877c4a'
