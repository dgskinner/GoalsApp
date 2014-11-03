RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
def sign_up(username, password)
  visit new_user_url
  fill_in("Username", with: username)
  fill_in("Password", with: password)
  click_button("Sign Up")
end

def help_me_gods
end
