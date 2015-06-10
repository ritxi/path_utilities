$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rspec'
require 'rspec/its'
require 'database_cleaner'
require 'byebug'

require 'path_utilities'

def support_file_path(file)
  File.join(File.expand_path('../support/', __FILE__), file)
end

Mongoid.load!(support_file_path('mongoid.yml'), :test)

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner[:mongoid].strategy = :truncation
    DatabaseCleaner[:mongoid].clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner[:mongoid].cleaning do
      example.run
    end
  end
end
