include Warden::Test::Helpers

module FeatureHelpers
  def login
    User.where(email: "test@example.com").destroy_all
    @user = FactoryGirl.create(:user)
    login_as @user, scope: :user
    @user
  end
  def logout
    User.destroy_all
  end
end

RSpec.configure do |config|
  config.include FeatureHelpers, type: :feature
end