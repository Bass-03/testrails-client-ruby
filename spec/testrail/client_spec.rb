RSpec.describe Testrail::Client do
  it "has a version number" do
    expect(Testrail::Client::VERSION).not_to be nil
  end
end

RSpec.describe Testrail::Client::Request do
  before :all do
    base_url = "https://test.testrail.com/"
    user     = "username"
    password = "password"

    @client = Testrail::Client::Request.new(base_url)
    @client.user = user
    @client.password = password
  end

  it ".send_get" do
    uri = "get_case/1"
    response = @client.send_get(uri)
    #STDERR.puts JSON.pretty_generate(response)
    expect(response).to include(
      "REQUEST_METHOD" => "GET",
      "CONTENT_TYPE" => "application/json",
      "PATH_INFO" => "/index.php",
      "QUERY_STRING" => "/api/v2/get_case/1",
      "SERVER_PORT" => 443,
      "HTTP_ACCEPT_ENCODING" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
      "HTTP_ACCEPT" => "*/*",
      "HTTP_USER_AGENT" => "Ruby",
      "HTTP_HOST" => "test.testrail.com",
      "HTTP_AUTHORIZATION" => "Basic dXNlcm5hbWU6cGFzc3dvcmQ=",
    )
  end

  it ".send_post" do
    uri = "add_case/1"
    response = @client.send_post(uri,{"foo": "bar", "biz": "baz"})
    #STDERR.puts JSON.pretty_generate(response)
    expect(response).to include(
      "REQUEST_METHOD" => "POST",
      "CONTENT_TYPE" => "application/json",
      "PATH_INFO" => "/index.php",
      "QUERY_STRING" => "/api/v2/add_case/1",
      "SERVER_PORT" => 443,
      "HTTP_ACCEPT_ENCODING" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
      "HTTP_ACCEPT" => "*/*",
      "HTTP_USER_AGENT" => "Ruby",
      "HTTP_HOST" => "test.testrail.com",
      "HTTP_AUTHORIZATION" => "Basic dXNlcm5hbWU6cGFzc3dvcmQ=",
      "BODY" => {
        "foo" => "bar",
        "biz" => "baz"
       }
     )
   end

   it ".send_post (multipart form)" do
     uri = "add_case/1"
     file = File.dirname(__FILE__) + "/../../README.md"
     response = @client.send_post(uri,[['attachment',File.open(file)]])
     #STDERR.puts JSON.pretty_generate(response)
     expect(response).to include(
       "REQUEST_METHOD" => "POST",
       "CONTENT_TYPE" => "multipart/form-data",
       "PATH_INFO" => "/index.php",
       "QUERY_STRING" => "/api/v2/add_case/1",
       "SERVER_PORT" => 443,
       "HTTP_ACCEPT_ENCODING" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
       "HTTP_ACCEPT" => "*/*",
       "HTTP_USER_AGENT" => "Ruby",
       "HTTP_HOST" => "test.testrail.com",
       "HTTP_AUTHORIZATION" => "Basic dXNlcm5hbWU6cGFzc3dvcmQ=",
      )
  end

end
