require 'sinatra/base'

class FakeTestRail < Sinatra::Base
  get '/index.php' do
    request.env.to_json
  end
  post '/index.php' do
    #STDERR.puts request.body.read
    str_body = request.body.read
    unless str_body.empty?
      request.env["BODY"] = JSON.parse(str_body)
    end
    request.env.to_json
  end

  not_found do
    status 404
    request.env.to_json
  end

end
