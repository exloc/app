require "rails_helper"

describe "sign in" do
  xdescribe "past oauth service utilized is highlighted"

  describe "via github" do
    let!(:user) { build(:user, nickname: 'billnye') }
    after { OmniAuth.config.mock_auth[:github] = nil }

    describe "successfully" do
      before { mock_omniauth(user, :github) }

      it "notifies the user they are authenticated" do
        visit new_session_path
        click_on "Sign in with GitHub"

        expect(page).to have_content "Welcome back, billnye/github!"
        expect(page).to have_link "Sign Out"
      end
    end

    describe "unsuccessfully" do
      before { OmniAuth.config.mock_auth[:github] = :invalid_credentials }

      it "notifies the user that there was a problem" do
        visit new_session_path
        click_on "Sign in with GitHub"

        expect(page).to have_content "invalid_credentials"
        expect(page).to have_link "Sign In"
      end
    end
  end
end
