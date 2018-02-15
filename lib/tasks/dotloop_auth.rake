namespace :dotloop do
  
  desc 'get authorization code'
  task :get_auth_code do

    dotloop_client = DotloopClient.new(DOTLOOP_CONFIG, 'authorize')
  end
end