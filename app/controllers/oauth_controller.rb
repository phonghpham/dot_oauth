class OauthController < ApplicationController
  before_action :oauth_client

  def show
    @company_name = company_name
    @auth_url = oauth_client.authorize_url_with_state(@company_name)
  end

  def callback
    byebug
    code = callback_params['code']
    token = oauth_client.auth_code.get_token()
  end

  private

  def oauth_client
    @_oauth_client ||= DotloopClient.new(DOTLOOP_CONFIG, 'authorize')  
  end

  def company_name
    params.require(:company_name)
  end

  def callback_params
    params.permit(:code, :state, :action)
  end
end

