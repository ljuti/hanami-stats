# Require this file for feature tests
require_relative './spec_helper'

require 'capybara'
require 'capybara/rspec'

RSpec.configure do |config|
  config.include RSpec::FeatureExampleGroup

  config.include Capybara::DSL,           feature: true
  config.include Capybara::RSpecMatchers, feature: true

  config.before(:each) do
    parser = Parsers::CsvParser.new

    Dir.glob("data/*.csv") do |file|
      parser.parse(file)
    end
  end

  config.after(:each) do
    PlatformVersionRepository.clear
  end
end
