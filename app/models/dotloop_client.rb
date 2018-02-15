require 'oauth2'

# Simple wrapper around OAuth2 client
class DotloopClient < OAuth2::Client
  attr_accessor :config

  # Since the domain for auth and API access is different, the initializer
  # accepts as a 'type' param so the correct site can be selected for the use case
  def initialize(config, type = 'authorize')
    self.config = config
    super(
      config['client_id'],
      Rails.application.secrets.dotloop_secret_key,
      site: config["#{type}_site"], authorize_url: config['authorize_url'])
  end

  def authorize_url_with_state(state)
    auth_code.authorize_url(
      redirect_uri: config['redirect_uri'],
      scope: config['scope'],
      state: state
    )
  end
end
