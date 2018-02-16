namespace :dotloop do
  
  desc 'get authorization code'
  task get_auth_code: :environment do
    byebug
    dotloop_client = DotloopClient.new(DOTLOOP_CONFIG, 'authorize')
  end
end