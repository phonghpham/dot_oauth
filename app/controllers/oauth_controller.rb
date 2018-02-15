class OauthController < ApplicationController
  before_action :oauth_client

  def show
    @company_name = company_name
    @auth_url = oauth_client.auth_code.authorize_url(
      redirect_uri: DOTLOOP_CONFIG['redirect_uri'],
      scope: DOTLOOP_CONFIG['scope'], 
      state: @company_name)
  end

  def callback
    code = callback_params['code']
    token = oauth_client.auth_code.get_token()
  end

  private

  def oauth_client
    @_oauth_client ||= Oauth2::Client.new(
      DOTLOOP_CONFIG['client_id'],
      Rails.application.secrets.dotloop_secret_key,
      site: DOTLOOP_CONFIG['site'], 
      authorize_url: DOTLOOP_CONFIG['authorize_url'])    
  end

  def company_name
    params.require(:company_name)
  end

  def callback_params
    params.permit(:code, :state, :action)
  end
end

