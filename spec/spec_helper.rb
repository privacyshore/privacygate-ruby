require 'bundler/setup'
require 'webmock/rspec'
Bundler.setup
require 'privacygate'

def mock_item
  {:id => "val", :key => "val"}
end

def mock_list
  {
      :pagination => mock_item,
      :data => [mock_item, mock_item]
  }
end
