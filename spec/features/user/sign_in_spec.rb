require "rails_helper"

describe "sign in" do
  xdescribe "successfully"
  xdescribe "unsuccessfully"
  xdescribe "past oauth service utilized is highlighted"

  describe "via github, successfully" do
    let!(:user) { build(:user, provider: "github") }
    before { mock_omniauth(user) }

    it "notifies the user they are authenticated" do
      visit new_session_path
      click_on "Sign in with GitHub"

      expect(page).to have_content "Welcome back, #{user}!"
      expect(page).to have_link "Sign Out"
    end
  end

  describe "via github, unsuccessfully" do
    let!(:user) { build(:user, provider: "github") }

    before do
      OmniAuth.config.mock_auth[user.provider] = :invalid_credentials
    end

    it "notifies the user that there was a problem" do
      visit new_session_path
      click_on "Sign in with GitHub"

      expect(page).to have_content "There was a problem authenticating"
      expect(page).to have_link "Sign In"
    end
  end
end
