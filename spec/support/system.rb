# This tells RSpec how to run e2e tests. Specifically we'll use a tool called
# rack_test, which is provided by Capybara to simulate a browser DOM tree
# without JS

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end
end
