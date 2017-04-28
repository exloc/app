require "webmock/rspec"

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before do
    exloc_example_contents = File.read(Rails.root.join("docs", "github", "exloc-example-contents.json"))

    stub_request(:get, "https://api.github.com/repos/exloc/example/contents?access_token=#{ENV['GITHUB_API_TOKEN']}").
      with(headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Host'=>'api.github.com',
        'User-Agent'=>'Ruby'
      }).
      to_return(status: 200, body: exloc_example_contents, headers: {})
  end
end
