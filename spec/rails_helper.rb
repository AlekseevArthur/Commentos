require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

require 'rspec/rails'

require 'devise'
require File.expand_path('spec/support/controller_macros.rb')

abort('The Rails environment is running in production mode!') if Rails.env.production?

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include Devise::Test::IntegrationHelpers, type: :feature
  config.extend ControllerMacros, type: :controller
  config.extend ControllerMacros, type: :request
  config.extend ControllerMacros, type: :feature
  config.include Devise::TestHelpers, type: :controller

  config.include FactoryBot::Syntax::Methods

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
