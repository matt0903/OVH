require 'vcr'
require 'webmock/rspec'

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = false
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
  c.configure_rspec_metadata!
  
  [:application_key, :application_secret, :consumer_key].each do |key|
    c.filter_sensitive_data(key.upcase) do |interaction|
      Ovh.configuration.send(key)
    end
  end
end
