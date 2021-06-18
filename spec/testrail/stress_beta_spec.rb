require "config"

RSpec.describe Testrail::Client::Api do
    # This test needs credentials to Testrail, they are stored on ./testrail.yaml
    # yaml format:
    # testrail_user: "user"
    # testrail_key: "password"
    before :all do
        WebMock.allow_net_connect!  # Allow real Http requests
        base_url = "https://eyeo.testrail.com/"
        Config.yaml_file(File.join(File.dirname(__FILE__),"testrail.yaml"))
        tr_config = Config.get
        @client = Testrail::Client::Api.new(base_url, beta=true)
        @client.user = tr_config.testrail_user
        @client.password = tr_config.testrail_key
    end

    it "Hits API Rate Limits" do
        expect {
        threads = []
        (0..200).each do  |i|
            threads << Thread.new { project = @client.get_project(1) }
            STDERR.puts("thread #{i}")
        end
        threads.each(&:join)
        }.not_to raise_error(Testrail::Client::APIError)
    end

end